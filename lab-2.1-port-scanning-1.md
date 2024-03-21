# Lab 2.1   Port Scanning 1

### Summary

### Lab

#### Deliverable 1

* Open Wireshark
* Run `bash -c "echo >/dev/tcp/10.0.5.21/80"` in terminal
* Capture the results in Wireshark and search for them with the filter `tcp.port==80`
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/fb7967a4-de66-496d-ab3c-4c8a9252eb0d)

#### Deliverable 2

* Write a script to scan open ports, and list them in a csv file using the format host,port. Run it.
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/dcdcc101-5f82-4e7d-9f5c-ed980c1e7003)
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/9cf1f50a-79b8-4e27-9f0f-d5756ce7b7f9)
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/ce1a7cbb-bffc-4570-8360-ef73297be06f)

#### Deliverable 3

* `/dev/tcp` is a file descriptor of bash. Essentially, there is not a real directory stored on the file system called `/dev/tcp`. Instead, we use that directory as a name to describe a particular network socket.
* https://medium.com/@stefanos.kalandaridis/bash-ing-your-network-f7069ab7c5f4
* https://w0lfram1te.com/exploring-dev-tcp

#### Deliverable 4

* ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/814faf77-a2e4-458b-a162-c325c04a8e8e)

#### Deliverable 5

* Run `sudo nmap 10.0.5.31 -p 3389`
* With Sudo
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/2e719a0e-54ea-4afd-8841-892ed50760b0)
* Without Sudo
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/521edec7-df91-4834-a303-700719aead6e)

#### Deliverable 6

* There is no ICMP ping when you use the -Pn flag. The -Pn flag tells nmap to ignore checking if the host is up before scanning ports.

#### Deliverable 7

* ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/dbe44469-27b6-4f1a-8e54-2eb36ff7c3e0)
