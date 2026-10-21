param(
    [ValidateSet('main','demo')]
    [string]$Target = 'demo'
)
$ErrorActionPreference = 'Stop'
Push-Location -LiteralPath $PSScriptRoot
try {
    $buildDir = Join-Path (Split-Path -Parent $PSScriptRoot) 'tmp\pcl_beamer-build'
    New-Item -ItemType Directory -Path $buildDir -Force | Out-Null
    for ($pass = 1; $pass -le 2; $pass++) {
        & xelatex '-interaction=nonstopmode' '-halt-on-error' '-file-line-error' "-output-directory=$buildDir" "$Target.tex"
        if ($LASTEXITCODE -ne 0) { throw "XeLaTeX failed. See $buildDir/$Target.log." }
    }
    Copy-Item -LiteralPath "$buildDir/$Target.pdf" -Destination "$Target.pdf" -Force
    Write-Output "Built: $PSScriptRoot/$Target.pdf"
} finally {
    Pop-Location
}
