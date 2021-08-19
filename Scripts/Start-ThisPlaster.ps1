#Requires -Module PsModuleTemplate
# ipmo PsModuleTemplate 

# Tell Plaster where the Plaster Template is located
$XmlParent = Split-Path $PSScriptRoot -Parent

# Tell Plaster where the modules are located
$ModulesPath = Join-Path (Split-Path $profile -Parent) "Modules"

# Record the current list of folders in the module path
$beforePaths = Get-ChildItem $ModulesPath -Directory

# Invoke Plaster
$splat = @{
    TemplatePath = $XmlParent
    DestinationPath = $ModulesPath
    Verbose = $true
}
Invoke-Plaster @splat

# Determine the new module name by looking for the new folder name
$afterPaths = Get-ChildItem $ModulesPath -Directory
$newModuleName = (Compare-Object ($beforePaths.Name) ($afterPaths.Name)).InputObject

# GO into the created PSD1 file and replace the spaces 
#  between the required module names with commas

    # First identify the line number this requirement is on the page
    $thismodulePath = Join-Path $ModulesPath $newModuleName
    $ManifestPath = Join-Path $thismodulePath "$($newModuleName).psd1"
    $ManifestContent = Get-Content -Path $ManifestPath
    [int]$RequiredModulesLine = $ManifestContent |
        Select-String -Pattern 'requiredmodules' |
        Select-Object -ExpandProperty LineNumber

    # Next get the index of that line
    $index = $RequiredModulesLine - 1
    
    # Check to see if there are required modules
    if ($ManifestContent[$index] -notmatch '^\#') {
        
        # Next do the replacement on the calculated line number (index)
        $ManifestContent[$index] =
            "$(
                $ManifestContent[$index] -replace '\s',"','"
            )" -replace
                '\(',"('" -replace 
                '\)',"')"
            
        # Next set the content of that file
        $ManifestContent | Set-Content -Path $ManifestPath -Force
    }

# END into the created PSD1 file and replace the spaces 
#  between the required module names with commas

# Initialize the git repo and link origin using templated script
Set-Location $thismodulePath
$ps1 = Get-Item git.ps1 -ea 0
if ($ps1) {
    & ./git.ps1
}
Remove-Item git.ps1 -confirm:$false -ea 0 -Force

# Show the user all the stuff created
Start-Sleep -Seconds 1
cd ..
Get-ChildItem $thismodulePath
