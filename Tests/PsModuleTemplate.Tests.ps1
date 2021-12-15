Describe 'PsModuleTemplate Tests' {

    BeforeAll {
        Import-Module "PsModuleTemplate" -ea 0 -Force
        $script:thisModule = Get-Module -Name "PsModuleTemplate"
        $script:funcNames = $thisModule.ExportedCommands.Values |
            Where-Object {$_.CommandType -eq 'Function'} |
            Select-Object -ExpandProperty Name
    }

    Context 'Test Module import' {

        It 'Ensures module is imported' {
            $script:thisModule.Name | Should -Be 'PsModuleTemplate'
        }

    }

    Context 'Test PsModuleTemplate Functions' {

        # Remove the tested item from the initial array
        AfterEach {
            $script:funcNames = $script:funcNames | Where-Object {$_ -ne $script:thisName}
        }

        It 'Gets the modules root path' {
            $mod = Get-ModulesPath
            Test-Path $mod | Should -Be $true

            $script:thisName = 'Get-ModulesPath'
        }

    }

    Context 'Clean up' {

        It 'Ensures all public functions have tests' {
            $script:funcNames | Should -BeNullOrEmpty
        }
        
    }

}
