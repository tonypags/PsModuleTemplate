function Get-ModulesPath {
    [CmdletBinding()]
    param ()
    
    if ($IsMacOs -or $IsLinux) {
        ($env:PSModulePath -split ':')[0]
    } elseif ($IsWindows) {
        Join-Path (Split-Path $profile -Parent) "Modules"
    } else {
        Throw "Unsupported OS"
    }

}#END: function Get-ModulesPath {}
