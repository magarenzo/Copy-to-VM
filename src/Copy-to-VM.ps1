<#
.SYNOPSIS
    Copy files from host Windows machine to local virtual machine

.DESCRIPTION
    Found this nifty PowerShell cmdlet "Copy-VMFile" to copy a file to a virtual machine, so I put it inside this script with parameters and simple logging for ease of use.

.PARAMETER VirtualMachineName
    Name of the virtual machine we are copying the file to.

.PARAMETER PathSource
    Full path to the source file we are copying from the host machine, including the file name.

.PARAMETER PathDestination
    Full path of the destination we are copying to on the VM, including the new file name.

.EXAMPLE
    PS >.\Copy-To-VM.ps1 `
    -VirtualMachineName "Example-VM-Name" `
    -SourcePath "C:\Example-File.txt" `
    -DestinationPath "D:\Example-Directory\Example-File.txt" `
#>

Param (
    $VirtualMachineName="",
    $SourcePath="",
    $DestinationPath=""
)

Function WriteLog {
    Param (
        [string] $Message,
        [switch] $Err
    )
    $LogFile = "Copy-to-VM.log"
    If (!(Test-Path $LogFile)) {
        New-Item $LogFile
    }
    $Now = Get-Date -Format "HH:mm:ss"
    $Line = "$Now`t$Message"
    $Line | Add-Content $LogFile -Encoding UTF8
    If ($Err) {
        Write-Host $Line -ForegroundColor Red
    } Else {
        Write-Host $Line
    }
}

WriteLog "STARTED: Copy-to-VM.ps1."

Try {
    $Command = "Copy-VMFile $VirtualMachineName -SourcePath $SourcePath -DestinationPath $DestinationPath -CreateFullPath -FileSource Host"
    Invoke-Expression $Command
} Catch {
    WriteLog -Err "ERROR: Copying file to VM."
}

WriteLog "COMPLETED: Copy-to-VM.ps1."
WriteLog "--------------------------------------------------"