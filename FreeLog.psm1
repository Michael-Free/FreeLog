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

  [void] Warn([string]$message) {
    if (-not $this.IsValid) {
      throw "Cannot execute WARN method because log file not writeable."
    }
    try {
      $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
      $logEntry = "WARNING - $timestamp - $message"
      Add-Content -Path $this.LogFilePath -Value $logEntry
    } catch {
      throw "WARN method failure: $_"
    }
  }

  [void] Error([string]$message) {
    if (-not $this.IsValid) {
      throw "Cannot execute ERROR method because log file not writeable."
    }
    try {
      $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
      $logEntry = "ERROR - $timestamp - $message"
      Add-Content -Path $this.LogFilePath -Value $logEntry
    } catch {
      throw "ERROR method failure: $_"
    }
  }
)
