$ErrorActionPreference = 'Stop'
$mods = @("Microsoft.Graph.Authentication","Microsoft.Graph.Identity.SignIns","Microsoft.Graph.Identity.Governance","MicrosoftTeams","ExchangeOnlineManagement")
foreach ($m in $mods) {
    if (-not (Get-Module -ListAvailable -Name $m)) {
        Write-Host "Installing $m..."
        Install-Module -Name $m -Scope AllUsers -Force -AllowClobber -Repository PSGallery
    } else {
        Write-Host "$m already installed"
    }
}
Write-Host "DONE"
foreach ($m in $mods) { Get-Module -ListAvailable -Name $m | Sort-Object Version -Descending | Select-Object -First 1 Name,Version | Out-Host }