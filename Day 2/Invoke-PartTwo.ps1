$Puzzle = Get-Content $PSScriptRoot'\input.txt'
Write-Debug "Games: $($Puzzle.Count)"
$DebugPreference = [System.Management.Automation.ActionPreference]::SilentlyContinue

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

$Total = 0
Foreach ($Game in $PuzzleResults) {
    $R = $Game.Result.red   | Where-Object { $_ -ne 0 } | Sort-Object -Bottom 1
    Write-Debug "R: $R"
    $G = $Game.Result.green | Where-Object { $_ -ne 0 } | Sort-Object -Bottom 1
    Write-Debug "G: $G"
    $B = $Game.Result.blue  | Where-Object { $_ -ne 0 } | Sort-Object -Bottom 1
    Write-Debug "B: $B"
    $Totes = $R * $G * $B
    $Total += $Totes

}

$Total