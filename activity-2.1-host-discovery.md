# Activity 2.1   Host Discovery

### Summary

* In this activity you are going to enumerate the hosts in our target network 10.0.5.0/24 using various techniques beginning with "living-off-the-land techniques" and then by adding tools to the mix. You may work with your teammates to come up with the solution but you will execute the solution in your own environment and submit your own results as deliverables.

### Activity

#### Deliverable 1

* Ping 10.0.5.21. Show ICMP packets in Wireshark.
* ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/baa176f2-946e-4973-b918-67d65a7debf4)

#### Deliverable 2

* Write a script to ping all addresses 10.0.5.2 through 10.0.5.50 and list all the live hosts in a file called sweep.txt
  * ```
    #!/bin/bash
    outfile=../output/sweep-$(date +%d-%m-%y-%s).txt

    for ip in $(seq 2 50); do 
    echo "Pinging $1.$ip..."
    ping -c 1 $1.$ip | grep "64 bytes" | awk '{print $4}' | cut -d ":" -f1 >> $outfile
    done
    ```
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/ab6083b6-a2fb-4c46-a892-2fba40c3514b)
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/ab609c19-738d-439b-8656-2b8f5872c07c)

#### Deliverable 3

* Write the same script but using the tool fping. This one-liner does the exact same thing as the script above.
  * ```
    #!/bin/bash
    outfile=../output/fping_sweep-$(date +%d-%m-%y-%s).txt
    fping -g $1.2 $1.50 -aq >> $outfile
    ```
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/982110ad-649a-416d-ba1a-f10dc027bdbe)

#### Deliverable 4

* Use nmap -sn to scan 10.0.5.21
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/7d1f2f27-5216-45b2-8585-76b5a160ca7e)

#### Deliverable 5

* Using nmap -sn uses a few other protocols in addition to ICMP for this ping scan. This scan uses TCP, ICMP, and DNS.
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/fac91b95-75cb-463d-a982-85039e7e341b)

#### Deliverable 6

* Write the same type of script as before using nmap instead of ping or fping
  * ```
    #!/bin/bash
    outfile=../output/nmap_sweep-$(date +%d-%m-%y-%H%M%S).txt

    for ip in $(seq 2 50); do 
    echo "Pinging $1.$ip..."
    nmap -n -sn $1.$ip -oG - | awk '/Up$/{print $2}' >> $outfile 
    done
    ```
  * ![image](https://github.com/biedrzycki105/tech-journal/assets/90063737/c58f0193-0739-4160-a7f7-586babea322d)

#### Deliverable 7

* date
  * %D - Display date as mm/dd/yy.
  * %d - Display the day of the month (01 to 31).
  * %a - Displays the abbreviated name for weekdays (Sun to Sat).
  * %A - Displays full weekdays (Sunday to Saturday).
  * %h - Displays abbreviated month name (Jan to Dec).
  * %b - Displays abbreviated month name (Jan to Dec).
  * %B - Displays full month name(January to December).
  * %m - Displays the month of year (01 to 12).
  * %y - Displays last two digits of the year(00 to 99).
  * %Y - Display four-digit year.
  * %T - Display the time in 24 hour format as HH:MM:SS.
  * %H - Display the hour.
  * %M - Display the minute.
  * %S - Display the seconds.
* fping
  * \-g - declare a start and end address for fping
  * \-a - only show alive hosts
  * \-q - do not show per-target results
