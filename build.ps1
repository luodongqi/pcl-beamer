param(
    [ValidateSet('main','demo')]
    [string]$Target = 'demo'
)
$ErrorActionPreference = 'Stop'
Push-Location -LiteralPath $PSScriptRoot
try {
    $buildDir = Join-Path (Split-Path -Parent $PSScriptRoot) 'tmp\pcl_beamer-build'
    New-Item -ItemType Directory -Path $buildDir -Force | Out-Null
    & latexmk '-xelatex' '-interaction=nonstopmode' '-halt-on-error' '-file-line-error' "-outdir=$buildDir" "$Target.tex"
    if ($LASTEXITCODE -ne 0) { throw "Compilation failed. See $buildDir/$Target.log." }
    Copy-Item -LiteralPath "$buildDir/$Target.pdf" -Destination "$Target.pdf" -Force
    Write-Output "Built: $PSScriptRoot/$Target.pdf"
} finally {
    Pop-Location
}
