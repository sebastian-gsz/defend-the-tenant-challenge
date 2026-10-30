# Tarea 02 - Bloquear autenticacion legacy

## Objetivo
Bloquear sign-ins legacy para All users, All resources, cubriendo Exchange ActiveSync y Other clients, con exclusiones aprobadas.

## Mejor enfoque y por que
Politica CA con clientAppTypes = [exchangeActiveSync, other] y grant block (OR). El assessment acepta clientAppTypes sin "all" si contiene ambos (modo Legacy). Usar OR con block es el patron correcto (block es el unico control).

## Comandos
```powershell
$body = @{
  displayName = "Block Legacy Auth"; state = "enabled"
  conditions = @{ users = @{ includeUsers = @("All") }; applications = @{ includeApplications = @("All") }; clientAppTypes = @("exchangeActiveSync","other") }
  grantControls = @{ operator = "OR"; builtInControls = @("block") }
}
Invoke-MgGraphRequest -Method POST -Uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies" -Body ($body | ConvertTo-Json -Depth 10) -ContentType "application/json"
```