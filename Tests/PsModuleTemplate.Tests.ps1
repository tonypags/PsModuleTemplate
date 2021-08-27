Describe 'PsModuleTemplate Tests' {

    Import-Module "PsModuleTemplate" -ea 0

    Context 'Test Module import' {

        It 'Module is imported' {
            $Valid = Get-Module -Name 'PsModuleTemplate'
            $Valid.Name | Should -Be 'PsModuleTemplate'
        }

    }

    Context 'Test PsModuleTemplate Functions' {

        It 'Gets the modules root path' {
            $mod = Get-ModulesPath
            Test-Path $mod | Should -Be $true
        }

    }

}
