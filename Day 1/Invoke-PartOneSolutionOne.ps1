#Clear-Host
$Puzzle = Get-Content $PSScriptRoot\input.txt
$Total = 0
$Puzzle | % {
    Write-Debug $_
    $Regex = $_ | Select-String "[0-9]" -AllMatches | foreach {$_.matches}
    If ($Regex.Count -eq 1) {
        $Output = $Regex[0].Value.ToString() * 2
    } Elseif ($Regex.Count -eq 2) {
        $Output = $Regex.Value -join ""
    } Elseif ($Regex.Count -gt 2) {
        $Output = $Regex[0].Value + $Regex[-1].Value
    }
    Write-Debug $Output
    $Total += [int]$Output
}
Write-Host $Total