#Clear-Host
$Puzzle = Get-Content $PSScriptRoot\input.txt
$Total = 0
$Puzzle | % {
    $Word = $_
    $Numberslol = [char[]]$Word | Where-Object { $_ -Like "[1-9]" }
    $Total+= [int]($Numberslol[0],$Numberslol[-1] -join '')

}
Write-Host $Total