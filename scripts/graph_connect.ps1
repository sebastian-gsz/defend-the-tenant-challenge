$ErrorActionPreference = 'Stop'
$tenantId = "0ce1ea09-e064-4265-83e2-341018b19d7d"
$scopes = @(
  "AuditLog.Read.All","Policy.Read.All","RoleManagement.Read.Directory","SecurityEvents.Read.All","User.Read.All",
  "Application.ReadWrite.All","AppRoleAssignment.ReadWrite.All","Directory.Read.All","Domain.Read.All","LicenseAssignment.Read.All",
  "Organization.Read.All","Policy.ReadWrite.Authorization","Policy.ReadWrite.ConditionalAccess","RoleManagement.ReadWrite.Directory","User.Create"
)
Write-Host "Starting Graph device-code auth for tenant $tenantId"
Connect-MgGraph -TenantId $tenantId -Scopes $scopes -UseDeviceCode -NoWelcome -ErrorAction Stop
$ctx = Get-MgContext
Write-Host "GRAPH_CONNECTED Tenant=$($ctx.TenantId) Auth=$($ctx.AuthType) Account=$($ctx.Account)"