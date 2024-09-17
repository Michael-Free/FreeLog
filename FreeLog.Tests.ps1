# FreeLog.Tests.ps1
Import-Module FreeLog.psm1

BeforeAll {
    $env:TEST_MODE = $true
    Import-Module FreeLog.psm1
}

AfterAll {
    Remove-Module FreeLog.psm1
    Remove-Item env:\TEST_MODE
}

Describe "FreeLog Class Tests" {
  BeforeEach {
        $testFilePath = [System.IO.Path]::GetTempFileName()
        Register-EngineEvent PowerShell.Exiting -SupportEvent -Action { Remove-Item -Path $testFilePath -ErrorAction SilentlyContinue }
    }

    It "Should thorw an error if LogFilePath is Null" {
        $logger = [FreeLog]::new($null)
        { $logger.EnsureLogFileExists() } | Should -Throw "LogFilePath cannot be null or empty."
    }


    It "Should thorw an error if LogFilePath is empty" {
        $logger = [FreeLog]::new("")
        { $logger.EnsureLogFileExists() } | Should -Throw "LogFilePath cannot be null or empty."
    }
    
    It "Can create a FreeLog object" {
    #working on this...
        $log = [FreeLog]::new($testFilePath)
        #$log | Should -Not -BeNullOrEmpty
    }

    It "Can log a message" {
        $log = [FreeLog]::new("")
        $log.Log("Test message")
    }

    # Add tests for other methods...
}
#Describe "FreeLog Initializing Class Tests" {
#  BeforeEach {
#    $testFilePath = [System.IO.Path]::GetTempFileName()
#    Register-EngineEvent PowerShell.Exiting -SupportEvent -Action { Remove-Item -Path $testFilePath -ErrorAction SilentlyContinue }
#    }
#    It "should throw an error if LogFilePath is null" {
#      $logger = [FreeLog]::new($null)
#      { $logger.EnsureLogFileExists() } | Should -Throw "LogFilePath cannot be null or empty."
#    }
#}
