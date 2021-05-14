# Azure Infrastructure Operations Project: Deploying a scalable IaaS Web Server in Azure

* [Introduction](#introduction)
* [Instructions](#instructions)
* [Output](#output)

## Introduction
This project is part of the Udacity Azure ML Nanodegree.\
In order to deploy a customizable, scalable Web Server in Azure, Packer and Terraform is used. Instructions as well as the output is detailed below.

### Project Setup
Installations can be done via Homebrew (MacOS).
- Create Azure Account 
- Install Azure Command Line Interface
- Install Packer
- Install Terraform

## Instructions
### Policy
Before getting started, I created a policy that ensures all indexed resources are tagged and deny deployment if they do not.

It was created in the terminal (first screenshot) but also visible in the Azure portal (second screenshot). The policy is written in a `policy.json` file.

- Terminal:
![tagging-policy](./policy/tagging-policy.png)

- Portal:
![tagging-policy-portal](./policy/tagging-policy-portal.png)

### Packer
As a second step, I used Packer to create a server image in order to support the application deployment later on with Terraform. 

Instructions:
1. Log in to Azure CLI: `az login`.
2. Create Azure resource group for the server image: `az group create`. Alternatively done in the Azure portal.
3. Create Azure credentials for service principal: `az ad sp create-for-rbac`.
4. Define `server.json` packer template: This template builds an Ubuntu 16.04 LTS image, installs NGINX, then deprovisions the VM.
5. Set variabales: Either use the command line, use a file or use environment variables. I used the latter and set my environment variables as temporarily by using the `export` command in the terminal.
6. Build packer image by running `packer build server.json` in the terminal.

````
azure-arm: output will be in this color.

==> azure-arm: Running builder ...
==> azure-arm: Getting tokens using client secret
==> azure-arm: Getting tokens using client secret
    azure-arm: Creating Azure Resource Manager (ARM) client ...
==> azure-arm: WARNING: Zone resiliency may not be supported in germanywestcentral, checkout the docs at https://docs.microsoft.com/en-us/azure/availability-zones/
==> azure-arm: Creating resource group ...
==> azure-arm:  -> ResourceGroupName : 'pkr-Resource-Group-rtimj5lpny'
==> azure-arm:  -> Location          : 'germanywestcentral'
==> azure-arm:  -> Tags              :
==> azure-arm:  ->> udactiy : nanodegree
==> azure-arm: Validating deployment template ...
==> azure-arm:  -> ResourceGroupName : 'pkr-Resource-Group-rtimj5lpny'
==> azure-arm:  -> DeploymentName    : 'pkrdprtimj5lpny'
==> azure-arm: Deploying deployment template ...
==> azure-arm:  -> ResourceGroupName : 'pkr-Resource-Group-rtimj5lpny'
==> azure-arm:  -> DeploymentName    : 'pkrdprtimj5lpny'
==> azure-arm:
==> azure-arm: Getting the VM's IP address ...
==> azure-arm:  -> ResourceGroupName   : 'pkr-Resource-Group-rtimj5lpny'
==> azure-arm:  -> PublicIPAddressName : 'pkriprtimj5lpny'
==> azure-arm:  -> NicName             : 'pkrnirtimj5lpny'
==> azure-arm:  -> Network Connection  : 'PublicEndpoint'
==> azure-arm:  -> IP Address          : '51.116.170.136'
==> azure-arm: Waiting for SSH to become available...
==> azure-arm: Connected to SSH!
==> azure-arm: Provisioning with shell script: /var/folders/pc/v1v5sb6134n4nk9zlg21sj7h0000gn/T/packer-shell164069413
    azure-arm: Get:1 http://security.ubuntu.com/ubuntu xenial-security InRelease [109 kB]
    azure-arm: Hit:2 http://archive.ubuntu.com/ubuntu xenial InRelease
    azure-arm: Get:3 http://archive.ubuntu.com/ubuntu xenial-updates InRelease [109 kB]
    azure-arm: Get:4 http://archive.ubuntu.com/ubuntu xenial-backports InRelease [107 kB]
    azure-arm: Get:5 http://archive.ubuntu.com/ubuntu xenial/universe amd64 Packages [7532 kB]
    azure-arm: Get:6 http://security.ubuntu.com/ubuntu xenial-security/main amd64 Packages [1646 kB]
    azure-arm: Get:7 http://archive.ubuntu.com/ubuntu xenial/universe Translation-en [4354 kB]
    azure-arm: Get:8 http://security.ubuntu.com/ubuntu xenial-security/universe amd64 Packages [786 kB]
    azure-arm: Get:9 http://security.ubuntu.com/ubuntu xenial-security/universe Translation-en [226 kB]
    azure-arm: Get:10 http://security.ubuntu.com/ubuntu xenial-security/multiverse amd64 Packages [7864 B]
    azure-arm: Get:11 http://security.ubuntu.com/ubuntu xenial-security/multiverse Translation-en [2672 B]
    azure-arm: Get:12 http://archive.ubuntu.com/ubuntu xenial/multiverse amd64 Packages [144 kB]
    azure-arm: Get:13 http://archive.ubuntu.com/ubuntu xenial/multiverse Translation-en [106 kB]
    azure-arm: Get:14 http://archive.ubuntu.com/ubuntu xenial-updates/main amd64 Packages [2048 kB]
    azure-arm: Get:15 http://archive.ubuntu.com/ubuntu xenial-updates/main Translation-en [482 kB]
    azure-arm: Get:16 http://archive.ubuntu.com/ubuntu xenial-updates/universe amd64 Packages [1220 kB]
    azure-arm: Get:17 http://archive.ubuntu.com/ubuntu xenial-updates/universe Translation-en [358 kB]
    azure-arm: Get:18 http://archive.ubuntu.com/ubuntu xenial-updates/multiverse amd64 Packages [22.6 kB]
    azure-arm: Get:19 http://archive.ubuntu.com/ubuntu xenial-updates/multiverse Translation-en [8476 B]
    azure-arm: Get:20 http://archive.ubuntu.com/ubuntu xenial-backports/main amd64 Packages [9812 B]
    azure-arm: Get:21 http://archive.ubuntu.com/ubuntu xenial-backports/main Translation-en [4456 B]
    azure-arm: Get:22 http://archive.ubuntu.com/ubuntu xenial-backports/universe amd64 Packages [11.3 kB]
    azure-arm: Get:23 http://archive.ubuntu.com/ubuntu xenial-backports/universe Translation-en [4476 B]
    azure-arm: Fetched 19.3 MB in 3s (4837 kB/s)
    azure-arm: Reading package lists...
    azure-arm: Reading package lists...
    azure-arm: Building dependency tree...
    azure-arm: Reading state information...
    azure-arm: Calculating upgrade...
    azure-arm: The following package was automatically installed and is no longer required:
    azure-arm:   grub-pc-bin
    azure-arm: Use 'sudo apt autoremove' to remove it.
    azure-arm: The following packages will be upgraded:
    azure-arm:   bind9-host dnsutils libbind9-140 libdns-export162 libdns162 libisc-export160
    azure-arm:   libisc160 libisccc140 libisccfg140 liblwres141 libwbclient0 python-samba
    azure-arm:   samba-common samba-common-bin samba-libs
    azure-arm: 15 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
    azure-arm: Need to get 9008 kB of archives.
    azure-arm: After this operation, 27.6 kB disk space will be freed.
    azure-arm: Get:1 http://security.ubuntu.com/ubuntu xenial-security/main amd64 python-samba amd64 2:4.3.11+dfsg-0ubuntu0.16.04.34 [1061 kB]
    azure-arm: Get:2 http://security.ubuntu.com/ubuntu xenial-security/main amd64 samba-common-bin amd64 2:4.3.11+dfsg-0ubuntu0.16.04.34 [506 kB]
    azure-arm: Get:3 http://security.ubuntu.com/ubuntu xenial-security/main amd64 samba-libs amd64 2:4.3.11+dfsg-0ubuntu0.16.04.34 [5179 kB]
    azure-arm: Get:4 http://security.ubuntu.com/ubuntu xenial-security/main amd64 libwbclient0 amd64 2:4.3.11+dfsg-0ubuntu0.16.04.34 [30.5 kB]
    azure-arm: Get:5 http://security.ubuntu.com/ubuntu xenial-security/main amd64 samba-common all 2:4.3.11+dfsg-0ubuntu0.16.04.34 [84.1 kB]
    azure-arm: Get:6 http://security.ubuntu.com/ubuntu xenial-security/main amd64 libisc-export160 amd64 1:9.10.3.dfsg.P4-8ubuntu1.19 [153 kB]
    azure-arm: Get:7 http://security.ubuntu.com/ubuntu xenial-security/main amd64 libdns-export162 amd64 1:9.10.3.dfsg.P4-8ubuntu1.19 [665 kB]
    azure-arm: Get:8 http://security.ubuntu.com/ubuntu xenial-security/main amd64 bind9-host amd64 1:9.10.3.dfsg.P4-8ubuntu1.19 [38.3 kB]
    azure-arm: Get:9 http://security.ubuntu.com/ubuntu xenial-security/main amd64 dnsutils amd64 1:9.10.3.dfsg.P4-8ubuntu1.19 [88.9 kB]
    azure-arm: Get:10 http://security.ubuntu.com/ubuntu xenial-security/main amd64 libisc160 amd64 1:9.10.3.dfsg.P4-8ubuntu1.19 [215 kB]
    azure-arm: Get:11 http://security.ubuntu.com/ubuntu xenial-security/main amd64 libdns162 amd64 1:9.10.3.dfsg.P4-8ubuntu1.19 [872 kB]
    azure-arm: Get:12 http://security.ubuntu.com/ubuntu xenial-security/main amd64 libisccc140 amd64 1:9.10.3.dfsg.P4-8ubuntu1.19 [16.3 kB]
    azure-arm: Get:13 http://security.ubuntu.com/ubuntu xenial-security/main amd64 libisccfg140 amd64 1:9.10.3.dfsg.P4-8ubuntu1.19 [40.5 kB]
    azure-arm: Get:14 http://security.ubuntu.com/ubuntu xenial-security/main amd64 liblwres141 amd64 1:9.10.3.dfsg.P4-8ubuntu1.19 [33.9 kB]
    azure-arm: Get:15 http://security.ubuntu.com/ubuntu xenial-security/main amd64 libbind9-140 amd64 1:9.10.3.dfsg.P4-8ubuntu1.19 [23.6 kB]
==> azure-arm: debconf: unable to initialize frontend: Dialog
==> azure-arm: debconf: (Dialog frontend will not work on a dumb terminal, an emacs shell buffer, or without a controlling terminal.)
==> azure-arm: debconf: falling back to frontend: Readline
==> azure-arm: debconf: unable to initialize frontend: Readline
==> azure-arm: debconf: (This frontend requires a controlling tty.)
==> azure-arm: debconf: falling back to frontend: Teletype
    azure-arm: Fetched 9008 kB in 0s (30.9 MB/s)
==> azure-arm: dpkg-preconfigure: unable to re-open stdin:
    azure-arm: (Reading database ... 54076 files and directories currently installed.)
    azure-arm: Preparing to unpack .../python-samba_2%3a4.3.11+dfsg-0ubuntu0.16.04.34_amd64.deb ...
    azure-arm: Unpacking python-samba (2:4.3.11+dfsg-0ubuntu0.16.04.34) over (2:4.3.11+dfsg-0ubuntu0.16.04.32) ...
    azure-arm: Preparing to unpack .../samba-common-bin_2%3a4.3.11+dfsg-0ubuntu0.16.04.34_amd64.deb ...
    azure-arm: Unpacking samba-common-bin (2:4.3.11+dfsg-0ubuntu0.16.04.34) over (2:4.3.11+dfsg-0ubuntu0.16.04.32) ...
    azure-arm: Preparing to unpack .../samba-libs_2%3a4.3.11+dfsg-0ubuntu0.16.04.34_amd64.deb ...
    azure-arm: Unpacking samba-libs:amd64 (2:4.3.11+dfsg-0ubuntu0.16.04.34) over (2:4.3.11+dfsg-0ubuntu0.16.04.32) ...
    azure-arm: Preparing to unpack .../libwbclient0_2%3a4.3.11+dfsg-0ubuntu0.16.04.34_amd64.deb ...
    azure-arm: Unpacking libwbclient0:amd64 (2:4.3.11+dfsg-0ubuntu0.16.04.34) over (2:4.3.11+dfsg-0ubuntu0.16.04.32) ...
    azure-arm: Preparing to unpack .../samba-common_2%3a4.3.11+dfsg-0ubuntu0.16.04.34_all.deb ...
    azure-arm: Unpacking samba-common (2:4.3.11+dfsg-0ubuntu0.16.04.34) over (2:4.3.11+dfsg-0ubuntu0.16.04.32) ...
    azure-arm: Preparing to unpack .../libisc-export160_1%3a9.10.3.dfsg.P4-8ubuntu1.19_amd64.deb ...
    azure-arm: Unpacking libisc-export160 (1:9.10.3.dfsg.P4-8ubuntu1.19) over (1:9.10.3.dfsg.P4-8ubuntu1.18) ...
    azure-arm: Preparing to unpack .../libdns-export162_1%3a9.10.3.dfsg.P4-8ubuntu1.19_amd64.deb ...
    azure-arm: Unpacking libdns-export162 (1:9.10.3.dfsg.P4-8ubuntu1.19) over (1:9.10.3.dfsg.P4-8ubuntu1.18) ...
    azure-arm: Preparing to unpack .../bind9-host_1%3a9.10.3.dfsg.P4-8ubuntu1.19_amd64.deb ...
    azure-arm: Unpacking bind9-host (1:9.10.3.dfsg.P4-8ubuntu1.19) over (1:9.10.3.dfsg.P4-8ubuntu1.18) ...
    azure-arm: Preparing to unpack .../dnsutils_1%3a9.10.3.dfsg.P4-8ubuntu1.19_amd64.deb ...
    azure-arm: Unpacking dnsutils (1:9.10.3.dfsg.P4-8ubuntu1.19) over (1:9.10.3.dfsg.P4-8ubuntu1.18) ...
    azure-arm: Preparing to unpack .../libisc160_1%3a9.10.3.dfsg.P4-8ubuntu1.19_amd64.deb ...
    azure-arm: Unpacking libisc160:amd64 (1:9.10.3.dfsg.P4-8ubuntu1.19) over (1:9.10.3.dfsg.P4-8ubuntu1.18) ...
    azure-arm: Preparing to unpack .../libdns162_1%3a9.10.3.dfsg.P4-8ubuntu1.19_amd64.deb ...
    azure-arm: Unpacking libdns162:amd64 (1:9.10.3.dfsg.P4-8ubuntu1.19) over (1:9.10.3.dfsg.P4-8ubuntu1.18) ...
    azure-arm: Preparing to unpack .../libisccc140_1%3a9.10.3.dfsg.P4-8ubuntu1.19_amd64.deb ...
    azure-arm: Unpacking libisccc140:amd64 (1:9.10.3.dfsg.P4-8ubuntu1.19) over (1:9.10.3.dfsg.P4-8ubuntu1.18) ...
    azure-arm: Preparing to unpack .../libisccfg140_1%3a9.10.3.dfsg.P4-8ubuntu1.19_amd64.deb ...
    azure-arm: Unpacking libisccfg140:amd64 (1:9.10.3.dfsg.P4-8ubuntu1.19) over (1:9.10.3.dfsg.P4-8ubuntu1.18) ...
    azure-arm: Preparing to unpack .../liblwres141_1%3a9.10.3.dfsg.P4-8ubuntu1.19_amd64.deb ...
    azure-arm: Unpacking liblwres141:amd64 (1:9.10.3.dfsg.P4-8ubuntu1.19) over (1:9.10.3.dfsg.P4-8ubuntu1.18) ...
    azure-arm: Preparing to unpack .../libbind9-140_1%3a9.10.3.dfsg.P4-8ubuntu1.19_amd64.deb ...
    azure-arm: Unpacking libbind9-140:amd64 (1:9.10.3.dfsg.P4-8ubuntu1.19) over (1:9.10.3.dfsg.P4-8ubuntu1.18) ...
    azure-arm: Processing triggers for man-db (2.7.5-1) ...
    azure-arm: Processing triggers for libc-bin (2.23-0ubuntu11.2) ...
    azure-arm: Setting up libwbclient0:amd64 (2:4.3.11+dfsg-0ubuntu0.16.04.34) ...
    azure-arm: Setting up samba-libs:amd64 (2:4.3.11+dfsg-0ubuntu0.16.04.34) ...
    azure-arm: Setting up python-samba (2:4.3.11+dfsg-0ubuntu0.16.04.34) ...
    azure-arm: Setting up samba-common (2:4.3.11+dfsg-0ubuntu0.16.04.34) ...
    azure-arm: debconf: unable to initialize frontend: Dialog
    azure-arm: debconf: (Dialog frontend will not work on a dumb terminal, an emacs shell buffer, or without a controlling terminal.)
    azure-arm: debconf: falling back to frontend: Readline
    azure-arm: Setting up samba-common-bin (2:4.3.11+dfsg-0ubuntu0.16.04.34) ...
    azure-arm: Setting up libisc-export160 (1:9.10.3.dfsg.P4-8ubuntu1.19) ...
    azure-arm: Setting up libdns-export162 (1:9.10.3.dfsg.P4-8ubuntu1.19) ...
    azure-arm: Setting up libisc160:amd64 (1:9.10.3.dfsg.P4-8ubuntu1.19) ...
    azure-arm: Setting up libdns162:amd64 (1:9.10.3.dfsg.P4-8ubuntu1.19) ...
    azure-arm: Setting up libisccc140:amd64 (1:9.10.3.dfsg.P4-8ubuntu1.19) ...
    azure-arm: Setting up libisccfg140:amd64 (1:9.10.3.dfsg.P4-8ubuntu1.19) ...
    azure-arm: Setting up libbind9-140:amd64 (1:9.10.3.dfsg.P4-8ubuntu1.19) ...
    azure-arm: Setting up liblwres141:amd64 (1:9.10.3.dfsg.P4-8ubuntu1.19) ...
    azure-arm: Setting up bind9-host (1:9.10.3.dfsg.P4-8ubuntu1.19) ...
    azure-arm: Setting up dnsutils (1:9.10.3.dfsg.P4-8ubuntu1.19) ...
    azure-arm: Processing triggers for libc-bin (2.23-0ubuntu11.2) ...
    azure-arm: Reading package lists...
    azure-arm: Building dependency tree...
    azure-arm: Reading state information...
    azure-arm: The following package was automatically installed and is no longer required:
    azure-arm:   grub-pc-bin
    azure-arm: Use 'sudo apt autoremove' to remove it.
    azure-arm: The following additional packages will be installed:
    azure-arm:   nginx-common nginx-light
    azure-arm: Suggested packages:
    azure-arm:   fcgiwrap nginx-doc ssl-cert
    azure-arm: The following NEW packages will be installed:
    azure-arm:   nginx nginx-common nginx-light
    azure-arm: 0 upgraded, 3 newly installed, 0 to remove and 0 not upgraded.
    azure-arm: Need to get 345 kB of archives.
    azure-arm: After this operation, 1098 kB of additional disk space will be used.
    azure-arm: Get:1 http://security.ubuntu.com/ubuntu xenial-security/main amd64 nginx-common all 1.10.3-0ubuntu0.16.04.5 [26.9 kB]
    azure-arm: Get:2 http://security.ubuntu.com/ubuntu xenial-security/universe amd64 nginx-light amd64 1.10.3-0ubuntu0.16.04.5 [315 kB]
    azure-arm: Get:3 http://security.ubuntu.com/ubuntu xenial-security/main amd64 nginx all 1.10.3-0ubuntu0.16.04.5 [3494 B]
==> azure-arm: debconf: unable to initialize frontend: Dialog
==> azure-arm: debconf: (Dialog frontend will not work on a dumb terminal, an emacs shell buffer, or without a controlling terminal.)
==> azure-arm: debconf: falling back to frontend: Readline
==> azure-arm: debconf: unable to initialize frontend: Readline
==> azure-arm: debconf: (This frontend requires a controlling tty.)
==> azure-arm: debconf: falling back to frontend: Teletype
==> azure-arm: dpkg-preconfigure: unable to re-open stdin:
    azure-arm: Fetched 345 kB in 0s (3294 kB/s)
    azure-arm: Selecting previously unselected package nginx-common.
    azure-arm: (Reading database ... 54076 files and directories currently installed.)
    azure-arm: Preparing to unpack .../nginx-common_1.10.3-0ubuntu0.16.04.5_all.deb ...
    azure-arm: Unpacking nginx-common (1.10.3-0ubuntu0.16.04.5) ...
    azure-arm: Selecting previously unselected package nginx-light.
    azure-arm: Preparing to unpack .../nginx-light_1.10.3-0ubuntu0.16.04.5_amd64.deb ...
    azure-arm: Unpacking nginx-light (1.10.3-0ubuntu0.16.04.5) ...
    azure-arm: Selecting previously unselected package nginx.
    azure-arm: Preparing to unpack .../nginx_1.10.3-0ubuntu0.16.04.5_all.deb ...
    azure-arm: Unpacking nginx (1.10.3-0ubuntu0.16.04.5) ...
    azure-arm: Processing triggers for ureadahead (0.100.0-19.1) ...
    azure-arm: Processing triggers for systemd (229-4ubuntu21.31) ...
    azure-arm: Processing triggers for ufw (0.35-0ubuntu2) ...
    azure-arm: Processing triggers for man-db (2.7.5-1) ...
    azure-arm: Setting up nginx-common (1.10.3-0ubuntu0.16.04.5) ...
    azure-arm: debconf: unable to initialize frontend: Dialog
    azure-arm: debconf: (Dialog frontend will not work on a dumb terminal, an emacs shell buffer, or without a controlling terminal.)
    azure-arm: debconf: falling back to frontend: Readline
    azure-arm: Setting up nginx-light (1.10.3-0ubuntu0.16.04.5) ...
    azure-arm: Setting up nginx (1.10.3-0ubuntu0.16.04.5) ...
    azure-arm: Processing triggers for ureadahead (0.100.0-19.1) ...
    azure-arm: Processing triggers for systemd (229-4ubuntu21.31) ...
    azure-arm: Processing triggers for ufw (0.35-0ubuntu2) ...
    azure-arm: WARNING! The waagent service will be stopped.
    azure-arm: WARNING! Cached DHCP leases will be deleted.
    azure-arm: WARNING! root password will be disabled. You will not be able to login as root.
    azure-arm: WARNING! /etc/resolvconf/resolv.conf.d/tail and /etc/resolvconf/resolv.conf.d/original will be deleted.
    azure-arm: WARNING! packer account and entire home directory will be deleted.
==> azure-arm: Querying the machine's properties ...
==> azure-arm:  -> ResourceGroupName : 'pkr-Resource-Group-rtimj5lpny'
==> azure-arm:  -> ComputeName       : 'pkrvmrtimj5lpny'
==> azure-arm:  -> Managed OS Disk   : '/subscriptions/939dXXXXX/resourceGroups/pkr-Resource-Group-rtimj5lpny/providers/Microsoft.Compute/disks/pkrosrtimj5lpny'
==> azure-arm: Querying the machine's additional disks properties ...
==> azure-arm:  -> ResourceGroupName : 'pkr-Resource-Group-rtimj5lpny'
==> azure-arm:  -> ComputeName       : 'pkrvmrtimj5lpny'
==> azure-arm: Powering off machine ...
==> azure-arm:  -> ResourceGroupName : 'pkr-Resource-Group-rtimj5lpny'
==> azure-arm:  -> ComputeName       : 'pkrvmrtimj5lpny'
==> azure-arm: Capturing image ...
==> azure-arm:  -> Compute ResourceGroupName : 'pkr-Resource-Group-rtimj5lpny'
==> azure-arm:  -> Compute Name              : 'pkrvmrtimj5lpny'
==> azure-arm:  -> Compute Location          : 'germanywestcentral'
==> azure-arm:  -> Image ResourceGroupName   : 'udacity-rg'
==> azure-arm:  -> Image Name                : 'udacityPackerImage'
==> azure-arm:  -> Image Location            : 'germanywestcentral'
==> azure-arm: 
==> azure-arm: Deleting individual resources ...
==> azure-arm: Adding to deletion queue -> Microsoft.Compute/virtualMachines : 'pkrvmrtimj5lpny'
==> azure-arm: Adding to deletion queue -> Microsoft.Network/networkInterfaces : 'pkrnirtimj5lpny'
==> azure-arm: Adding to deletion queue -> Microsoft.Network/publicIPAddresses : 'pkriprtimj5lpny'
==> azure-arm: Adding to deletion queue -> Microsoft.Network/virtualNetworks : 'pkrvnrtimj5lpny'
==> azure-arm: Waiting for deletion of all resources...
==> azure-arm: Attempting deletion -> Microsoft.Network/virtualNetworks : 'pkrvnrtimj5lpny'
==> azure-arm: Attempting deletion -> Microsoft.Network/networkInterfaces : 'pkrnirtimj5lpny'
==> azure-arm: Attempting deletion -> Microsoft.Compute/virtualMachines : 'pkrvmrtimj5lpny'
==> azure-arm: Attempting deletion -> Microsoft.Network/publicIPAddresses : 'pkriprtimj5lpny'
==> azure-arm: Error deleting resource. Will retry.
==> azure-arm: Name: pkrvnrtimj5lpny
==> azure-arm: Error: network.VirtualNetworksClient#Delete: Failure sending request: StatusCode=400 -- Original Error: Code="InUseSubnetCannotBeDeleted" Message="Subnet pkrsnrtimj5lpny is in use by /subscriptions/939dXXXX/resourceGroups/pkr-Resource-Group-rtimj5lpny/providers/Microsoft.Network/networkInterfaces/pkrnirtimj5lpny/ipConfigurations/ipconfig and cannot be deleted. In order to delete the subnet, delete all the resources within the subnet. See aka.ms/deletesubnet." Details=[]
==> azure-arm:
==> azure-arm: Error deleting resource. Will retry.
==> azure-arm: Name: pkriprtimj5lpny
==> azure-arm: Error: network.PublicIPAddressesClient#Delete: Failure sending request: StatusCode=400 -- Original Error: Code="PublicIPAddressCannotBeDeleted" Message="Public IP address /subscriptions/939dXXXX/resourceGroups/pkr-Resource-Group-rtimj5lpny/providers/Microsoft.Network/publicIPAddresses/pkriprtimj5lpny can not be deleted since it is still allocated to resource /subscriptions/939dXXXX/resourceGroups/pkr-Resource-Group-rtimj5lpny/providers/Microsoft.Network/networkInterfaces/pkrnirtimj5lpny/ipConfigurations/ipconfig. In order to delete the public IP, disassociate/detach the Public IP address from the resource.  To learn how to do this, see aka.ms/deletepublicip." Details=[]
==> azure-arm:
==> azure-arm: Attempting deletion -> Microsoft.Network/virtualNetworks : 'pkrvnrtimj5lpny'
==> azure-arm: Attempting deletion -> Microsoft.Network/publicIPAddresses : 'pkriprtimj5lpny'
==> azure-arm:  Deleting -> Microsoft.Compute/disks : '/subscriptions/939dXXXX/resourceGroups/pkr-Resource-Group-rtimj5lpny/providers/Microsoft.Compute/disks/pkrosrtimj5lpny'
==> azure-arm: Removing the created Deployment object: 'pkrdprtimj5lpny'
==> azure-arm: 
==> azure-arm: Cleanup requested, deleting resource group ...
==> azure-arm: Resource group has been deleted.
Build 'azure-arm' finished after 6 minutes 55 seconds.

=> Wait completed after 6 minutes 55 seconds

==> Builds finished. The artifacts of successful builds are:
--> azure-arm: Azure.ResourceManagement.VMImage:

OSType: Linux
ManagedImageResourceGroupName: udacity-rg
ManagedImageName: udacityPackerImage
ManagedImageId: /subscriptions/939dXXXX/resourceGroups/udacity-rg/providers/Microsoft.Compute/images/udacityPackerImage
ManagedImageLocation: germanywestcentral
````

- Portal:
![packer](./packer/packer.png)

### Terraform
As a final step, I used Terraform to deploy the Azure Web Server Infrastructure. The crucial part is to write the appropriate Packer and Terraform templates (`server.json` and `main.tf`), then, it is possible to use a service principle in Azure to deploy the Virtual Machine Image using Packer.\

In general, Terraform allows anyone to reliably create, update and destroy an application (in my case an Azure Web Server). To do this, a `main.tf` and a `variables.tf` file needs to be created. The `main.tf` file, as the mame suggests, represents the main code, whereas the `variables.tf` file holds certain variables as a complementary file to the main code. The idea is to change easily certain parameters if needed without changing the core of the terraform file. For instance, the number of Virtual Machines needed is very use case depended. This means, the number of Virtual Machines cannot be implemented in the `main.tf` file without `hard coding` it in there. As good programming should follow the DRY priniciple ("do not repeat yourself), it's better to have such a setting outside of the `main.tf` file, hence the idea of a `variables.tf` file. 

Instructions:
1. Execute `terraform init` in your specific directory. This has to be done only once as it initiates the terraform environment. 
2. Change the `variables.tf` file according to your needs. I pre-defined the `prefix`, `tags`, `number of VMs`, `username`, `password` and `location` as variables. The variables are used in the `main.tf` file.
- `prefix`: This can be changed to the specific project name in mind. In my case this defaults to "udacity-proj".
- `tags`: Tags are arbitrary key-value pairs can be utilized for billing, ownership, automation, access control, and many other use cases. In my case these tags default to Environment = "dev-env" and Project = "uda-proj", although all four expressions ca be changed to anyone's use case.
- `number of VMs`: This is the number of Virtual machines created behind the load balancers. In my case this defaults to two Virtual Machines but can be changed if necessary. 
- `username`: This is the user name to log in to your VM. This will be created by the user once the user executes `terraform apply`. 
- `password`: This is the password for the user name to log in to your VM. This will be created by the user once the user executes `terraform apply`. 
- `location`: This is the region in which all resources will be created. In my case this defaults to 'germanywestcentral'.
- Many more variables can be added accordingly depending on the specific use case at hand.
3. Change the `main.tf` file according to your needs. Important note here: The image name of the packer file needs to be consitent in both files (`server.json` and `main.tf`). In my case, this is: `udacityPackerImage`.
4. Execute `terraform plan`. This will pre-check your specific terraform build and outputs any error identified (e.g. a missing or unsupported arguments in your code). This is super helpfull to debugg your code.
5. Exectue `terraform apply`. This will deploy all the resources in your Azure subscription.
6. Open any browser and run the given load balancer public IP adress to get access to the Azure Web Server. The IP adress can be found in one of the last lines of the `terraform apply` output.
7. Execute `terraform destroy` to shut down the whole infrastructure if you don't need it anymore.

This is the ouput when executing `terraform plan -out solution.plan`:

`````
Terraform will perform the following actions:

  # azurerm_availability_set.main will be created
  + resource "azurerm_availability_set" "main" {
      + id                           = (known after apply)
      + location                     = "germanywestcentral"
      + managed                      = true
      + name                         = "udacity-proj-avaset"
      + platform_fault_domain_count  = 2
      + platform_update_domain_count = 5
      + resource_group_name          = "udacity-proj-TFRG"
      + tags                         = {
          + "Environment" = "dev-env"
          + "Project"     = "uda-proj"
        }
    }

  # azurerm_lb.main will be created
  + resource "azurerm_lb" "main" {
      + id                   = (known after apply)
      + location             = "germanywestcentral"
      + name                 = "udacity-proj-LB"
      + private_ip_address   = (known after apply)
      + private_ip_addresses = (known after apply)
      + resource_group_name  = "udacity-proj-TFRG"
      + sku                  = "Basic"
      + tags                 = {
          + "Environment" = "dev-env"
          + "Project"     = "uda-proj"
        }

      + frontend_ip_configuration {
          + id                            = (known after apply)
          + inbound_nat_rules             = (known after apply)
          + load_balancer_rules           = (known after apply)
          + name                          = "PublicIPAddress"
          + outbound_rules                = (known after apply)
          + private_ip_address            = (known after apply)
          + private_ip_address_allocation = (known after apply)
          + private_ip_address_version    = "IPv4"
          + public_ip_address_id          = (known after apply)
          + public_ip_prefix_id           = (known after apply)
          + subnet_id                     = (known after apply)
        }
    }

  # azurerm_lb_backend_address_pool.main will be created
  + resource "azurerm_lb_backend_address_pool" "main" {
      + backend_ip_configurations = (known after apply)
      + id                        = (known after apply)
      + load_balancing_rules      = (known after apply)
      + loadbalancer_id           = (known after apply)
      + name                      = "udacity-proj-backendAddrPool"
      + outbound_rules            = (known after apply)
      + resource_group_name       = (known after apply)
    }

  # azurerm_lb_probe.main will be created
  + resource "azurerm_lb_probe" "main" {
      + id                  = (known after apply)
      + interval_in_seconds = 15
      + load_balancer_rules = (known after apply)
      + loadbalancer_id     = (known after apply)
      + name                = "http-probe"
      + number_of_probes    = 2
      + port                = 80
      + protocol            = (known after apply)
      + resource_group_name = "udacity-proj-TFRG"
    }

  # azurerm_lb_rule.main will be created
  + resource "azurerm_lb_rule" "main" {
      + backend_address_pool_id        = (known after apply)
      + backend_port                   = 80
      + disable_outbound_snat          = false
      + enable_floating_ip             = false
      + frontend_ip_configuration_id   = (known after apply)
      + frontend_ip_configuration_name = "PublicIPAddress"
      + frontend_port                  = 80
      + id                             = (known after apply)
      + idle_timeout_in_minutes        = (known after apply)
      + load_distribution              = (known after apply)
      + loadbalancer_id                = (known after apply)
      + name                           = "HTTP"
      + probe_id                       = (known after apply)
      + protocol                       = "Tcp"
      + resource_group_name            = "udacity-proj-TFRG"
    }

  # azurerm_managed_disk.main[0] will be created
  + resource "azurerm_managed_disk" "main" {
      + create_option        = "Empty"
      + disk_iops_read_write = (known after apply)
      + disk_mbps_read_write = (known after apply)
      + disk_size_gb         = 1
      + id                   = (known after apply)
      + location             = "germanywestcentral"
      + name                 = "udacity-proj-datadisk-0"
      + resource_group_name  = "udacity-proj-TFRG"
      + source_uri           = (known after apply)
      + storage_account_type = "Standard_LRS"
    }

  # azurerm_managed_disk.main[1] will be created
  + resource "azurerm_managed_disk" "main" {
      + create_option        = "Empty"
      + disk_iops_read_write = (known after apply)
      + disk_mbps_read_write = (known after apply)
      + disk_size_gb         = 1
      + id                   = (known after apply)
      + location             = "germanywestcentral"
      + name                 = "udacity-proj-datadisk-1"
      + resource_group_name  = "udacity-proj-TFRG"
      + source_uri           = (known after apply)
      + storage_account_type = "Standard_LRS"
    }

  # azurerm_network_interface.main[0] will be created
  + resource "azurerm_network_interface" "main" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "germanywestcentral"
      + mac_address                   = (known after apply)
      + name                          = "udacity-proj-NIC-0"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "udacity-proj-TFRG"
      + tags                          = {
          + "Environment" = "dev-env"
          + "Project"     = "uda-proj"
        }
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + name                          = "internal"
          + primary                       = true
          + private_ip_address            = (known after apply)
          + private_ip_address_allocation = "dynamic"
          + private_ip_address_version    = "IPv4"
          + subnet_id                     = (known after apply)
        }
    }

  # azurerm_network_interface.main[1] will be created
  + resource "azurerm_network_interface" "main" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "germanywestcentral"
      + mac_address                   = (known after apply)
      + name                          = "udacity-proj-NIC-1"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "udacity-proj-TFRG"
      + tags                          = {
          + "Environment" = "dev-env"
          + "Project"     = "uda-proj"
        }
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + name                          = "internal"
          + primary                       = true
          + private_ip_address            = (known after apply)
          + private_ip_address_allocation = "dynamic"
          + private_ip_address_version    = "IPv4"
          + subnet_id                     = (known after apply)
        }
    }

  # azurerm_network_interface_backend_address_pool_association.main[0] will be created
  + resource "azurerm_network_interface_backend_address_pool_association" "main" {
      + backend_address_pool_id = (known after apply)
      + id                      = (known after apply)
      + ip_configuration_name   = "internal"
      + network_interface_id    = (known after apply)
    }

  # azurerm_network_interface_backend_address_pool_association.main[1] will be created
  + resource "azurerm_network_interface_backend_address_pool_association" "main" {
      + backend_address_pool_id = (known after apply)
      + id                      = (known after apply)
      + ip_configuration_name   = "internal"
      + network_interface_id    = (known after apply)
    }

  # azurerm_network_security_group.main will be created
  + resource "azurerm_network_security_group" "main" {
      + id                  = (known after apply)
      + location            = "germanywestcentral"
      + name                = "udacity-proj-TFNSG"
      + resource_group_name = "udacity-proj-TFRG"
      + security_rule       = (known after apply)
      + tags                = {
          + "Environment" = "dev-env"
          + "Project"     = "uda-proj"
        }
    }

  # azurerm_network_security_rule.Allow_VNet_Traffic will be created
  + resource "azurerm_network_security_rule" "Allow_VNet_Traffic" {
      + access                      = "Allow"
      + destination_address_prefix  = "*"
      + destination_port_range      = "*"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "VNet_Traffic"
      + network_security_group_name = "udacity-proj-TFNSG"
      + priority                    = 1001
      + protocol                    = "TCP"
      + resource_group_name         = "udacity-proj-TFRG"
      + source_address_prefix       = "*"
      + source_port_range           = "1001"
    }

  # azurerm_network_security_rule.Deny_Internet_Traffic will be created
  + resource "azurerm_network_security_rule" "Deny_Internet_Traffic" {
      + access                      = "Deny"
      + destination_address_prefix  = "*"
      + destination_port_range      = "*"
      + direction                   = "Inbound"
      + id                          = (known after apply)
      + name                        = "Internet_Traffic"
      + network_security_group_name = "udacity-proj-TFNSG"
      + priority                    = 1002
      + protocol                    = "*"
      + resource_group_name         = "udacity-proj-TFRG"
      + source_address_prefix       = "*"
      + source_port_range           = "*"
    }

  # azurerm_public_ip.main will be created
  + resource "azurerm_public_ip" "main" {
      + allocation_method       = "Static"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "germanywestcentral"
      + name                    = "udacity-proj-TFPublicIP"
      + resource_group_name     = "udacity-proj-TFRG"
      + sku                     = "Basic"
      + tags                    = {
          + "Environment" = "dev-env"
          + "Project"     = "uda-proj"
        }
    }

  # azurerm_resource_group.main will be created
  + resource "azurerm_resource_group" "main" {
      + id       = (known after apply)
      + location = "germanywestcentral"
      + name     = "udacity-proj-TFRG"
      + tags     = {
          + "Environment" = "dev-env"
          + "Project"     = "uda-proj"
        }
    }

  # azurerm_subnet.main will be created
  + resource "azurerm_subnet" "main" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "10.0.1.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "udacity-proj-TFSubnet"
      + resource_group_name                            = "udacity-proj-TFRG"
      + virtual_network_name                           = "udacity-proj-TFVnet"
    }

  # azurerm_subnet_network_security_group_association.main will be created
  + resource "azurerm_subnet_network_security_group_association" "main" {
      + id                        = (known after apply)
      + network_security_group_id = (known after apply)
      + subnet_id                 = (known after apply)
    }

  # azurerm_virtual_machine.main[0] will be created
  + resource "azurerm_virtual_machine" "main" {
      + availability_set_id              = (known after apply)
      + delete_data_disks_on_termination = false
      + delete_os_disk_on_termination    = false
      + id                               = (known after apply)
      + license_type                     = (known after apply)
      + location                         = "germanywestcentral"
      + name                             = "udacity-proj-TFVM-0"
      + network_interface_ids            = (known after apply)
      + resource_group_name              = "udacity-proj-TFRG"
      + tags                             = {
          + "Environment" = "dev-env"
          + "Project"     = "uda-proj"
        }
      + vm_size                          = "Standard_DS1_v2"

      + identity {
          + identity_ids = (known after apply)
          + principal_id = (known after apply)
          + type         = (known after apply)
        }

      + os_profile {
          + admin_password = (sensitive value)
          + admin_username = "chrzorn-1234"
          + computer_name  = "udacity-proj-TFVM"
          + custom_data    = (known after apply)
        }

      + os_profile_linux_config {
          + disable_password_authentication = false
        }

      + storage_data_disk {
          + caching                   = (known after apply)
          + create_option             = (known after apply)
          + disk_size_gb              = (known after apply)
          + lun                       = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = (known after apply)
          + name                      = (known after apply)
          + vhd_uri                   = (known after apply)
          + write_accelerator_enabled = (known after apply)
        }

      + storage_image_reference {
          + id      = "/subscriptions/939dXXXX/resourceGroups/udacity-rg/providers/Microsoft.Compute/images/udacityPackerImage"
          + version = (known after apply)
        }

      + storage_os_disk {
          + caching                   = "ReadWrite"
          + create_option             = "FromImage"
          + disk_size_gb              = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = "Premium_LRS"
          + name                      = "udacity-proj-OsDisk-0"
          + os_type                   = (known after apply)
          + write_accelerator_enabled = false
        }
    }

  # azurerm_virtual_machine.main[1] will be created
  + resource "azurerm_virtual_machine" "main" {
      + availability_set_id              = (known after apply)
      + delete_data_disks_on_termination = false
      + delete_os_disk_on_termination    = false
      + id                               = (known after apply)
      + license_type                     = (known after apply)
      + location                         = "germanywestcentral"
      + name                             = "udacity-proj-TFVM-1"
      + network_interface_ids            = (known after apply)
      + resource_group_name              = "udacity-proj-TFRG"
      + tags                             = {
          + "Environment" = "dev-env"
          + "Project"     = "uda-proj"
        }
      + vm_size                          = "Standard_DS1_v2"

      + identity {
          + identity_ids = (known after apply)
          + principal_id = (known after apply)
          + type         = (known after apply)
        }

      + os_profile {
          + admin_password = (sensitive value)
          + admin_username = "czofficial"
          + computer_name  = "udacity-proj-TFVM"
          + custom_data    = (known after apply)
        }

      + os_profile_linux_config {
          + disable_password_authentication = false
        }

      + storage_data_disk {
          + caching                   = (known after apply)
          + create_option             = (known after apply)
          + disk_size_gb              = (known after apply)
          + lun                       = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = (known after apply)
          + name                      = (known after apply)
          + vhd_uri                   = (known after apply)
          + write_accelerator_enabled = (known after apply)
        }

      + storage_image_reference {
          + id      = "/subscriptions/939dXXXX/resourceGroups/udacity-rg/providers/Microsoft.Compute/images/udacityPackerImage"
          + version = (known after apply)
        }

      + storage_os_disk {
          + caching                   = "ReadWrite"
          + create_option             = "FromImage"
          + disk_size_gb              = (known after apply)
          + managed_disk_id           = (known after apply)
          + managed_disk_type         = "Premium_LRS"
          + name                      = "udacity-proj-OsDisk-1"
          + os_type                   = (known after apply)
          + write_accelerator_enabled = false
        }
    }

  # azurerm_virtual_machine_data_disk_attachment.main[0] will be created
  + resource "azurerm_virtual_machine_data_disk_attachment" "main" {
      + caching                   = "ReadWrite"
      + create_option             = "Attach"
      + id                        = (known after apply)
      + lun                       = 0
      + managed_disk_id           = (known after apply)
      + virtual_machine_id        = (known after apply)
      + write_accelerator_enabled = false
    }

  # azurerm_virtual_machine_data_disk_attachment.main[1] will be created
  + resource "azurerm_virtual_machine_data_disk_attachment" "main" {
      + caching                   = "ReadWrite"
      + create_option             = "Attach"
      + id                        = (known after apply)
      + lun                       = 10
      + managed_disk_id           = (known after apply)
      + virtual_machine_id        = (known after apply)
      + write_accelerator_enabled = false
    }

  # azurerm_virtual_network.main will be created
  + resource "azurerm_virtual_network" "main" {
      + address_space         = [
          + "10.0.0.0/16",
        ]
      + guid                  = (known after apply)
      + id                    = (known after apply)
      + location              = "germanywestcentral"
      + name                  = "udacity-proj-TFVnet"
      + resource_group_name   = "udacity-proj-TFRG"
      + subnet                = (known after apply)
      + tags                  = {
          + "Environment" = "dev-env"
          + "Project"     = "uda-proj"
        }
      + vm_protection_enabled = false
    }

Plan: 23 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + lb_url = (known after apply)
`````

## Output
### Terraform
When executing `terraform apply solution.plan`, the URL of the web server will be shown at the end of the whole creation process.
`````
Apply complete! Resources: 23 added, 0 changed, 0 destroyed.

Outputs:

lb_url = "http://20.52.239.110/"
`````

### Azure Web Server
This is a screenshot of the deployed Web Server when calling the public IP of the load balancer:
![url](./terraform/url.png)

### Resource Group in Azure Portal
This is a screenshot of the created resource group with all deployed resources:
![portal](./terraform/portal.png)

- Deletion of the whole Web Server Infrastructure: This can be done by executing `terraform destroy` in the terminal. `terraform show` verifies that everything has been destroyed (empty list as an output).