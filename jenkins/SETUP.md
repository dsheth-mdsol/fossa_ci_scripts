# Jenkins CI FOSSA Setup Instructions

## Necessary Steps
  - Follow instructions to [Obtain a FOSSA API Key](/OBTAINING_API_KEY.md)
  - Login to Jenkins
  - Add the FOSSA API Key into Jenkin's Secret Store as 'Secret text'
  - Open the Project's Jenkins Pipeline Configuration
  - Under 'Bindings' add a new 'Secret Text', set the 'Variable' field to 'FOSSA_API_KEY' and set the 'Credentials' dropdown to the FOSSA API Key entry from the Secret Store
  - Under 'Build' add a new build step and set the 'Command' as :
    * If using Batch  
    ```
    @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mdsol/fossa_ci_scripts/master/jenkins/fossa_install.ps1'))"
    @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mdsol/fossa_ci_scripts/master/jenkins/fossa_run.ps1'))"
    ```
    * If using PowerShell  
    ```
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mdsol/fossa_ci_scripts/master/jenkins/fossa_install.ps1'))
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mdsol/fossa_ci_scripts/master/jenkins/fossa_run.ps1'))
    ```
  - Follow any necessary [Optional Steps](#optional-steps) found below
  - Save the changes to the Jenkins Pipeline
  - Follow necessary steps to [Setup FOSSA CLI](/FOSSA_CLI_SETUP.md)
  - Commit & Push changes to GitHub
  - Open a Pull Request against a Jenkins Monitored Branch
  - Check Jenkins Project Pipeline for errors or failures
  - Merge the Pull Request when satisfied with output

## Optional Steps

### Failing Builds on Policy Violations
  - Add a Parameter to the Jenkins Pipeline called 'FOSSA_FAIL_BUILD' and set its value to 'true'  
**_Note_** : This functionalily is optional at this time (Nov 2018), but will be made manditory through script updates in the future.  This toggle is a courtesy for teams which want to get a head start on these requirements.
