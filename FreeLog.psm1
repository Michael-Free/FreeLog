class FreeLog (
  [string]$LogFilePath
  ([string]$logFilePath) {
    $this.LogFilePath = $logFilePath
    $this:EnsureLogFileExists()
  }

  [void]EnsureLogFileExists() {
    if (-not (Test-Path -Path $this.LogFilePath)) {
      # Add Try/Catch Here
      New-Item -Path $this.LogFilePath -ItemType File -Force
      $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
      $logEntry = "CREATED - $timestamp - Log File Created..."
      Add-Content -Path $this.LogFilePath -Value $logEntry
    }
)
