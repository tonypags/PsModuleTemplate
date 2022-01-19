function New-AdvancedFunction {
    <#
    .Synopsis
    Creates a new file from template.
    .DESCRIPTION
    Function scaffold is based on the ISE advanced function snippet.
    .EXAMPLE
    New-AdvancedFunction Get-Something
    #>
    [CmdletBinding()]
    [Alias('New-AdvFunction','nf')]
    param (

        [Parameter(Position=0)]
        [ValidateNotNull()]
        $Name = 'New-Function',

        [Parameter()]
        [ValidateNotNull()]
        $Parent = ".\"

    )

    $rawCode = @'

function {0} {{
    <#
    .Synopsis
    Short description
    .DESCRIPTION
    Long description
    .EXAMPLE
    Example of how to use this cmdlet
    .EXAMPLE
    Another example of how to use this cmdlet
    .INPUTS
    Inputs to this cmdlet (if any)
    .OUTPUTS
    Output from this cmdlet (if any)
    .NOTES
    General notes
    .COMPONENT
    The component this cmdlet belongs to
    .ROLE
    The role this cmdlet belongs to
    .FUNCTIONALITY
    The functionality that best describes this cmdlet
    #>
    [CmdletBinding(
        DefaultParameterSetName='Parameter Set 1',
        SupportsShouldProcess,
        PositionalBinding=$false,
        HelpUri = 'http://www.microsoft.com/',
        ConfirmImpact='Medium'
    )]
    [Alias()]
    [OutputType([String])]

    param(

        # Result from Some-OtherFunction
        [Parameter(ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [System.Object[]]
        $InputObject,

        # Param1 help description
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName,
            ValueFromRemainingArguments=$false,
            Position=0,
            ParameterSetName='Parameter Set 1'
        )]
        [SupportsWildcards()]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [ValidateCount(0,5)]
        [ValidateSet("sun", "moon", "earth")]
        [Alias("p1")]
        $Param1,

        # Param2 help description
        [Parameter(ParameterSetName='Parameter Set 1')]
        [AllowNull()]
        [AllowEmptyCollection()]
        [AllowEmptyString()]
        [ValidateScript({{$true}})]
        [ValidateRange(0,5)]
        [int]
        $Param2,

        # Param3 help description
        [Parameter(ParameterSetName='Another Parameter Set')]
        [ValidatePattern("[a-z]*")]
        [ValidateLength(0,15)]
        [string]
        $Param3

    )#END: param()

    begin {{

    }}#END: begin {{}}

    process {{

        foreach ($item in $Param1) {{

            if ($pscmdlet.ShouldProcess(
                "Target",
                "Operation"
            )) {{
                # Should Process?
            }}

        }}#END: foreach ($item in $Param1) {{}}

    }}#END process {{}}

    end {{

    }}#END: end {{}}

}}#END: function {0} {{}}

'@

    $Path = Join-Path $Parent "$Name.ps1"
    if (Test-Path $Path) {
        Write-Warning "The existing file will be overwritten!"
        $YN = Read-Host 'Continue and overwrite the existing file (y/N)?'
    } else {$YN = 'y'}
    if ($YN -eq 'y') {
        $rawCode -f $Name | Out-File $Path -Force
    } else {'No change made. Bye.'}
    Write-Debug "end function"
    Get-Item $Path

}#END: function New-AdvancedFunction
