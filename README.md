```markdown
# ObrasHG — ConstruObras iOS App

Este repositorio contiene el código fuente de la app ConstruObras (gestión de obras, visitas y anotaciones).
Sigue las instrucciones para montar el proyecto Xcode localmente, marcar el scheme como "Shared" y generar un ZIP o subir al repositorio.

Pasos rápidos para obtener el .ipa vía GitHub Actions:
1. Clona este repo localmente:
   git clone git@github.com:trancos54/ObrasHG.git
   cd ObrasHG

2. Crear el proyecto Xcode:
   - Abre Xcode → File → New → Project → iOS App (App).
   - Product Name: ConstruObras
   - Interface: SwiftUI, Language: Swift
   - Guarda el proyecto en la raíz del repo (debe crear ConstruObras.xcodeproj en la raíz).
   - Añade todos los archivos de la carpeta `Sources` al target (File → Add Files...).
   - Añade Assets.xcassets si procede y sustituye el asset "Logo" por tu imagen.

3. Marcar el scheme como "Shared":
   - Product → Scheme → Manage Schemes... → marca la casilla "Shared" para el scheme ConstruObras.
   - Esto crea la carpeta `xcshareddata/xcschemes` dentro del .xcodeproj para CI.

4. Agrega, commitea y sube:
   git add .
   git commit -m "Add Xcode project and sources"
   git push origin main

5. En GitHub ve a Actions y re-run del workflow "Build iOS .ipa (unsigned attempt)".
   - El workflow generará un .xcarchive y (si es posible) un .ipa y los subirá como artefactos.

Notas:
- El flujo intenta generar un .ipa sin firmar usando CODE_SIGNING_ALLOWED=NO, pero Xcode puede requerir firma para exportar un .ipa instalable. Para distribución a dispositivos reales necesitas firmar con certificado y provisioning válidos.
- Si prefieres que te entregue un ZIP listo que incluya un .xcodeproj ya configurado (no puedo enviar binarios desde esta sesión), sigue los pasos anteriores y usa zip_project.sh para producir el ZIP localmente.
