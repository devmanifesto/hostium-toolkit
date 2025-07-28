#!/bin/bash

PLUGIN_NAME="addon_hostium_toolkit"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_DIR="/usr/local/cpanel/whostmgr/docroot/cgi/$PLUGIN_NAME"
ADDONFEATURES_FILE="/usr/local/cpanel/whostmgr/addonfeatures/$PLUGIN_NAME.conf"

echo "🧹 Eliminando instalación previa si existe..."
rm -rf "$PLUGIN_DIR"
rm -f "$ADDONFEATURES_FILE"

echo "📁 Copiando archivos a WHM..."
mkdir -p "$PLUGIN_DIR"
cp "addon_hostium_toolkit/index.cgi" "$PLUGIN_DIR/"
chmod 755 "$PLUGIN_DIR/index.cgi"

cp "$SOURCE_DIR/$PLUGIN_NAME.conf" "$ADDONFEATURES_FILE"
chmod 644 "$ADDONFEATURES_FILE"

echo "🔁 Reiniciando WHM..."
/scripts/restartsrv_cpsrvd

echo "✅ Instalación completa. Revisá en WHM > Plugins > Hostium Toolkit."
