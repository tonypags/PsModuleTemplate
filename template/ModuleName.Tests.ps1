Describe '<%=$PLASTER_PARAM_Name%> Tests' {

    Import-Module "<%=$PLASTER_PARAM_Name%>" -ea 0

    Context 'Test Module import' {

        It 'Module is imported' {
            $Valid = Get-Module -Name '<%=$PLASTER_PARAM_Name%>'
            $Valid.Name | Should -Be '<%=$PLASTER_PARAM_Name%>'
        }

    }

    Context 'Test <%=$PLASTER_PARAM_Name%> Functions' {

        It 'Valid Value (sample test)' {
            $Valid = 'Valid'
            $Valid | Should -Be $Valid
        }

    }

}
