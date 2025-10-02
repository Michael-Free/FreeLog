$logger = $null

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
                $logEntry = "CREATED  - $timestamp - Log File Created..."
                Add-Content -Path $this.LogFilePath -Value $logEntry
                Write-Verbose $logEntry
                $this.IsValid = $true
                $this.LogFilePath
            } 
            catch {
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
            $logEntry = "LOG      - $timestamp - $message"
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
            $logEntry = "WARN     - $timestamp - $message"
            Add-Content -Path $this.LogFilePath -Value $logEntry
            Write-Verbose $logEntry
            $this.IsValid = $true
        } 
        catch {
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
            $logEntry = "ERROR    - $timestamp - $message"
            Add-Content -Path $this.LogFilePath -Value $logEntry
            Write-Verbose $logEntry
            $this.IsValid = $true
        } 
        catch {
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
            $logEntry = "FAIL     - $timestamp - $message"
            Add-Content -Path $this.LogFilePath -Value $logEntry
            Write-Verbose $logEntry
            $this.IsValid = $true
        }
        catch {
            $this.IsValid = $false
            throw "FAIL method failure: $_"
        }
    }
}


function New-LogFile {
    [CmdletBinding(SupportsShouldProcess=$true)]
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Path
    )
    if (-not [string]::IsNullOrEmpty($Path)) {
        if ($PSCmdlet.ShouldProcess($Path, "Creating log file")) {
            $script:logger = [FreeLog]::new($Path)
            if (-not (Test-Path -Path $Path)) {
                New-Item -Path $Path -ItemType File -Force
            }
        }
    } 
    else {
        throw "Path cannot be null or empty."
    }
}


function Write-LogFile {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$Message,
        
        [Parameter(Mandatory=$false)]
        [switch]$Warn,
        
        [Parameter(Mandatory=$false)]
        [switch]$Error,
        
        [Parameter(Mandatory=$false)]
        [switch]$Fail
    )
    
    process {
        if ($null -eq $script:logger) {
            throw "Logger not initialized. Run New-LogFile first."
        }

        if ($Fail) {
            $script:logger.Fail($Message)
        } elseif ($Error) {
            $script:logger.Error($Message)
        } elseif ($Warn) {
            $script:logger.Warn($Message)
        } else {
            $script:logger.Log($Message)
        }
    }
}

