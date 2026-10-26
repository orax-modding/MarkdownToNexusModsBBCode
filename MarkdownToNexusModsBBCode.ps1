param(
    [Parameter(Mandatory=$true)]
    [string]$InputFile,
    [Parameter()]
    [string]$OutputFile,
    [Parameter()]
    [string]$ConfigFile
)

if (-not (Test-Path $InputFile)) {
    Write-Error "Input file not found: $InputFile"
    exit 1
}

if (-not $OutputFile) {
    $OutputFile = [System.IO.Path]::ChangeExtension($InputFile, ".txt")
}

$pandocArgs = @()

if ($ConfigFile) {
    $pandocArgs += "-V"
    $pandocArgs += "config=$ConfigFile"
}

pandoc -f gfm -t ./writers/bbcode-nexusmods.lua --eol=lf $InputFile -o $OutputFile @pandocArgs
