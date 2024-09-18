# FreeLog.Functions.Tests.ps1

Describe "FreeLog Function Tests" {

    BeforeEach {
        $testFilePath = Join-Path -Path "/tmp" -ChildPath (New-Guid).Guid + ".log"
        Register-EngineEvent PowerShell.Exiting -SupportEvent -Action { Remove-Item -Path $testFilePath -ErrorAction SilentlyContinue }
    }

    AfterEach {
        if (Test-Path $testFilePath) {
            Remove-Item -Path $testFilePath -ErrorAction SilentlyContinue
        }
    }

    It "New-LogFile should initialize a FreeLog instance and create a log file" {
        New-LogFile -Path $testFilePath
        Test-Path -Path $testFilePath | Should -Be $true
        $content = Get-Content $testFilePath -Raw
        $content | Should -Match "CREATED"
    }

    It "Write-LogFile should write a log entry to the log file" {
        New-LogFile -Path $testFilePath
        Write-LogFile -Log "This is a test log message"
        $content = Get-Content -Path $testFilePath -Raw
        $content | Should -Match "This is a test log message"
        $content | Should -Match "CREATED"
    }

    #It "Write-LogFile should throw an error if logger is not initialized" {
    #    #$script:logger = $null
    #    { Write-LogFile -Log "This should fail" } | Should -Throw "Logger not initialized. Run New-LogFile first."
    #}

    It "Write-LogFile should log a warning message" {
        New-LogFile -Path $testFilePath
        Write-LogFile -Warn "This is a test warning"
        $content = Get-Content -Path $testFilePath -Raw
        $content | Should -Match "WARN"
        $content | Should -Match "This is a test warning"
    }

    It "Write-LogFile should log an error message" {
        New-LogFile -Path $testFilePath
        Write-LogFile -Err "This is a test error"
        $content = Get-Content -Path $testFilePath -Raw
        $content | Should -Match "ERROR"
        $content | Should -Match "This is a test error"
    }

    It "Write-LogFile should log a failure message" {
        New-LogFile -Path $testFilePath
        Write-LogFile -Fail "This is a test failure"
        $content = Get-Content -Path $testFilePath -Raw
        $content | Should -Match "FAIL"
        $content | Should -MAtch "This is a test failure"
    }
}
