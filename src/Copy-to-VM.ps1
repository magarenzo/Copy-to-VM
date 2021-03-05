<# Copy files from host Windows machine to local virtual machine #>

param (
    $VirtualMachineName="",
    $SourcePath="",
    $DestinationPath=""
)

Write-Output "$(Get-Date -Format 'HH:mm:ss') - STARTED - Copy to VM"

$Command = "Copy-VMFile $VirtualMachineName -SourcePath $SourcePath -DestinationPath $DestinationPath -CreateFullPath -FileSource Host"
Invoke-Expression $Command

Write-Output "$(Get-Date -Format 'HH:mm:ss') - COMPLETED - Copy to VM"