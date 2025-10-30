```markdown
# ObrasHG

Repositorio para la app ConstruObras (gestión de obras y visitas).

Contenido:
- Proyecto Xcode (fuentes Swift/SwiftUI) — agrega el proyecto ConstruObras.xcodeproj aquí.
- .github/workflows/build.yml — workflow para compilar y generar .ipa.
- ExportOptions.plist — opciones para exportar el .ipa con xcodebuild.
- Assets (logo) y demás archivos fuente.

Instrucciones rápidas:
1. Crea el repositorio en GitHub con nombre `ObrasHG`.
2. Clona el repositorio localmente.
3. Añade el proyecto Xcode (carpeta del proyecto) y los archivos en este repo.
4. Haz commit y push al repositorio.
5. En GitHub Actions se ejecutará el workflow y generará el archivo .ipa en los artefactos del run.

Nota importante sobre .ipa sin firmar:
- Xcode y iOS esperan binarios firmados para instalar en dispositivos físicos. Un .ipa "sin firmar" (o con signing desactivado) puede crearse/extraerse, pero no se podrá instalar en dispositivos sin firmarlo posteriormente. El workflow que incluyo intenta omitir la firma (usando CODE_SIGNING_ALLOWED=NO y exportOptions con signingStyle manual), pero el comportamiento puede variar según la versión de Xcode en runner y la configuración del proyecto.
- Si necesitas distribuir a dispositivos reales, lo habitual es generar un .ipa firmado con un certificado y provisioning profile válidos. Si lo que quieres es obtener el .ipa para que otra herramienta lo firme, el flujo aquí es útil.

Si quieres que yo cree el repositorio y suba los archivos automáticamente, indícame cómo prefieres autorizarlo (por ejemplo, crear un token con permisos repo:status, repo_deployment, public_repo, repo:invite y subirlo en un entorno donde yo pueda usarlo). Actualmente no puedo ejecutar acciones en tu GitHub sin esa autorización.

```