firewall {
    group {
        port-group PORT-TCP-ADDS {
            description "All TCP ports for Active Directory"
            port 53
            port 80
            port 88
            port 135
            port 137-138
            port 389
            port 443
            port 445
            port 464
            port 636
            port 1024-65535
        }
        port-group PORT-UDP-ADDS {
            description "All UDP ports for Active Directory"
            port 53
            port 80
            port 88
            port 135
            port 137-138
            port 389
            port 443
            port 445
            port 464
            port 636
            port 1024-65535
        }
    }
    name LAN-to-MGMT {
        default-action drop
        enable-default-log
        rule 1 {
            action accept
            state {
                established enable
            }
        }
        rule 10 {
            action accept
            description "Allow RDP from LAN to MGMT"
            destination {
                address 172.16.200.11
                port 3389
            }
            protocol tcp
        }
        rule 20 {
            action accept
            description "Allow ADDS UDP ports from LAN to MGMT"
            destination {
                address 172.16.200.11
                group {
                    port-group PORT-UDP-ADDS
                }
            }
            protocol udp
        }
        rule 30 {
            action accept
            description "Allow ADDS TCP ports from LAN to MGMT"
            destination {
                address 172.16.200.11
                group {
                    port-group PORT-TCP-ADDS
                }
            }
            protocol tcp
        }
        rule 40 {
            action accept
            description "Allow HTTP from LAN to WAZUH"
            destination {
                address 172.16.200.10
                port 443
            }
            protocol tcp
        }
        rule 50 {
            action accept
            description "Allow WAZUH from LAN to MGMT"
            destination {
                address 172.16.200.10
                port 1514-1516
            }
            protocol tcp
        }
    }
    name MGMT-to-LAN {
        default-action drop
        enable-default-log
        rule 1 {
            action accept
        }
        rule 10 {
            action accept
            description "Allow ADDS UDP ports from MGMT to LAN"
            destination {
                group {
                    port-group PORT-UDP-ADDS
                }
            }
            protocol udp
            source {
                address 172.16.200.11
            }
        }
        rule 20 {
            action accept
            description "Allow ADDS TCP ports from MGMT to LAN"
            destination {
                group {
                    port-group PORT-TCP-ADDS
                }
            }
            protocol tcp
            source {
                address 172.16.200.11
            }
        }
        rule 30 {
            action accept
            destination {
                port 22
            }
            protocol tcp
        }
    }
}
interfaces {
    ethernet eth0 {
        address 172.16.150.3/24
        description erik-LAN
        hw-id 00:50:56:a1:30:2f
    }
    ethernet eth1 {
        address 172.16.200.2/28
        description erik-MGMT
        hw-id 00:50:56:a1:92:a0
    }
    loopback lo {
    }
}
protocols {
    rip {
        interface eth0 {
        }
        network 172.16.200.0/28
    }
    static {
        route 0.0.0.0/0 {
            next-hop 172.16.150.2 {
            }
        }
    }
}
service {
    dns {
        forwarding {
            allow-from 172.16.200.0/28
            listen-address 172.16.200.2
        }
    }
    ssh {
        listen-address 0.0.0.0
    }
}
system {
    config-management {
        commit-revisions 100
    }
    conntrack {
        modules {
            ftp
            h323
            nfs
            pptp
            sip
            sqlnet
            tftp
        }
    }
    console {
        device ttyS0 {
            speed 115200
        }
    }
    host-name fw-mgmt-erik
    login {
        user erik {
            authentication {
                encrypted-password $6$q3E1onCZngHeo.Yn$V9jGusRbeSj0nDYdQU4pTYPDg11SUXKGHfnazYGe5k68GpYTlbGc9nG/VgUjZDKKnBPIohaHo2ls9SBAMF96s.
            }
        }
        user vyos {
            authentication {
                encrypted-password $6$YUTCBnIl7XuxPfv7$UQXsMiDLSJsDs9mPJ2PQ.9IjjMks5MrKu6IlQRJsS.VIvkYeQXFvupJVrZMTQFYjkbTkRshVAYECJS337kHAS/
                plaintext-password ""
            }
        }
    }
    name-server 172.16.150.2
    ntp {
        server time1.vyos.net {
        }
        server time2.vyos.net {
        }
        server time3.vyos.net {
        }
    }
    syslog {
        global {
            facility all {
                level info
            }
            facility protocols {
                level debug
            }
        }
    }
}
zone-policy {
    zone LAN {
        from MGMT {
            firewall {
                name MGMT-to-LAN
            }
        }
        interface eth0
    }
    zone MGMT {
        from LAN {
            firewall {
                name LAN-to-MGMT
            }
        }
        interface eth1
    }
}


// Warning: Do not remove the following line.
// vyos-config-version: "bgp@3:broadcast-relay@1:cluster@1:config-management@1:conntrack@3:conntrack-sync@2:dhcp-relay@2:dhcp-server@6:dhcpv6-server@1:dns-forwarding@3:firewall@7:flow-accounting@1:https@3:interfaces@26:ipoe-server@1:ipsec@9:isis@1:l2tp@4:lldp@1:mdns@1:monitoring@1:nat@5:nat66@1:ntp@1:openconnect@2:ospf@1:policy@3:pppoe-server@5:pptp@2:qos@1:quagga@10:rpki@1:salt@1:snmp@2:ssh@2:sstp@4:system@25:vrf@3:vrrp@3:vyos-accel-ppp@2:wanloadbalance@3:webproxy@2"
// Release version: 1.4-rolling-202209130217
