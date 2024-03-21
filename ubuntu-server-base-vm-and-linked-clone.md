# Ubuntu Server Base VM and Linked Clone

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
  * ADDS SSO configured on vCenter
  * Install Ansible, Powershell, PowerCLI on Xubuntu-WAN
  * VM Cloning script written
* Login to ESXi Host

## Step-by-step

* Get set up with using git
  * [Getting Started with Git](https://docs.github.com/en/get-started/getting-started-with-git)
  * Pull git repository `git pull <URL>`
  * Make the following folder structure:
    * `<location-of-repo>/480-DevOps/modules/480-utils`
* Install VSCode
  * `sudo snap install code --classic`
*   Create a new module in Powershell

    ```
    pwsh
    New-ModuleManifest -Path .\480-utils.psd1 -Author 'biedrzycki105' -RootModule '480-utils.psm1' -Description 'vSphere Automation Module for 480-DevOps'
    touch 480-utils.psm1
    ```

    * ![image](https://user-images.githubusercontent.com/90063737/219078613-51794d03-0be9-419b-a81c-cc688ba15a5d.png)
* Configure the module to be automatically loaded when starting VSCode
  *   In the VSCode terminal:

      ```
      pwsh
      code $profile
      ```
  * Edit the Microsoft.PowerShell\_profile.ps1 file to say this and save it:
    * `$env:PSModulePath = $envPSModulePath + ':/home/<user>/<path-to-modules-directory>'`
*
