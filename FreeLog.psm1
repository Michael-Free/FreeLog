class FreeLog {
    [bool]$IsValid = $true
    [string]$LogFilePath

    FreeLog([string]$logFile) {
        $this.LogFilePath = $logFile
        $this.EnsureLogFileExists()
    }

    [bool]IsValidParam([string]$param) {
        return -not [string]::IsNullOrEmpty($param)
    }

    [void]EnsureLogFileExists() {
        if (-not $this.IsValidParam($this.LogFilePath)) {
            $this.IsValid = $false
            throw "LogFilePath cannot be null or empty."
        }
        if (-not (Test-Path -Path $this.LogFilePath)) {
            try {
                New-Item -Path $this.LogFilePath -ItemType File -Force
                $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
                $logEntry = "CREATED - $timestamp - Log File Created..."
                Add-Content -Path $this.LogFilePath -Value $logEntry
                Write-Verbose $logEntry
                $this.IsValid = $true
            } catch {
                $this.IsValid = $false
                throw "Initialization failed: $_"
            }
        }
    }

    [void]Log([string]$message) {
        if (-not $this.IsValid) {
            throw "Cannot execute LOG method because log file is not writeable."
        }
        try {
            $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            $logEntry = "LOG - $timestamp - $message"
            Add-Content -Path $this.LogFilePath -Value $logEntry
            Write-Verbose $logEntry
            $this.IsValid = $true
        } catch {
            $this.IsValid = $false
            throw "LOG method failure: $_"
        }
    }

    [void]Warn([string]$message) {
        if (-not $this.IsValid) {
            throw "Cannot execute WARN method because log file is not writeable."
        }
        try {
            $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            $logEntry = "WARNING - $timestamp - $message"
            Add-Content -Path $this.LogFilePath -Value $logEntry
            Write-Verbose $logEntry
            $this.IsValid = $true
        } catch {
            $this.IsValid = $false
            throw "WARN method failure: $_"
        }
    }

    [void]Error([string]$message) {
        if (-not $this.IsValid) {
            throw "Cannot execute ERROR method because log file is not writeable."
        }
        try {
            $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            $logEntry = "ERROR - $timestamp - $message"
            Add-Content -Path $this.LogFilePath -Value $logEntry
            Write-Verbose $logEntry
            $this.IsValid = $true
        } catch {
            $this.IsValid = $false
            throw "ERROR method failure: $_"
        }
    }

    [void]Fail([string]$message) {
        if (-not $this.IsValid) {
            throw "Cannot execute FAIL method because log file is not writeable."
        }
        try {
            $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            $logEntry = "FAIL - $timestamp - $message"
            Add-Content -Path $this.LogFilePath -Value $logEntry
            Write-Verbose $logEntry
            $this.IsValid = $true
        } catch {
            $this.IsValid = $false
            throw "FAIL method failure: $_"
        }
    }
}

function Create-Log() {
    ### Create a log file and set params
}

function Write-Log() {
    #write to log file, create params - Error, Warn, Fail, 

}
