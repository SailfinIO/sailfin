#Requires -Version 5.1
# SFN-1093: exercise the CI bootstrap trust boundary without OpenSSL or network.
# FixtureDir contains the unmodified archive, SHA256SUMS, and SHA256SUMS.sig
# downloaded from the published release named by Version.
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidatePattern('^[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.]+)?$')]
    [string]$Version,
    [Parameter(Mandatory = $true)]
    [string]$FixtureDir
)

$ErrorActionPreference = 'Stop'
$repoRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
$verifierPath = Join-Path $repoRoot '.github/actions/sailfin-build-windows/verify-release-seed.ps1'
$fixtureRoot = (Resolve-Path -LiteralPath $FixtureDir).Path
$fixtureAsset = "sailfin_${Version}_windows_x86_64-msvc.tar.gz"
foreach ($name in @($fixtureAsset, 'SHA256SUMS', 'SHA256SUMS.sig')) {
    if (-not (Test-Path -LiteralPath (Join-Path $fixtureRoot $name) -PathType Leaf)) {
        throw "Missing released fixture: $name"
    }
}

$tokens = $null
$parseErrors = $null
$ast = [Management.Automation.Language.Parser]::ParseFile($verifierPath, [ref]$tokens, [ref]$parseErrors)
if ($parseErrors.Count -ne 0) { throw "Verifier parse errors: $parseErrors" }
$installerAst = [Management.Automation.Language.Parser]::ParseFile((Join-Path $repoRoot 'install.ps1'), [ref]$tokens, [ref]$parseErrors)
if ($parseErrors.Count -ne 0) { throw "Installer parse errors: $parseErrors" }
$arithmeticPredicate = {
    param($node)
    ($node -is [Management.Automation.Language.FunctionDefinitionAst] -and
        ($node.Name -like '_Ed25519*' -or $node.Name -eq 'Test-Ed25519Signature')) -or
    ($node -is [Management.Automation.Language.AssignmentStatementAst] -and
        $node.Left.Extent.Text -like '$script:_Ed25519*')
}
$verifierArithmetic = ($ast.FindAll($arithmeticPredicate, $true) | ForEach-Object { $_.Extent.Text -replace "`r`n", "`n" }) -join "`n"
$installerArithmetic = ($installerAst.FindAll($arithmeticPredicate, $true) | ForEach-Object { $_.Extent.Text -replace "`r`n", "`n" }) -join "`n"
if ([string]::IsNullOrEmpty($verifierArithmetic) -or $verifierArithmetic -cne $installerArithmetic) {
    throw 'Embedded Ed25519 arithmetic has diverged from install.ps1'
}
Write-Host 'PASS: embedded arithmetic and constants match install.ps1'
$katDefinitions = foreach ($name in @('_Ed25519HexToBytes', 'Assert-Ed25519VerifierUsable')) {
    $definition = $ast.Find({
        param($node)
        $node -is [Management.Automation.Language.FunctionDefinitionAst] -and $node.Name -eq $name
    }, $true)
    if ($null -eq $definition) { throw "Verifier is missing $name" }
    $definition.Extent.Text
}

# Extract the real self-test so either missing KAT half is caught even when
# arithmetic happens to verify the released fixture correctly.
foreach ($answer in @($true, $false)) {
    & {
        param($definitions, $stubAnswer)
        . ([scriptblock]::Create(($definitions -join "`n")))
        function Test-Ed25519Signature { return $stubAnswer }
        $failure = $null
        try { Assert-Ed25519VerifierUsable } catch { $failure = $_.Exception.Message }
        $expected = if ($stubAnswer) {
            'accepts-genuine=True, rejects-tampered=False'
        } else {
            'accepts-genuine=False, rejects-tampered=True'
        }
        if ($null -eq $failure -or $failure -notmatch [regex]::Escape($expected)) {
            throw "KAT did not reject an always-$stubAnswer verifier for the expected reason: $failure"
        }
        Write-Host "PASS: KAT rejects always-$stubAnswer verifier ($expected)"
    } $katDefinitions $answer
}

$scratchRoot = [IO.Path]::GetFullPath((Join-Path $repoRoot 'scratch'))
$testRoot = Join-Path $scratchRoot ('seed-verifier-' + [guid]::NewGuid().ToString('N'))
$emptyPath = Join-Path $testRoot 'empty-path'
New-Item -ItemType Directory -Force -Path $emptyPath | Out-Null
$savedPath = $env:PATH

# Keep network substitution in the harness: production has no test/skip knob.
function Invoke-WebRequest {
    [CmdletBinding()]
    param([string]$Uri, [string]$OutFile, [switch]$UseBasicParsing)
    $name = ([uri]$Uri).Segments[-1]
    $expectedUri = "https://github.com/SailfinIO/sailfin/releases/download/v$Version/$name"
    if ($Uri -ne $expectedUri -or $name -notin @($fixtureAsset, 'SHA256SUMS', 'SHA256SUMS.sig')) {
        throw "Unexpected fixture request: $Uri"
    }
    if (($caseName -eq 'missing manifest' -and $name -eq 'SHA256SUMS') -or
        ($caseName -eq 'missing signature' -and $name -eq 'SHA256SUMS.sig')) {
        $exception = New-Object System.Exception('Fixture HTTP 404')
        $exception | Add-Member -NotePropertyName Response -NotePropertyValue ([pscustomobject]@{ StatusCode = 404 })
        throw $exception
    }
    Copy-Item -LiteralPath (Join-Path $fixtureRoot $name) -Destination $OutFile
    if ($caseName -eq 'bad signature' -and $name -eq 'SHA256SUMS.sig') {
        [IO.File]::WriteAllText($OutFile, ('00' * 64))
    }
    if ($caseName -eq 'digest mismatch' -and $name -eq $fixtureAsset) {
        $stream = [IO.File]::Open($OutFile, [IO.FileMode]::Append)
        try { $stream.WriteByte(0) } finally { $stream.Dispose() }
    }
}

try {
    $env:PATH = $emptyPath
    if (Get-Command openssl -ErrorAction SilentlyContinue) {
        throw 'Fixture isolation failed: openssl is still available'
    }
    Write-Host 'OpenSSL unavailable: PATH isolation confirmed'
    $badKey = Join-Path $testRoot 'malformed.pub.pem'
    [IO.File]::WriteAllText($badKey, "-----BEGIN PUBLIC KEY-----`nnot-base64!`n-----END PUBLIC KEY-----`n")
    $cases = @(
        @{ Name = 'signed release'; Expected = $null },
        @{ Name = 'missing manifest'; Expected = 'SHA256SUMS does not exist \(404\)' },
        @{ Name = 'missing signature'; Expected = 'SHA256SUMS\.sig does not exist \(404\)' },
        @{ Name = 'bad signature'; Expected = 'signature verification FAILED' },
        @{ Name = 'digest mismatch'; Expected = 'SHA-256 digest mismatch' },
        @{ Name = 'malformed key'; Expected = 'malformed' }
    )
    foreach ($case in $cases) {
        $caseName = $case.Name
        $work = Join-Path $testRoot ($caseName -replace ' ', '-')
        $key = if ($caseName -eq 'malformed key') { $badKey } else {
            Join-Path $repoRoot '.github/release-signing/ed25519-release.pub.pem'
        }
        $output = New-Object 'System.Collections.Generic.List[string]'
        $failure = $null
        try {
            & $verifierPath -Version $Version -WorkDir $work -PublicKeyPath $key 6>&1 |
                ForEach-Object { $output.Add([string]$_) }
        } catch { $failure = $_.Exception.Message }
        $log = $output -join "`n"
        if ($null -eq $case.Expected) {
            if ($null -ne $failure) { throw "${caseName}: unexpected failure: $failure" }
            if ($log -notmatch 'verified: SHA256SUMS ed25519 signature' -or
                $log -notmatch ('verified: ' + [regex]::Escape($fixtureAsset) + ' sha256 [0-9a-f]{64}')) {
                throw "${caseName}: missing verification evidence: $log"
            }
        } else {
            if ($null -eq $failure -or $failure -notmatch $case.Expected) {
                throw "${caseName}: expected '$($case.Expected)', got '$failure'"
            }
            if ($log -match 'verified:') { throw "${caseName}: failure reported verification success" }
        }
        Write-Host "PASS: $caseName"
    }
} finally {
    $env:PATH = $savedPath
    $resolvedTestRoot = [IO.Path]::GetFullPath($testRoot)
    if (-not $resolvedTestRoot.StartsWith($scratchRoot + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing cleanup outside scratch: $resolvedTestRoot"
    }
    Remove-Item -LiteralPath $resolvedTestRoot -Recurse -Force
}
Write-Host 'All Windows release seed verification fixtures passed.'
