#!/usr/bin/env bash
# zip_project.sh
# Usage: run this in the root of your local repo AFTER you have created ConstruObras.xcodeproj with Xcode.
# It will create a zip named ConstruObras.zip containing the project ready to push / upload.

set -e
PROJECT_NAME="ConstruObras"
ZIP_NAME="${PROJECT_NAME}.zip"

if [ ! -d "${PROJECT_NAME}.xcodeproj" ]; then
  echo "Error: ${PROJECT_NAME}.xcodeproj not found in current directory. Create the Xcode project first."
  exit 1
fi

# Files and directories to include in the zip (adjust if you put files elsewhere)
INCLUDE=(
  "${PROJECT_NAME}.xcodeproj"
  "xcshareddata"            # sometimes created inside .xcodeproj; include if present
  "Sources"
  "Assets"
  "Info.plist"
  "ExportOptions.plist"
  ".github"
  "README.md"
)

# Build list of existing items
TO_ZIP=()
for item in "${INCLUDE[@]}"; do
  if [ -e "$item" ]; then
    TO_ZIP+=("$item")
  fi
done

if [ ${#TO_ZIP[@]} -eq 0 ]; then
  echo "Nothing to zip. Check that you are in the repo root and files exist."
  exit 1
fi

echo "Creating ${ZIP_NAME} with:"
for f in "${TO_ZIP[@]}"; do echo " - $f"; done

# Create zip
rm -f "${ZIP_NAME}"
zip -r "${ZIP_NAME}" "${TO_ZIP[@]}"

echo "Created ${ZIP_NAME}."