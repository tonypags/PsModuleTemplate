BeforeAll {

    Set-StrictMode -Version latest

    # This module has some metaFixers like get-/set-string
    Import-Module -Name PsDevTools -Force

    # Make sure MetaFixers.psm1 is loaded - it contains Get-TextFilesList
    $modPath = Join-Path -Path $PSScriptRoot -ChildPath 'MetaFixers.psm1'
    Import-Module -Name $modPath -Verbose:$false -Force
    $allTextFiles = Get-TextFilesList $PSScriptRoot

    
}

Describe 'Code formatting standards' {
    
    Context 'Code blocks' {
        It "if/else/elseif/try/catch/finally/parens/equals" {
            # There should always be a space between
            $counter = 0
            $ptnElse = '\}[\s\n]*?elsei?f?[\s\n]*?\{'
            $ptnIf = 'if\s*?\('
            $ptnParen = '\)\{'
            $ptnequals = '[]=[]'
            $ptnParen = '\)\{'
            foreach ($textFile in $allTextFiles) {

                $thisContent = Get-Content $textFile
                
                $testElse = $thisContent | Select-String $ptnElse
                foreach ($case in $testElse) {
                    $counter++
                    $Path = $case.FilePath
                    $newString = '} else'
                    $newString += if ($case.Match -like '*elseif*') {'if ('} else {' {'}
                    # Get-String $Path -Pattern $ptnElse | Set-String
                }
                
                $testIf = $thisContent | Select-String $ptnIf
                foreach ($case in $testIf) {
                }
                
                $testParen = $thisContent | Select-String $ptnParen
                foreach ($case in $testParen) {
                }

            }
            $counter | Should -Be 0
        }
    }
}
