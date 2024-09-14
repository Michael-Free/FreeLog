class FreeLog (
  [bool]$IsValid = $true
  
  [string]$LogFilePath
  
  ([string]$logFilePath) {
    $this.LogFilePath = $logFilePath
    $this:EnsureLogFileExists()
  }

  [void]EnsureLogFileExists() {
    if (-not (Test-Path -Path $this.LogFilePath)) {
      try {
        New-Item -Path $this.LogFilePath -ItemType File -Force
        $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        $logEntry = "CREATED - $timestamp - Log File Created..."
        Add-Content -Path $this.LogFilePath -Value $logEntry
        $this.IsValid = $true
      } catch {
        $this.IsValid = $false
        throw "Initialization failed: $_"
      }
    }

  [void] Log([string]$message) {
    if (-not $this.IsValid) {
      throw "Cannot execute LOG method because log file not writeable."
    }
    try {
      $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
      $logEntry = "LOG - $timestamp - $message"
      Add-Content -Path $this.LogFilePath -Value $logEntry
    } catch {
      throw "LOG method failure: $_"
    }
  }
)
