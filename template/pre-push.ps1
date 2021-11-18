#Requires -Modules Pester

param(
    $remote,
    $url
)

$pr = Invoke-Pester -PassThru

if ($pr.Result -eq 'Failed') {

    foreach ($item in $pr.Failed) {
        Write-Warning "Pester Test $($item.Name) Failed:"
        Write-Warning "$($item.ErrorRecord.Exception.Message)"
        Write-Host ''
    }

    exit 1
}

exit 0
