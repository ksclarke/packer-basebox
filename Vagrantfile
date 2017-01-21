# Vagrantfile for a generic base box

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  # VirtualBox: `vagrant up virtualbox-centos6`
  config.vm.define "virtualbox-centos6" do |virtualbox|
    virtualbox.vm.hostname = "virtualbox-basebox"
    virtualbox.vm.box = "ksclarke/basebox-centos6"

    virtualbox.vm.network :private_network, type: "dhcp"

    config.vm.provider :virtualbox do |v|
      v.gui = false
      v.memory = 1024
      v.cpus = 1
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
    end
  end

  # VirtualBox: `vagrant up virtualbox-rhel6`
  config.vm.define "virtualbox-rhel6" do |virtualbox|
    virtualbox.vm.hostname = "virtualbox-basebox"
    virtualbox.vm.box = "ksclarke/basebox-rhel6"

    virtualbox.vm.network :private_network, type: "dhcp"

    config.vm.provider :virtualbox do |v|
      v.gui = false
      v.memory = 1024
      v.cpus = 1
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
    end
  end

  # VMware Fusion: `vagrant up vmware-centos6 --provider=vmware_fusion`
  # VMware Workstation: `vagrant up vmware-centos6 --provider=vmware_workstation`
  config.vm.define "vmware-centos6" do |vmware|
    vmware.vm.hostname = "centos6-vmware"
    vmware.vm.box = "ksclarke/basebox-centos6"

    vmware.vm.network :private_network, type: "dhcp"

    config.vm.provider :vmware_fusion do |v, override|
      v.gui = false
      v.vmx["memsize"] = 1024
      v.vmx["numvcpus"] = 1
    end

    config.vm.provider :vmware_workstation do |v, override|
      v.gui = false
      v.vmx["memsize"] = 1024
      v.vmx["numvcpus"] = 1
    end
  end

end
