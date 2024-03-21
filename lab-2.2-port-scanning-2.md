# Lab 2.2   Port Scanning 2

### Summary

### Lab

#### Deliverable 1

* Observe and repeat the following interaction between kali and your win10 system (substitute your IP addresses). Provide screenshot(s) similar to the one below that show:
  * Determine your Windows 10 IP address (.131 in the example)
    * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/4d8fb045-fabd-4b31-90f4-2e3107f04ab1)
  * Ping Windows 10 from Kali (it should fail)
    * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/e855ed85-2faa-490b-aff5-2bb8a536ea32)
  * Ping Kali from Windows 10 (it should work) Use the 10.0.17.x address!
    * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/5fca3dcf-05e8-4459-b784-c0462e9f322b)
  * Wireshark on eth0 (not wg0) using a capture filter for your windows host ip address
  * nmap against tcp/9999
  * results indicate filtered
  * display your wireshark capture, there should be an ARP request (this is how the host was found, not ICMP!)
    * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/fbcd2aee-6520-4d54-a537-08208149a43b)
* Filtered does not necessarily mean open. It could be open but "filtered" by a firewall. In the example nmap actually doesn't know. TCP/9999 is not active on our windows 10 host at all. In fact the only reason the host is reported up at all is that layer 2 connectivity is allowed in the form of ARP. We can do ARP because there is no layer 3 device separating kali and windows.

#### Deliverable 2

* Enable Remote Desktop on win10
  * `Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0`
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/876f955d-9af2-4d50-9290-c10cd8385890)

#### Deliverable 3

* Initiate an RDP connection on kali01: `xfreerdp /u:<username> /v:<ip_address>`
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/5ea9add1-e1a7-4ff3-a491-4e00618ba59d)

#### Deliverable 4

* `sudo nmap -sV 10.0.17.151 -p 3389`
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/85d6f0a9-2117-4874-bb8c-3a52eee8ca90)

#### Deliverable 5

* `sudo nmap -A 10.0.17.151 -p 3389`
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/27f5960a-fe0f-4eda-9ff8-a42148edb25c)

#### Deliverable 6

* Scan ports 1-6000
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/c7daeac0-e638-4a0b-b6b2-9cc850d80e76)

#### Deliverable 7

* On win10 turn on Network Discovery and File/Printer Sharing
* Scan ports 1-6000 again
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/9e885204-8813-47f3-92e9-c83d3861c63c)

#### Deliverable 8

* `sudo nmap -sV 10.0.17.151 -p 135,139,445,3389`
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/123c4082-b51e-4684-aab8-e36c3d576e8e)

#### Deliverable 9

* `sudo nmap -A 10.0.17.151 -p 135,139,445,3389`
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/af62f025-1209-485b-b8dc-d8e874191019)
