# Tarea 07 - Organizer-only default Teams presenters

## Objetivo
Global Teams meeting policy: Who can present = Only organizers and co-organizers.

## Mejor enfoque y por que
Propiedad DesignatedPresenterRoleMode = "OrganizerOnlyUserOverride".

## Comandos
```powershell
Set-CsTeamsMeetingPolicy -Identity Global -DesignatedPresenterRoleMode "OrganizerOnlyUserOverride"
```