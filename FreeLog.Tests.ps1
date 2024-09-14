# FreeLog.Tests.ps1
Import-Module .\FreeLog.psm1

Describe "FreeLog Initializing Tests" {
  BeforeEach {
    $testFilePath = [System.IO.Path]::GetTempFileName()
    Register-EngineEvent PowerShell.Exiting -SupportEvent -Action { Remove-Item -Path $testFilePath -ErrorAction SilentlyContinue }
    }
    It "should throw an error if LogFilePath is null" {
      $logger = [MyClass]::new($null)
      { $logger.EnsureLogFileExists() } | Should -Throw "LogFilePath cannot be null or empty."
    }
    It "should throw an error if LogFilePath is empty" {
    
    }
    It "should throw an error if LogFilePath directory not exist" {
    
    }
    It "should throw an error if LogFilePath directory not writeable" {
    
    }
    It "should not throw an error if LogFilePath directory writeable" {
    
    }
    It "should create logFile if LogFilePath directory exists" {
    
    }
    It "should add content to Logfile once created with CREATE word" {
    
    }
    It "should append to a prexisting logfile and have a second CREATE word" {
    
    }
}
