# Tarea 03 - MFA por riesgo de inicio de sesion (Medium/High)

## Objetivo
Politica de sign-in risk para All users, All resources: MFA cuando riesgo Medium o High, reautenticacion Every time (primary + MFA).

## Mejor enfoque y por que
signInRiskLevels = [medium, high]. grant MFA (AND). sessionControls.signInFrequency con frequencyInterval="everyTime" (no value/type). El assessment lee frequency.frequencyInterval. Usar everyTime es obligatorio para risk policies.

## Comandos
```powershell
$body = @{
  displayName = "MFA - Sign-in Risk Medium+High"; state = "enabled"
  conditions = @{ users = @{ includeUsers = @("All") }; applications = @{ includeApplications = @("All") }; signInRiskLevels = @("medium","high") }
  grantControls = @{ operator = "AND"; builtInControls = @("mfa") }
  sessionControls = @{ signInFrequency = @{ isEnabled = $true; frequencyInterval = "everyTime"; authenticationType = "primaryAndSecondaryAuthentication" } }
}
Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies" -Body ($body | ConvertTo-Json -Depth 10) -ContentType "application/json"
```