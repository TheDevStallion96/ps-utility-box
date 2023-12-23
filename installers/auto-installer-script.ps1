<#
Script Overview:
This PowerShell script automates the installation of an application using a provided installer file. It allows customization of parameters such as the installer file path, installation location, command-line arguments, and provides options to wait for the installation to complete.

Prerequisites:
- PowerShell version 5.1 or later.

Customizable Parameters:
- $FileName: Full path to the installer file.
- $Location: Location where the installer should be run.
- $Arguments: Additional command-line arguments for silent installation.

Additional Customization Options:
- $WaitForCompletion: Set to $true to wait for the installation process to complete.
- $SuccessMessage: Message displayed on successful installation.
- $FailureMessage: Message displayed on installation failure, with the exit code.

Sections/Functions:
1. Customizable Parameters: Definition of parameters that users can modify.
2. Additional Customization Options: Definition of optional settings.
3. Installation Process: Execution of the installer with optional wait and result messaging.

Variables:
- $Process: Holds the Start-Process result for monitoring the installation.

Pitfalls/Limitations:
- Requires PowerShell 5.1 or later.
- Assumes the provided installer supports silent installation.

Examples:
- Basic usage:
    .\Script.ps1
- Customized usage:
    .\Script.ps1 -FileName "C:\Path\To\CustomInstaller.exe" -Location "D:\InstallDir" -Arguments "/S /CustomOption"
#>

# Customizable parameters
$FileName = "C:\Path\To\Installer.exe"    # Specify the full path to the installer file
$Location = "C:\Path\To"                   # Specify the location where the installer should be run
$Arguments = "/S"                          # Specify any additional command-line arguments for silent installation

# Additional customization options
$WaitForCompletion = $true                 # Set to $true to wait for the installation process to complete
$SuccessMessage = "Application installed successfully."
$FailureMessage = "Installation failed with exit code {0}."

# Run the installer file and wait for completion if specified
$Process = Start-Process -FilePath $FileName -ArgumentList $Arguments -WorkingDirectory $Location -PassThru

# Check if the user wants to wait for the installation process to complete
if ($WaitForCompletion) {
    $Process.WaitForExit()

    # Check the exit code and display a message
    if ($Process.ExitCode -eq 0) {
        Write-Host $SuccessMessage
    } else {
        Write-Host ($FailureMessage -f $Process.ExitCode)
    }
} else {
    # Display a message indicating that the process is running in the background
    Write-Host "Installation process started in the background. Use the provided process ID ($($Process.Id)) for monitoring if needed."
}
