Describe '<%=$PLASTER_PARAM_Name%> Tests' {

    BeforeAll {
        Import-Module "<%=$PLASTER_PARAM_Name%>" -ea 0 -Force
        $script:thisModule = Get-Module -Name "<%=$PLASTER_PARAM_Name%>"
        $script:funcNames = $thisModule.ExportedCommands.Values |
            Where-Object {$_.CommandType -eq 'Function'} |
            Select-Object -ExpandProperty Name

        # dot-sourcing all functions: Required for Mocking
        Get-ChildItem   $PSScriptRoot\..\Private\*.ps1,
                        $PSScriptRoot\..\Public\*.ps1   |
        ForEach-Object {. $_.FullName}
    }

    Context 'Test Module import' {

        It 'Ensures module is imported' {
            $script:thisModule.Name | Should -Be '<%=$PLASTER_PARAM_Name%>'
        }

    }

    Context 'Test <%=$PLASTER_PARAM_Name%> Functions' {

        # Remove the tested item from the initial array
        AfterEach {
            $script:funcNames = $script:funcNames | Where-Object {$_ -ne $script:thisName}
        }

        It 'Valid Value (sample test)' {
            $Valid = 'Get-Valid'
            $Valid | Should -Be $Valid

            $script:thisName = 'Get-Valid'
        }

    }

    Context 'Clean up' {

        It 'Ensures all public functions have tests' {
            $script:funcNames | Should -BeNullOrEmpty
        }
        
    }

}
