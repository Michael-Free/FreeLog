# FreeLog.Tests.ps1

Import-Module "/home/michael/.local/share/powershell/Modules/FreeLog/FreeLog.psm1"

Describe "FreeLog Class Tests" {
    
    InModuleScope FreeLog {
        
        BeforeEach {
            $testFilePath = Join-Path -Path "/tmp" -ChildPath (New-Guid).Guid + ".log"
            Register-EngineEvent PowerShell.Exiting -SupportEvent -Action { Remove-Item -Path $testFilePath -ErrorAction SilentlyContinue }
        }

        AfterEach {
            if (Test-Path $testFilePath) {
                Remove-Item -Path $testFilePath -ErrorAction SilentlyContinue
            }
        }

        It "Should throw an error if LogFilePath is null" {
            { [FreeLog]::new($null) } | Should -Throw "LogFilePath cannot be null or empty."
        }

        It "Should throw an error if LogFilePath is empty" {
            { [FreeLog]::new("") } | Should -Throw "LogFilePath cannot be null or empty."
        }

        It "Can create a FreeLog object with a valid path" {
            $logger = [FreeLog]::new($testFilePath)
            $logger | Should -Not -BeNullOrEmpty
            $logger.LogFilePath | Should -Be $testFilePath
        }

        It "Can create a log entry in the log file" {
            $logger = [FreeLog]::new($testFilePath)
            $logger.Log("Test message")

            $content = Get-Content $testFilePath -Raw
            $content | Should -Match "Test message"
       }

       #It "Should throw an error when attempting to log to an invalid file path" {
       #    $logger = [FreeLog]::new("/invalid/path/to/logfile.log")
       #    { $logger.Log("This should fail") } | Should -Throw
       #}

       It "Can log warnings and errors" {
           $logger = [FreeLog]::new($testFilePath)
           $logger.Warn("This is a warning")
           $logger.Error("This is an error")

           $content = Get-Content $testFilePath -Raw
           $content | Should -Match "WARN     -"
           $content | Should -Match "This is a warning"
           $content | Should -Match "ERROR    -"
           $content | Should -Match "This is an error"
       }
    }
}
