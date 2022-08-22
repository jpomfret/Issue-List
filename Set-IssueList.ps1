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

$mdOutput = @"
## Issue List Title

Issue   | Status | Labels
--------|--------|---------
 Issue1 | Closed | house
 Issue2 | Open   | work
 Issue3 | Open   | personal, bigone
"@

echo “::set-output name=mdOutput::$mdOutput"

Out-File -InputObject $mdOutput -FilePath .\readme.md -Append