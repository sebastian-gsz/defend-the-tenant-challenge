# Tarea 05 - Prevenir consentimiento de apps por usuarios ordinarios

## Objetivo
Deshabilitar self-consent de usuarios ordinarios (incluido consentimiento limitado para verified publishers / low-risk permissions).

## Mejor enfoque y por que
PATCH authorizationPolicy: defaultUserRolePermissions.permissionGrantPoliciesAssigned = []. Array vacio = sin politicas de grant asignadas = consentimiento deshabilitado totalmente.

## Comandos
```powershell
$authBody = @{ defaultUserRolePermissions = @{ permissionGrantPoliciesAssigned = @() } }
Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/v1.0/policies/authorizationPolicy" -Body ($authBody | ConvertTo-Json -Depth 5) -ContentType "application/json"
```