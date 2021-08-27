function Get-ModulesPath {
    [CmdletBinding()]
    param ()
    
    if ( $PSEdition -eq 'Core' -and ($IsMacOs -or $IsLinux) ) {
        
        ($env:PSModulePath -split ':')[0]
    
    } elseif ($PSEdition -eq 'Desktop' -or $IsWindows) {
    
        Join-Path (Split-Path $profile -Parent) "Modules"
    
    } else {
    
        Throw "Unsupported OS"
    
    }

}#END: function Get-ModulesPath {}
