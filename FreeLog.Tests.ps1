# FreeLog.Tests.ps1
Import-Module .\FreeLog.psm1

Describe "FreeLog Tests" {
  BeforeEach {
    $testFilePath = [System.IO.Path]::GetTempFileName()
    Register-EngineEvent PowerShell.Exiting -SupportEvent -Action { Remove-Item -Path $testFilePath -ErrorAction SilentlyContinue }
    }
    # Initialization Tests
    It "" {}
    It "" {}
    It "" {}
    It "" {}
    It "" {}
}
