$ErrorActionPreference = 'Stop'
Write-Host "Installing Microsoft.Graph (meta)..."
Install-Module Microsoft.Graph -Scope AllUsers -Force -AllowClobber -Repository PSGallery
Write-Host "Installing MicrosoftTeams..."
Install-Module MicrosoftTeams -Scope AllUsers -Force -AllowClobber -Repository PSGallery
Write-Host "Done."
Get-Module -ListAvailable Microsoft.Graph.Authentication, MicrosoftTeams | Select-Object Name, Version