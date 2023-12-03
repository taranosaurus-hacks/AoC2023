#Clear-Host
$Puzzle = Get-Content $PSScriptRoot\input.txt
$Total = 0
$NumbersAsWords = @(
    "grrrrrrr"
    "one"
    "two"
    "three"
    "four"
    "five"
    "six"
    "seven"
    "eight"
    "nine"
)

$ReverseNumbersAsWords = @(
    "rrrrrrrrrrg"
    "eno"
    "owt"
    "eerht"
    "ruof"
    "evif"
    "xis"
    "neves"
    "thgie"
    "enin"
)

$Puzzle | % {
    $Word = [array][char[]]$_
    $Reverse = [array][char[]]$_

    [array]::Reverse($Reverse)
    $Word = $Word -join ''
    $First = [regex]::Match($Word, "(one|two|three|four|five|six|seven|eight|nine|[1-9])").Value

    If ($First.Length -gt 1) {
        [int]$Result1 = $NumbersAsWords.IndexOf($First)
    } Else {
        [int]$Result1 = $First
    }

    $Reverse = $Reverse -join ''
    $Last = [regex]::Match($Reverse, "(enin|thgie|neves|xis|evif|ruof|eerht|owt|eno|[0-9])").Value

    If ($Last.Length -gt 1) {
        [int]$Result2 = $ReverseNumbersAsWords.IndexOf($Last)
    } Else {
        [int]$Result2 = $Last
    }

    $WordTotal = [int]($Result1,$Result2 -join '')
    $Total += $WordTotal
    Write-Debug "$First $Result1 `t $Last $Result2 `t $WordTotal `t $Total   "
}
Write-Host $Total