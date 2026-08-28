[CmdletBinding()]
param(
    [ValidateRange(1, 65535)]
    [int]$Port = 8010
)

$ErrorActionPreference = "Stop"
$clientDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$workspaceDirectory = Resolve-Path (Join-Path $clientDirectory "..\..")
$uvExecutable = Join-Path $workspaceDirectory ".venv\Scripts\uv.exe"

Push-Location $clientDirectory
try {
    if (Test-Path -LiteralPath $uvExecutable) {
        & $uvExecutable run --no-sync adk web --port $Port
    }
    else {
        uv run adk web --port $Port
    }
}
finally {
    Pop-Location
}
