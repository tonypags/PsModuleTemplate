<#
.SYNOPSIS
Given a script/function path, the SYNOPSIS is converted to HTML.
For special formatting rules, please visit https://pandoc.org/MANUAL.html
.EXAMPLE
& ./Convert-HelpSynopsisToHtml.ps1 -Path "C:\Backup-Scripts\RubrikSLAComplianceSummary.ps1"
#>
param($Path)
if (Get-Command 'pandoc' -ea:ignore) {} else {
    throw 'Prerequisite not found! Please install pandoc first.'
}
if (Get-Command 'dos2unix' -ea:ignore) {} else {
    throw 'Prerequisite not found! Please install dos2unix first.'
}
if (Test-Path $Path) {} else {
    if (get-module 'psguitools' -l) {
        $Path = Show-GuiFilePicker -Single -outString -Title "Select a PS1 File" -Extension 'ps1'
    } else {
        $Path = Read-Host "Enter the full path to a PS1 File"
    }
}
if (Test-Path $Path) {} else {
    throw "Path not found: '$Path'"
}

$fName   = 'SYNOPSIS.md'
$fPath   = Join-Path $env:TEMP $fName
$tParent = Join-Path $env:USERPROFILE 'Downloads'
$tPath   = Join-Path $tParent 'SYNOPSIS.html'

(Get-Help $Path -Full).SYNOPSIS | Out-File $fPath

dos2unix "$fPath"
pandoc "$fPath" -t 'html' -i -o $tPath

Try{Invoke-Item $tPath -ea 'Stop'} Catch {Get-Item $tPath}
