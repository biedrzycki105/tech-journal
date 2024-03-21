# Docker

#### Setup

* Ubuntu Server Box
  *   Make sudo user

      ```
      sudo useradd <username>
      sudo passwd <username>
      sudo usermod -aG sudo <username>
      ```
  *   Hostname: `docker01-erik`

      ```
      sudo nano /etc/hosts
      sudo nano /etc/hostname
      ```
  * Network configs: `sudo nano /etc/netplan/00-installer-config.yaml`
    * ![image](https://user-images.githubusercontent.com/90063737/219284180-c5ec78ab-ae41-4527-b84f-8d0fb42095be.png)
  * Disable Root SSH
  * DNS A Records and PTR Records

#### Installing Docker

* SSH into docker01-erik
  * `ssh erik.biedrzycki-loc@docker01-erik`
  * `sudo -i`
  * ![image](https://user-images.githubusercontent.com/90063737/219286222-82d4855f-2cac-4edc-b6b1-f13397878992.png)
  * ![image](https://user-images.githubusercontent.com/90063737/219286713-446dd119-6928-4ff5-8024-b8d874a2d37b.png)
* [Installing Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)
  * First, update your existing list of packages:
    * `sudo apt update`
  * Next, install a few prerequisite packages which let apt use packages over HTTPS:
    * `sudo apt install apt-transport-https ca-certificates curl software-properties-common`
  * Add the gpg key for the Docker repo:
    * `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`
  * Add the Docker repository to apt repo:
    * `sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"`
    * This will also update our package database with the Docker packages from the newly added repo.
