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
    }
)
