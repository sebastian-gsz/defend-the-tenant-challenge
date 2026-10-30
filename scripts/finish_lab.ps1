$ErrorActionPreference = 'Stop'
$tenantId = "0ce1ea09-e064-4265-83e2-341018b19d7d"
$user = "admin@WWLCPx52164899.onmicrosoft.com"

# --- Graph device code ---
$scopes = @("AuditLog.Read.All","Policy.Read.All","RoleManagement.Read.Directory","SecurityEvents.Read.All","User.Read.All","Application.ReadWrite.All","AppRoleAssignment.ReadWrite.All","Directory.Read.All","Domain.Read.All","LicenseAssignment.Read.All","Organization.Read.All","Policy.ReadWrite.Authorization","Policy.ReadWrite.ConditionalAccess","RoleManagement.ReadWrite.Directory","User.Create")
Write-Host "GRAPH_DEVICE_CODE_START"
Connect-MgGraph -TenantId $tenantId -Scopes $scopes -UseDeviceCode -NoWelcome -ErrorAction Stop
$ctx = Get-MgContext
Write-Host "GRAPH_CONNECTED Tenant=$($ctx.TenantId)"

# --- Teams device code ---
Write-Host "TEAMS_DEVICE_CODE_START"
Connect-MicrosoftTeams -TenantId $tenantId -UseDeviceAuthentication -ErrorAction Stop
Write-Host "TEAMS_CONNECTED"

# --- Upsert User Risk CA policy ---
function Upsert-CaPolicy {
    param([string]$DisplayName, [hashtable]$Body)
    $existing = @(Invoke-MgGraphRequest -Method GET -Uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies" -ErrorAction Stop).value | Where-Object displayName -eq $DisplayName
    if ($existing.Count -gt 0) {
        $id = $existing[0].id
        Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies/$id" -Body ($Body | ConvertTo-Json -Depth 10) -ContentType "application/json" -ErrorAction Stop | Out-Null
        Write-Host "Updated CA policy: $DisplayName"
    } else {
        $r = Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies" -Body ($Body | ConvertTo-Json -Depth 10) -ContentType "application/json" -ErrorAction Stop
        Write-Host "Created CA policy: $DisplayName"
    }
}

Upsert-CaPolicy -DisplayName "User Risk High - Remediation" -Body @{
    displayName = "User Risk High - Remediation"; state = "enabled"
    conditions = @{ users = @{ includeUsers = @("All") }; applications = @{ includeApplications = @("All") }; userRiskLevels = @("high") }
    grantControls = @{ operator = "AND"; builtInControls = @("mfa","passwordChange") }
    sessionControls = @{ signInFrequency = @{ isEnabled = $true; frequencyInterval = "everyTime"; authenticationType = "primaryAndSecondaryAuthentication" } }
}

# --- App consent ---
$authBody = @{ defaultUserRolePermissions = @{ permissionGrantPoliciesAssigned = @() } }
Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/v1.0/policies/authorizationPolicy" -Body ($authBody | ConvertTo-Json -Depth 5) -ContentType "application/json" -ErrorAction Stop | Out-Null
Write-Host "Disabled user app consent."

# --- Teams meeting policy ---
Set-CsTeamsMeetingPolicy -Identity Global -AutoAdmittedUsers "InvitedUsers" -DesignatedPresenterRoleMode "OrganizerOnlyUserOverride" -AllowAnonymousUsersToJoinMeeting $false -ErrorAction Stop
$tp = Get-CsTeamsMeetingPolicy -Identity Global
Write-Host "Teams: AutoAdmittedUsers=$($tp.AutoAdmittedUsers) DesignatedPresenterRoleMode=$($tp.DesignatedPresenterRoleMode) AllowAnonymousUsersToJoinMeeting=$($tp.AllowAnonymousUsersToJoinMeeting)"

Write-Host "FINISH_LAB_DONE"