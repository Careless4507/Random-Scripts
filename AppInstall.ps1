# Define the GitHub repository containing the list of applications to install
$githubRepo = "https://raw.githubusercontent.com/ZmanJL/Random-Scripts/master/AppList.txt"

# Retrieve the list of applications from the GitHub repository
$applications = Invoke-WebRequest -Uri $githubRepo -UseBasicParsing | Select-Object -ExpandProperty Content

# Check if Chocolatey is installed, and install it if not
if (!(Get-Command choco -errorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Loop through the list of applications and install each one
foreach ($application in $applications) {
    # Remove any illegal characters and whitespace from the application name
    $sanitizedApplication = [System.IO.Path]::GetInvalidFileNameChars() | ForEach-Object {$application = $application.Replace($_, '')}
    $sanitizedApplication = $sanitizedApplication.Trim()

    # Install the application using Chocolatey
    choco install $sanitizedApplication -y
}
