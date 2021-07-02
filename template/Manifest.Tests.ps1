
$ModuleParent  = Split-Path -Path ((Get-PSCallStack)[0].ScriptName) -Parent
$ModuleName    = Split-Path -Path $ModuleParent -Leaf
$ManifestPath  = Join-Path $ModuleParent "$($ModuleName).psd1"
$manifest      = Import-PowerShellDataFile -Path $ManifestPath

Describe 'Module manifest' {
    Context 'Validation' {

        $script:manifest = $null

        It 'has a valid manifest' {
            {
                $script:manifest = Test-ModuleManifest -Path $ManifestPath -Verbose:$false -ErrorAction Stop -WarningAction SilentlyContinue
            } | Should Not Throw
        }

        It 'has a valid name in the manifest' {
            $script:manifest.Name | Should Be $ModuleName
        }

        It 'has a valid root module' {
            $script:manifest.RootModule | Should Be "$($moduleName).psm1"
        }

        It 'has a valid version in the manifest' {
            $script:manifest.Version -as [Version] | Should Not BeNullOrEmpty
        }

        It 'has a valid description' {
            $script:manifest.Description | Should Not BeNullOrEmpty
        }

        It 'has a valid author' {
            $script:manifest.Author | Should Not BeNullOrEmpty
        }

        It 'has a valid guid' {
            {
                [guid]::Parse($script:manifest.Guid)
            } | Should Not throw
        }

        It 'has a valid copyright' {
            $script:manifest.CopyRight | Should Not BeNullOrEmpty
        }
    }
}
