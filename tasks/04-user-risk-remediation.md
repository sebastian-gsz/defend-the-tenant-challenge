# Tarea 04 - Remediacion de riesgo de usuario (High)

## Objetivo
Politica user-risk para All users, All resources: riesgo High -> MFA + remediacion. Usar UN SOLO control de remediacion (passwordChange o riskRemediation, no ambos). Reautenticacion Every time.

## Mejor enfoque y por que
grantControls = AND, [mfa, passwordChange] (remediation count = 1). Si se usara riskRemediation, requiere authenticationStrength y NO built-in mfa. Elegir passwordChange es mas simple y evita conflicto. frequencyInterval=everyTime (obligatorio con passwordChange).

## Comandos
```powershell
$body = @{
  displayName = "User Risk High - Remediation"; state = "enabled"
  conditions = @{ users = @{ includeUsers = @("All") }; applications = @{ includeApplications = @("All") }; userRiskLevels = @("high") }
  grantControls = @{ operator = "AND"; builtInControls = @("mfa","passwordChange") }
  sessionControls = @{ signInFrequency = @{ isEnabled = $true; frequencyInterval = "everyTime"; authenticationType = "primaryAndSecondaryAuthentication" } }
}
Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies" -Body ($body | ConvertTo-Json -Depth 10) -ContentType "application/json"
```