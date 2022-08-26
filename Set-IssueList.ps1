<#
    .SYNOPSIS
    This script sets the issue list on our readme

    .DESCRIPTION
    Gets a list of issues in a GitHub repo and formats them into a table within an MD file.

    .NOTES
    Jess Pomfret
    @jpomfret
    #>
    #param(
    #    [parameter(Mandatory = $true)]
    #    [int]$Length
    #)


$issues = gh issue list --json title,state,body,labels
<#
$mdOutput = @"
## SAMPLE Issue List Title

Issue   | Status | Labels
--------|--------|---------
 Issue1 | Closed | house
 Issue2 | Open   | work
 Issue3 | Open   | personal, bigone
"@
#>


$mdOutput = @"
<!-- ToDo -->
## Todo List

Issue   | Status | Labels
--------|--------|--------

"@


(ConvertFrom-Json $issues) | ForEach-Object {
    #$mdOutput += ('<br> - {0}' -f $_.Title)
    $mdOutput +=
(@"
{0} | {1} | {2}

"@ -f$($_.Title), $_.State, ($_.labels.name -join ', '))

}

Write-Host $mdOutput

$Readme = Get-Content ./README.md -Raw
Write-Host "OldReadMe"
$Readme
$Regex = '(?s)<!-- ToDo -->.*'
$NewReadme = $Readme -replace $Regex, $mdOutput
Write-Host "exporting new Readme"
Write-Host "New Readme"
$NewReadme
Set-Content -Path ./README.md -Value $NewReadme