#Requires -Version 5

[CmdletBinding()]
Param()

Write-Output "Queuing FOSSA Checks..."
. $env:ALLUSERSPROFILE\fossa-cli\fossa.exe
Write-Output "FOSSA Checks Queued Successfully!"

$FOSSA_FAIL_BUILD_TOGGLE = "false"
if (Test-Path env:FOSSA_FAIL_BUILD) {
    $FOSSA_FAIL_BUILD_TOGGLE = $env:FOSSA_FAIL_BUILD.toLower()
}

if ($env:FOSSA_FAIL_BUILD_TOGGLE -eq "true") {
    Write-Output "FOSSA Fail Build Flag Enabled.  Checking for Policy Violations..."
    . $env:ALLUSERSPROFILE\fossa-cli\fossa.exe test
    $FOSSA_EXIT_CODE = $LASTEXITCODE
    
    Write-Output "FOSSA Policy Violations check returned : $FOSSA_EXIT_CODE (non-zero codes are failures)"
    exit $FOSSA_EXIT_CODE
}
