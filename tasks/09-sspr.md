# Tarea 09 - Self-service password reset para todos los usuarios

## Objetivo
SSPR habilitado para All (no solo selected users/group).

## Mejor enfoque y por que
Graph NO expone el toggle None/Selected/All. Debe configurarse en Entra portal: Password reset > Properties > Self service password reset enabled = All.

## Accion manual
Entra ID portal -> Password reset -> Properties -> Self service password reset enabled = All.

## Nota assessment
Correr assessment con -SsprAllScopeConfirmed (default true) para que no marque UNKNOWN.