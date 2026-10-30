# Defend the Tenant - laboratorio M365 (índice)

Tenant: 0ce1ea09-e064-4265-83e2-341018b19d7d (WWLCPx52164899.onmicrosoft.com)
Admin: admin@WWLCPx52164899.onmicrosoft.com
Fecha: 2026-10-30

## Resultado

Los 10 controles del laboratorio aplicados y verificados con el script oficial:
10 implemented, 0 not configured, 0 unknown. SSPR = All lo configuré en el portal
(Graph no expone ese ajuste) y lo confirmé con captura.

## Estructura

- logs/ : peritajes en .txt de cada paso, incluido un primer assessment que dio
  9/10 y la causa raíz de su fallo.
- tasks/ : un .md por control con comandos y razonamiento.
- scripts/ : los scripts que usé para montar el entorno, autenticarme y aplicar
  los controles.
- hardening-results.txt : resumen entregable de la fase 2.
- assessment-output.txt : salida cruda del script de evaluación.

## Autenticación usada

- Al principio: ROPC (usuario/contraseña) para Graph y credenciales para Teams.
- Tras activar el MFA: device code y browser PKCE. ROPC deja de funcionar en
  cuanto el MFA entra en vigor (AADSTS50076), y así quedó registrado.

## Notas

- Las políticas quedaron en enforced, sin exclusiones (el lab no dio break-glass).
- La instalación completa del entorno está en scripts/ y los pasos en tasks/.
