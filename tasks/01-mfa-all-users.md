# Tarea 01 - MFA para todos los usuarios (y roles administrativos)

## Objetivo
MFA obligatoria para All users, All resources, exclusiones aprobadas. Tambien cubre MFA para roles administrativos (via all-users policy).

## Mejor enfoque y por que
Una sola politica CA "All users" satisface tanto "MFA for all users" como "MFA for administrative roles" en el assessment (allUsersCovered=true). Evita duplicar politicas y reduce superficie de error. MFA debe ser grant obligatorio (AND, builtInControls=[mfa]), no alternativa (no OR con otros controles).

## Comandos (pwsh en WSL, Graph conectado)
```powershell
$body = @{
  displayName = "MFA - All Users"; state = "enabled"
  conditions = @{ users = @{ includeUsers = @("All") }; applications = @{ includeApplications = @("All") }; clientAppTypes = @("all") }
  grantControls = @{ operator = "AND"; builtInControls = @("mfa") }
}
Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies" -Body ($body | ConvertTo-Json -Depth 10) -ContentType "application/json"
```

## Verificacion
- Policy state = enabled
- includeUsers contains "All"
- includeApplications contains "All"
- grantControls.builtInControls contains "mfa" con operator AND
- clientAppTypes contains "all" (para que sea broad policy)