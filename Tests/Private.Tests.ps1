Describe 'Private Tests' {
    
    # Import Private functions
    Get-ChildItem $PSScriptRoot\..\Private\*.ps1 |
        ForEach-Object {. $_.FullName}
    
    Context 'Test Private Functions' {

        It 'Valid Value' {
            $Valid = 'Valid'
            $Valid | Should -Be $Valid
        }

    }

}
