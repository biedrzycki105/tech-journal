# Install vCenter and Add a Datacenter

## Setup

* SuperMicro Server
  * 64GB RAM
  * 500GB Storage
  * ESXi Installed
* ESXi Host Configuration
  * ISO directory created with ISOs present
  * \[\[480-FW]] configured
  * \[\[Xubuntu]] box created
  * Windows Server ISO in ISOs folder
  * Configure Domain Controller w/ ADDS, DNS, DHCP
* Login to ESXi Host

## Step-by-Step

* Mount the ISO file to the CD/ROM drive on the **xubuntu-wan** machine. Go to Actions > Edit Settings > Datastore ISO > datastore1-super27/ISOs/VMware-VCSA-all-8.0.0-20519528.iso
* Log into **xubuntu-wan** and find the vCenter installer at **/media/xubuntu-wan/VMware VCSA/vcsa-ui-installer/lin64/installer-linux.desktop**
* Follow the installation wizard and fill in the appropriate information:
  * Stage 1
    * ![image](https://user-images.githubusercontent.com/90063737/217422273-52e4f8b5-2432-4850-a10d-407ff4a31547.png)
    * ![image](https://user-images.githubusercontent.com/90063737/217423373-dcf2e391-556b-4cff-8b59-f61896e62b0f.png)
    * ![image](https://user-images.githubusercontent.com/90063737/217423464-588495b0-e1fe-4172-8a1f-89b2d9ffdcf9.png)
    * ![image](https://user-images.githubusercontent.com/90063737/217423656-e15a58fb-fc76-434f-9263-91ca93edc05c.png)
    * ![image](https://user-images.githubusercontent.com/90063737/217424188-2d47df18-db1d-4847-adfc-7baa96e5132f.png)
  * Stage 2
    * ![image](https://user-images.githubusercontent.com/90063737/217429128-2ea01322-f669-4262-ae5b-a8283934aed4.png)
    * ![image](https://user-images.githubusercontent.com/90063737/217430345-a8d161db-5b14-40a8-a7be-3c90866897dc.png)
* Confirm the information on the final screen and make sure all the network information matches
* Log into vCenter by going to `http://vcenter.erik.local` and using your `administrator@vsphere.local` credentials
* Right-click your vCenter box on the left side of the screen and add a new datacenter. Datacenters hold ESXi hosts, and we will add our ESXi host to our first datacenter.
  * ![image](https://user-images.githubusercontent.com/90063737/217433716-b792249c-adcc-4c6b-bdd5-879f183a6efd.png)
* Right-click the new datacenter and add the host. Enter the information so that it your screen looks like this:
  * ![image](https://user-images.githubusercontent.com/90063737/217434218-f9444fe7-9119-4e90-bc9f-fab8023071b9.png)
