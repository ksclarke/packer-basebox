## Using the basebox in OVA form

The OVA (Open Virtualization Format) baseboxes are published through Atlas.

There are VirtualBox and VMWare downloads for CentOS (https://atlas.hashicorp.com/ksclarke/artifacts/basebox-centos6) and RHEL (https://atlas.hashicorp.com/ksclarke/artifacts/basebox-rhel6).

An OVA file can be used to load a virtual machine into VirtualBox or VMWare. It can also be used as an input to a Packer build process (with the following naming convention and simple download script).

An example of the convention is below.

    "builders": [
      {
        "name": "virtualbox-centos6",
        "type": "virtualbox-ovf",
        "source_path": "packer_cache/atlas/ksclarke/basebox-centos6/5.ova",
        "ssh_username": "{{ user `ssh-username` }}",
        "ssh_password": "{{ user `ssh-password` }}",
        "shutdown_command": "echo '{{ user `ssh-password` }}' | /usr/bin/sudo -S shutdown -P now",
        "vm_name": "centos6-{{ user `el-6x-version` }}-x86_64",
        "headless": true,
        "vboxmanage": [
          [ "modifyvm", "{{ .Name }}", "--memory", "512" ],
          [ "modifyvm", "{{ .Name }}", "--cpus", "1" ]
        ]
      }
    ]

This would be used by the following script to download the appropriate OVA file from Atlas and feed it to a new Packer build:

    #! /bin/bash
    
    #
    # A Bash script to run a Packer.io build
    #
    
    # Some default variables used by the script
    GREEN='\033[1;32m'
    RED='\033[0;31m'
    NC='\033[0m'
    INT_REGEXP='^[0-9]+$'
    
    # The location of Atlas artifacts API
    ATLAS_API="https://atlas.hashicorp.com/api/v1/artifacts"
    
    # Check to make sure our script dependencies are installed before we proceed
    hash jq 2>/dev/null || { printf "${RED}Error: I require jq but it's not installed${NC}\n" >&2; exit 1; }
    
    # Assumes the only JSON file in our project directory is the Packer.io config file
    SOURCE_PATH=$(jq -r ".[\"builders\"][] | select(.name==\"$1\") | .source_path" *.json)
    SOURCE_TYPE=$(jq -r ".[\"builders\"][] | select(.name==\"$1\") | .type" *.json)
    
    # Fail the script, clean up artifact cache, and output some useful message
    clean_fail() {
      rm "$2"; fail "$1"
    }
    
    # Fail the script and output some useful message
    fail() {
      printf "${RED}${1}${NC}\n" >&2; exit 1
    }
    
    # Download the OVA artifact source from Atlas
    download_source_from_atlas() {
      ARTIFACT_CACHE="packer_cache/atlas/${1}.ova"
      SLASHES=$(grep -o "/" <<< "$1" | wc -l)
    
      if [ "$SLASHES" != "2" ]; then
        fail "Error: Expected packer_cache/atlas/[ATLAS_USER]/[ARTIFACT_ID]/[ARTIFACT_VERSION] but found: ${1}"
      fi
    
      ATLAS_USER=$(echo $1 | cut -d "/" -f 1)
      ARTIFACT_ID=$(echo $1 | cut -d "/" -f 2)
      SOURCE_VERSION=$(echo $1 | cut -d "/" -f 3)
    
      # Confirm our version number is an integer
      if [[ ! $SOURCE_VERSION =~ $INT_REGEXP ]]; then fail "Error: Version is not an integer: $SOURCE_VERSION"; fi
    
      # Construct correct Atlas API call depending on source type
      if [[ "$2" == "virtualbox-ovf" ]]; then
        URL="${ATLAS_API}/${ATLAS_USER}/${ARTIFACT_ID}/virtualbox.image/${SOURCE_VERSION}/file"
      elif [[ "$2" == "vmware-vmx" ]]; then
        URL="${ATLAS_API}/${ATLAS_USER}/${ARTIFACT_ID}/vmware.image/${SOURCE_VERSION}/file"
      else
        fail "Error: Unexpected artifact download type: ${2}"
      fi
    
      # Make sure directory structure is set up for our downloaded file
      mkdir -p "$ARTIFACT_CACHE"
      if [ -d "$ARTIFACT_CACHE" ]; then rmdir "$ARTIFACT_CACHE"; else exit 0; fi
    
      # Download artifact file
      printf "Downloading \"${URL}\" to: packer_cache/atlas/${1}.ova\n"
      curl -L# "$URL" > "$ARTIFACT_CACHE"
    
      # Check if downloaded file is empty
      if [ ! -s "$ARTIFACT_CACHE" ]; then
        clean_fail "Error: Downloaded file is empty" "$ARTIFACT_CACHE"
      fi
    
      # Check if file contains an error message
      if [[ $(head -c 1 "$ARTIFACT_CACHE") == "{" ]] && [[ $(jq '.success' "$ARTIFACT_CACHE") == "false" ]]; then
        MESSAGE=$(jq '.errors[0]' "$ARTIFACT_CACHE")
        clean_fail "Error: Download of artifact failed: ${MESSAGE}" "$ARTIFACT_CACHE"
      else
        mv "$ARTIFACT_CACHE" "${ARTIFACT_CACHE}.gz"
        gunzip "$ARTIFACT_CACHE"
      fi
    }
    
    # If our source path is expecting a downloaded file
    if [[ "$SOURCE_PATH" == "packer_cache/atlas/"* ]] && [ ! -e "$SOURCE_PATH" ]; then
      download_source_from_atlas "$(echo ${SOURCE_PATH#*atlas/} | rev | cut -f 2- -d '.' | rev)" "$SOURCE_TYPE"
    fi
    
    # Run Packer.io
    packer build -only "$1" *.json
    
I put this script in a `scripts` folder in my Packer project and then run a Packer build from it. I should probably create a packer-template project and put this script in there, but at this time it just lives in individual Packer projects that use the packer-basebox as its source.