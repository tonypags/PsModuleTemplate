Describe 'PsModuleTemplate Tests' {

    Import-Module "PsModuleTemplate" -ea 0

    Context 'Test Module import' {

        It 'Module is imported' {
            $Valid = Get-Module -Name 'PsModuleTemplate'
            $Valid.Name | Should -Be 'PsModuleTemplate'
        }

    }

    Context 'Test PsModuleTemplate Functions' {

        It 'Valid Value (sample test)' {
            $Valid = 'Valid'
            $Valid | Should -Be $Valid
        }

    }

}
