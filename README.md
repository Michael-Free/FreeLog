# FreeLog
A simple and robust logging module that works cross-platform in Powershell.


## Description
**FreeLog** is a PowerShell module designed for logging purposes, providing functionality to log messages, warnings, errors, and failures to a specified log file. 

## Features
- Create a new log file.
- Log messages with timestamps.
- Log different levels of messages: logs, warnings, errors, and failures.

## Installation
```Install-Module FreeLog```

## Usage
### Import Module

``` Import-Module FreeLog```

### Create New Log File
```New-LogFile -Path "C:\Logs\mylogfile.log"```

### Write to the Log File
- ```Write-LogFile -Log "This is a test log message"```
- ```Write-LogFile -Warn "This is a warning message"```
- ```Write-LogFile -Err "This is an error message"```
- ```Write-LogFile -Fail "This is a failure message"```


- ```Log```: Log a normal message.
- ```Warn```: Log a warning message.
- ```Err```: Log an error message.
- ```Fail```: Log a failure message.

## Requirements
-  PowerShell 5.1 or higher (for Windows) or PowerShell 7.0 or higher (cross-platform).

## Author
Michael Free