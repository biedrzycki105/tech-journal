# Integrating AD with vCenter

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
  * vCenter installed
  * CA Configured
    * `Install-WindowsFeature ADCS-Cert-Authority -IncludeManagementTools`
    * `Install-ADcsCertificationAuthority -CACommonName "erik-dc1-ca" -CAType EnterpriseRootCA -KeyLength 2048 –HashAlgorithmName SHA256 –ValidityPeriod Years –ValidityPeriodUnits 5`
* Login to ESXi Host

## Step-by-Step

* Log into your domain controller as a domain admin. In Active Directory Users and Computers, create the following OUs and create a Service Account named vcenterldap. Also, move your Domain Admin account into the Accounts OU and create a global security group called vcenter-admins in that OU.
  * ![image](https://user-images.githubusercontent.com/90063737/217563403-b6d70ee6-6285-46f1-8c82-f82915da1db1.png)
  * ![image](https://user-images.githubusercontent.com/90063737/218876090-e8b30ae3-737c-46fd-8ed6-ebeb8123f047.png)
* The next thing we want to do is log into our xubuntu box and grab a certificate from the Root CA and save it as `ca.cert`. We will use this file when setting up AD SSO on vCenter so that vCenter can authenticate with Active Directory.
  * ![image](https://user-images.githubusercontent.com/90063737/218671002-6b4d83a0-0a48-4c98-b9b3-55f7c691fdb4.png)
* Log into vCenter as `administrator@vsphere.local`
* Find the Hamburger Icon (3 Horizontal bars). Go to Hamburger > Administration > Configuration > Identity Sources and be sure to select Active Directory Domain. Fill out the information so that you can add your AD Domain
  * ![image](https://user-images.githubusercontent.com/90063737/217573162-aa0b5a4d-16fe-4409-805c-5c398effd3a9.png)
  * ![image](https://user-images.githubusercontent.com/90063737/217573830-7f2c27db-9fff-4883-8355-a3d4ba344a72.png)
* Next, instead of adding an AD Domain, we need to add an Identity Source. Add an Identity Source using Active Directory with LDAPS. This allows vCenter to sync permissions and roles using LDAP.
  * ![image](https://user-images.githubusercontent.com/90063737/217580299-760f797e-0854-4c93-9fe3-072c61809c0f.png)
  * ![image](https://user-images.githubusercontent.com/90063737/218873335-44488085-73ff-460e-9e76-d2d1a28eb285.png)
* Next, go to Users and Groups on the left hand side and select your domain. Edit the Administrators group to include the group vcenter-admins, which your named Domain Admin account should be a part of.
  * ![image](https://user-images.githubusercontent.com/90063737/218874002-cc26aefc-84df-4a7a-8d9d-5026c688f668.png)
  * ![image](https://user-images.githubusercontent.com/90063737/218876728-3d75a1b4-7d0e-44aa-a57d-ccfb541510a4.png)
