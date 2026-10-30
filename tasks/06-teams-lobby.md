# Tarea 06 - Invited-participant Teams lobby bypass

## Objetivo
Global Teams meeting policy: Who can bypass the lobby = People who were invited.

## Mejor enfoque y por que
Propiedad AutoAdmittedUsers = "InvitedUsers". Set-CsTeamsMeetingPolicy -AutoAdmittedUsers "InvitedUsers".

## Comandos
```powershell
Set-CsTeamsMeetingPolicy -Identity Global -AutoAdmittedUsers "InvitedUsers"
```