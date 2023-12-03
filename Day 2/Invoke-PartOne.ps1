$Puzzle = Get-Content $PSScriptRoot'\input.txt'
Write-Debug "Games: $($Puzzle.Count)"
$DebugPreference = [System.Management.Automation.ActionPreference]::SilentlyContinue

$Limits = [PSCustomObject]@{
    red = 12
    green = 13
    blue = 14
}
$Limits | Format-Table

$PuzzleResults = @()
Foreach ($Game in $Puzzle) {
    $GameData = $Game -split ": "
    Write-Debug $GameData[0]
    Write-Debug $GameData[1]
    $GameResults = @()
    Foreach ($Round in ($GameData[1] -split "; ")) {
        $RoundDataParsed = [PSCustomObject]@{
            red = 0
            green = 0
            blue = 0
        }
        Write-Debug $Round
        $RoundData = $Round -split ", "
        Foreach ($RoundResult in $RoundData) {
            Write-Debug "`t $RoundResult"
            $RoundResultData = $RoundResult -split " "
            $RoundDataParsed.($RoundResultData[1]) = [int]$RoundResultData[0]
        }
        $GameResults += $RoundDataParsed
    }
    $PuzzleResults += [PSCustomObject]@{
        Game = [int]($GameData[0] -split " ")[1]
        Result = $GameResults
        HitLimit = $null
    }
}

Foreach ($Game in $PuzzleResults) {
    Foreach ($Round in $Game.Result) {
        If (($Round.red -le $Limits.red) -and 
            ($Round.green -le $Limits.green) -and
            ($Round.blue -le $Limits.blue)) {
                $Game.HitLimit = $false
            } Else {
                Write-Debug "Its Over :)"
                $Game.HitLimit = $true
                break
            }
    }
}

[int]$Total = ($PuzzleResults | Where-Object HitLimit -eq $false | Select-Object -ExpandProperty Game) | Measure-Object -Sum | Select-Object -ExpandProperty Sum
$Total