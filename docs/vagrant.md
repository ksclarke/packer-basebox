## Using the basebox with Vagrant
 
 The Vagrant baseboxes are published through Atlas.
 
 There are boxes for CentOS (https://atlas.hashicorp.com/ksclarke/boxes/basebox-centos6) and RHEL (https://atlas.hashicorp.com/ksclarke/boxes/basebox-rhel6).

#### Using VirtualBox

The instructions for using the CentOS basebox with VirtualBox are pretty simple:

    mkdir basebox-centos6
    vagrant init ksclarke/basebox-centos6
    vagrant up

Likewise, you can use the RHEL basebox with Virtualbox:

    mkdir basebox-centos6
    vagrant init ksclarke/basebox-rhel6
    vagrant up

Once it's up, you can login to the basebox using:

    vagrant ssh

It's worth nothing, you will not be able to install any additional software on your RHEL basebox without first registering it with the Red Hat Network.

To do that, from within the box, run:

    sudo subscription-manager register --auto-attach --username="[RHN_USERNAME]" --password="[RHN_PASSWORD]"
    
If you want to deregister the box at some point to free up your license slot, run:

    sudo subscription-manager unregister

#### Using VMWare

The instructions for using the basebox with VMWare are just a little more complicated.

If you're running on Windows or Linux and want to use the CentOS basebox, you'd use:

    mkdir basebox-centos6
    vagrant init ksclarke/basebox-centos6
    vagrant up --provider vmware_workstation
    
If you're running on Mac, you'd use:

    mkdir basebox-centos6
    vagrant init ksclarke/basebox-centos6
    vagrant up --provider vmware_fusion


If you're running on Windows or Linux and want to use the RHEL basebox, you'd use:

    mkdir basebox-rhel6
    vagrant init ksclarke/basebox-rhel6
    vagrant up --provider vmware_workstation
    
If you're running on Mac, you'd use:

    mkdir basebox-rhel6
    vagrant init ksclarke/basebox-rhel6
    vagrant up --provider vmware_fusion

You can login to the machine, register and deregister its RHN license slot just like you would on the Virtualbox basebox.