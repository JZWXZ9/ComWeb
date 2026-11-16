$notesRoot = $PSScriptRoot
$exitCode = 0

Push-Location $notesRoot
try {
    New-Item -ItemType Directory -Force -Path 'build' | Out-Null

    # Run twice so the table of contents and cross-references are up to date.
    & xelatex -interaction=nonstopmode -halt-on-error -output-directory build main.tex
    $exitCode = $LASTEXITCODE

    if ($exitCode -eq 0) {
        & xelatex -interaction=nonstopmode -halt-on-error -output-directory build main.tex
        $exitCode = $LASTEXITCODE
    }
}
finally {
    Pop-Location
}

exit $exitCode
