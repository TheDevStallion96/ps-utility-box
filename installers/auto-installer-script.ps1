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
