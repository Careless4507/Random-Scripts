# Define the GitHub repository URL
$repoUrl = "https://raw.githubusercontent.com/ZmanJL/Random-Scripts/master/AppList.txt"

# Download the list of applications from the GitHub repository
$appList = Invoke-WebRequest -Uri $repoUrl -UseBasicParsing

# Split the list of applications into an array
$apps = $appList.Content.Split("`n")

# Loop through the array of applications
foreach ($app in $apps) {
  # Check if the application is not empty
  if ($app -ne "") {
    # Install the application using Chocolatey
    choco install $app -y
  }
}
