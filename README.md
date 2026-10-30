# defend-the-tenant-challenge

Mi trabajo en el reto *Defend the Tenant* de Microsoft: endurecer un tenant de
Microsoft 365 aplicando los 10 controles que pedía el laboratorio y dejar la
evidencia de todo el proceso.

## Resultado

Ejecuté el script de evaluación oficial del laboratorio contra mi tenant y el
resultado fue 10/10:

    10 implemented, 0 not configured, 0 unknown

La salida completa está en `assessment-output.txt` y el resumen que entrego en
`hardening-results.txt`.

## Cómo trabajé

Monté el entorno en WSL (Kali Linux) con PowerShell 7.6.9 y los módulos de
Microsoft Graph y Microsoft Teams, para no mezclar las credenciales del
laboratorio con mi perfil de Windows. Me autentiqué primero con usuario y
contraseña (ROPC) y, cuando las políticas de MFA entraron en vigor, pasé a
device code y browser PKCE. Un detalle que me encontré y quedó registrado en los
peritajes: en cuanto activé el MFA, la autenticación por contraseña dejó de
funcionar, que es justo lo que se esperaba del hardening.

## Qué apliqué

- MFA para administradores y para todos los usuarios: política de acceso
  condicional "MFA - All Users".
- Bloqueo de autenticación legacy: "Block Legacy Auth" (Exchange ActiveSync +
  Other).
- MFA por riesgo de inicio de sesión (medium/high) con reautenticación cada vez
  (primaryAndSecondaryAuthentication).
- Remediación de riesgo de usuario alto: MFA + cambio de contraseña.
- Autoconsentimiento de aplicaciones deshabilitado.
- Reuniones de Teams (política Global): lobby solo para invitados, presentadores
  solo organizadores, unión anónima desactivada.
- SSPR habilitado para todos (esto solo se puede cambiar en el portal de Entra).

## Contenido del repo

- `logs/` — peritajes de cada paso, con hallazgos y errores reales, incluido un
  primer assessment que dio 9/10 y la causa raíz del fallo.
- `tasks/` — por cada control, los comandos y el razonamiento de por qué elegí
  ese enfoque.
- `scripts/` — los scripts que usé para instalar el entorno, autenticarme y
  aplicar los controles.
- `hardening-results.txt` y `assessment-output.txt` — resumen y evidencia cruda.

## Reproducirlo

Sigue `tasks/` en orden; el montaje del entorno está en `scripts/install_*`.
Hace falta un tenant de laboratorio, PowerShell 7 y los módulos Microsoft.Graph y
MicrosoftTeams. Sin prisa con los códigos de dispositivo: caducan a los 2
minutos, y el SSPR se cambia en el portal, no por Graph.
