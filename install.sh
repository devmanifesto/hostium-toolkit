#!/bin/bash

# Ruta de instalación en WHM
PLUGIN_NAME="hostium_toolkit"
PLUGIN_DIR="/usr/local/cpanel/whostmgr/docroot/cgi/${PLUGIN_NAME}"
CONF_FILE="/var/cpanel/apps/${PLUGIN_NAME}.conf"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Instalando Hostium Toolkit desde ${SOURCE_DIR}..."

# Crear carpeta del plugin si no existe
mkdir -p "$PLUGIN_DIR"

# Copiar el CGI
cp "${SOURCE_DIR}/index.cgi" "$PLUGIN_DIR/"
chmod 755 "$PLUGIN_DIR/index.cgi"

# Copiar el archivo de configuración
cp "${SOURCE_DIR}/hostium_toolkit.conf" "$CONF_FILE"
chmod 644 "$CONF_FILE"

# Registrar el plugin en WHM
/usr/local/cpanel/scripts/update_appconfig

# Reiniciar WHM para asegurarse que tome el nuevo plugin
/scripts/restartsrv_cpsrvd

echo "Instalación completada. Verificá en WHM > Plugins > Hostium Toolkit."
