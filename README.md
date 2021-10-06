# Introduction 

Scaffolding for PowerShell Modules.

# Getting Started
1.	Installation process

    Without Repository available, clone directly from Git:

        $CloneType = 'https' # HTTPS or SSH
        $ModuleName = 'PsModuleTemplate'
        $ProjectName = '' # VSTS only, use $null if github
        $OrgName = 'tonypags'

        $uri = if $(ProjectName) {
            if ($CloneType -eq 'https') {
                "https://$($OrgName)@dev.azure.com/$($OrgName)/$($ProjectName)/_git/$($ModuleName)"
            } else {
                "git@ssh.dev.azure.com:v3/$($OrgName)/$($ProjectName)/$($ModuleName)"
            }
        } else {
            if ($CloneType -eq 'https') {
                "https://github.com/$($OrgName)/$($ModuleName).git"
            } else {
                "git@github.com:$($OrgName)/$(ModuleName).git"
            }
        }
        $ModuleParent = $env:PSModulePath -split ';' | Where {$_ -like "*$($env:USERNAME)*"} | Select -First 1
        Set-Location $ModuleParent
        git clone $uri
        
    
2.	Build a new Module:
        
        cd PsModuleTemplate
        & .\Scripts\Start-ThisPlaster.ps1
        
<br>

3.	Dependencies

        This module has the following PowerShell Dependancies:
        Plaster Pester

        This module has the following Software Dependancies:
        This module has no dependancies other than a supported Windows OS.

<br>

4.	Version History

	- v0.1.0.1 - Initial Commit.

	- v0.1.1.2 - Added more info to readme template, private test file.

    	- v0.1.5.3 - Adding Plaster template, starting migration to Plaster.

<br>



# Build, Test, and Publish

0.  Pester test. 

1.  Get next version number `v#.#.#.#` and a comment `[string]` for the change log.

2.  Create a new Package folder as .\Package\v#.#.#.#\

3.  Copy the PSD1 files in as-is.

    Update the version number and copyright date if required.

	Update the Exported Function Name array with the basenames of the files under the .\ folder only.

4.  Create a new, blank PSM1 file in here. 

    Populate it with all of the PS1 files' content from the .\ and .\Private folders.

5.  Create a NUSPEC file and update the version and change log.

6.  Build the NuGet package.

7.  Push to private repo.



# Contribute

1.  Add your changes to a new feature branch.

2.  Add Pester tests for your changes.

3.  Push your branch to origin.

4.  Submit a PR with description of changes.

5.  Follow up in 2 business days.




