$Public = Get-ChildItem $PSScriptRoot\Public\*.ps1
Foreach ($File in $Public) {
    . $File.FullName
}
Remove-Variable -Name 'Public','File' -Force -ea 0
Export-ModuleMember -Function * -Alias * -Variable *

$Private = Get-ChildItem $PSScriptRoot\Private\*.ps1 -ea 0
Foreach ($File in $Private) {
    . $File.FullName
}
