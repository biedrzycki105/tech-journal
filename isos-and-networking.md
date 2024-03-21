# ISOs and Networking

## Summary

We are going to rename the default datastore and add a folder called _**ISOs**_. We are then going to use an SSH connection from a jump box to our ESXi host to pull ISOs into our ISOs folder. After having the proper ISOs, we are going to create and configure a virtual switch for our WAN with port groups.

## Setup

* SuperMicro Server
  * 64GB RAM
  * 500GB Storage
  * ESXi Installed
* Login to ESXi Host

## Step-by-step

* Renaming the datastore
  * After logging into the ESXi host, find the _**Storage**_ tab on the left side of the screen and expand it.
  * Right-click on the pre-existing datastore and click _**Rename**_.
    * ![image](https://user-images.githubusercontent.com/90063737/214594143-6f163e79-9a67-453f-8bbb-a2692345ade6.png)
  * Rename the datastore to something unique to the ESXi host, like _**datastore1-super27**_
  * We are renaming our datastore so that if we have multiple ESXi hosts, we do not have multiple datastores called _**datastore1**_. It just saves a lot of work and confusion in the future and is generally a good practice to get into.
* Adding _**ISOs**_ Folder
  * In the _**Storage**_ tab, click the datastore, and then open the _Datastore Browser_.
  * Select _**Create Directory**_ and name the new directory _**ISOs**_.
    * ![image](https://user-images.githubusercontent.com/90063737/214594531-5bd56a8a-a8b6-43b0-b9d8-72acf345dcb2.png)
* Pulling ISOs into _**ISOs**_
  * Before creating an SSH connection, we need to allow SSH connections to the ESXi host. From the home page on the ESXi host, select _**Actions**_** > **_**Services**_** > **_**Enable Secure Shell (SSH)**_
    * ![image](https://user-images.githubusercontent.com/90063737/214598015-d3696d69-28fd-434a-b6a0-2985b1a725fe.png)
  * Using a jump box, start an SSH connection to the ESXi host with the command `ssh root@ESXI_HOST_IP`.
  * Navigate to the ISOs folder in the datastore and make that your present working directory
    * ![image](https://user-images.githubusercontent.com/90063737/214600078-d086d21d-cb90-44c7-a187-82573f2fa651.png)
  * From the jump box, open a browser and locate Devin's ISOs. Copy the link address to the ISO you need.
  * Return to the SSH session to your ESXi host. Use the command `wget LINK_TO_ISO`. You should be able to copy the link address of the ISO and paste it into the terminal
  * Repeat this process for whatever ISOs you need.
  * ![image](https://user-images.githubusercontent.com/90063737/214602509-41078c09-1793-4e4a-8331-89c88c1d69cb.png)
* Creating and Configuring A New Virtual Switch
  * A virtual switch is a networking tool that operates similarly to a physical layer 2 switch, minus some key differences. Virtual switches use logical ports rather than physical ports, so that creates a difference in capability and applicability.
    * Similarities
      * Maintains a MAC forwarding table
      * Looks up each frame’s destination MAC when it arrives.
      * Forwards a frame to one or more ports for transmission.
      * Avoids unnecessary deliveries (in other words, it is not a hub)
    * Differences
      * Virtual Switch Isolation - Virtual switches cannot be connected to each other. This eliminates the need for Spanning Tree Protocol because switching loops cannot happen. Also, because virtual switches cannot share physical Ethernet adapters, there is no way to fool the Ethernet adapter into doing loopback or some similar configuration that would cause a leak between virtual switches. [VMware Virtual Networking Concepts](https://www.vmware.com/content/dam/digitalmarketing/vmware/en/pdf/techpaper/virtual\_networking\_concepts.pdf)
  * From the left sidebar, select the _**Networking**_ tab.
  * You should see a _**Virtual Switches**_ tab. Select that tab, and then click _**Add standard virtual switch**_
    * ![image](https://user-images.githubusercontent.com/90063737/214604353-a9eb240a-52aa-402e-8f12-5d536fff90f4.png)
  * We are going to be using a virtual machine for our uplink, so we can remove that uplink NIC from our virtual switch
    * ![image](https://user-images.githubusercontent.com/90063737/214605466-fec14ba8-f36a-4f66-aa40-d0d83e122735.png)
  * Next we need to add a port group. Go to the _**Port Groups**_ tab and select _**Add port group**_
  * Name the port group and add it to the new virtual switch (In this case 480-WAN).
    * ![image](https://user-images.githubusercontent.com/90063737/214612745-fe317d6a-6739-474a-a6d0-8a36b8fcd390.png)
  * A port group is a collection of virtual ports that allow for certain policies to be applied to them. Port groups make it possible to specify the particular connection type a set of VMs can run on. Some examples of configurations someone might want to make standard across a group of ports include:
    * Virtual switch name
    * VLAN IDs and policies for tagging and filtering
    * Teaming policy
    * Layer 2 security options
    * Traffic shaping parameters
    * [VMware Virtual Networking Concepts](https://www.vmware.com/content/dam/digitalmarketing/vmware/en/pdf/techpaper/virtual\_networking\_concepts.pdf)
