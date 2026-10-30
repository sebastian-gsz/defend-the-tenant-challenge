# Tarea 08 - Prevenir anonymous Teams meeting join

## Objetivo
Global Teams meeting policy: Disable "Anonymous users can join a meeting". (Requiring lobby wait is NOT equivalent.)

## Mejor enfoque y por que
AllowAnonymousUsersToJoinMeeting = $false (boolean, no solo lobby).

## Comandos
```powershell
Set-CsTeamsMeetingPolicy -Identity Global -AllowAnonymousUsersToJoinMeeting $false
```