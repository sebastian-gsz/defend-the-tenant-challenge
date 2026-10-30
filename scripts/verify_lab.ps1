$ErrorActionPreference = 'Stop'
$tenantId = "0ce1ea09-e064-4265-83e2-341018b19d7d"
$scopes = @("Policy.Read.All","Directory.Read.All","RoleManagement.Read.Directory","Application.Read.All")
Write-Host "GRAPH_VERIFY_START"
Connect-MgGraph -TenantId $tenantId -Scopes $scopes -UseDeviceCode -NoWelcome -ErrorAction Stop
Write-Host "GRAPH_OK"

$policies = (Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies").value
Write-Host "=== CA POLICIES ==="
$policies | ForEach-Object { Write-Host "$($_.displayName) | state=$($_.state) | users=$($_.conditions.users.includeUsers -join ',') | clientApp=$($_.conditions.clientAppTypes -join ',') | grant=$($_.grantControls.builtInControls -join ',') | riskSignIn=$($_.conditions.signInRiskLevels -join ',') | riskUser=$($_.conditions.userRiskLevels -join ',') | freq=$($_.sessionControls.signInFrequency.frequencyInterval)" }

$auth = Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/policies/authorizationPolicy"
Write-Host "=== APP CONSENT ==="
Write-Host "permissionGrantPoliciesAssigned: $($auth.defaultUserRolePermissions.permissionGrantPoliciesAssigned -join ', ')"

Write-Host "TEAMS_VERIFY_START"
Connect-MicrosoftTeams -TenantId $tenantId -UseDeviceAuthentication -ErrorAction Stop
Write-Host "TEAMS_OK"
$tp = Get-CsTeamsMeetingPolicy -Identity Global
Write-Host "=== TEAMS GLOBAL ==="
Write-Host "AutoAdmittedUsers=$($tp.AutoAdmittedUsers)"
Write-Host "DesignatedPresenterRoleMode=$($tp.DesignatedPresenterRoleMode)"
Write-Host "AllowAnonymousUsersToJoinMeeting=$($tp.AllowAnonymousUsersToJoinMeeting)"

Write-Host "VERIFY_DONE"