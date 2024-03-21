# Installing ESXi

## Setup

* Physical Devices
  * SuperMicro Server
    * 64GB RAM
    * 500GB Storage
  * 2 Ethernet Cables
  * AC Power Adapter
  * USB Stick with ESXi Install Media

## Step-by-step

* Used AC Power Adapter to plug power supply into power source
* Used 1 Ethernet cable to plug in IPMI Interface to the LAN.
  * IPMI is the protocol that allows us to remote into a machine that does not have an OS installed on it. This is required because the SuperMicro servers we use are brand new and have not been imaged yet. [What is IPMI?](https://www.trentonsystems.com/blog/what-is-ipmi)
* Cyber.local DHCP server gave IPMI interface an IP address, which we used to remote into our SuperMicro Server via a browser.
* Was prompted with a login screen. The username for brand new SuperMicro servers are ADMIN and the password is found on a sticker on the front of the server.
* Within the SuperMicro management console, select Remote Control tab, and then choose iKVM/HTML5 as the method used for Remote Control. A window will appear, showing the display of your SuperMicro server.
* USB stick with ESXi install media was inserted into the server's USB port.
* Rebooted server, and pressed F11 on the Virtual Keyboard during boot process to bring up boot menu and boot into the USB stick
* ESXi installation menu appeared. It should look like this (taken from instructor video): \* ![image](https://user-images.githubusercontent.com/90063737/214474256-0f24dc71-7865-42ed-8654-358672977aff.png)
