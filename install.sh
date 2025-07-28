#!/bin/bash

# Ruta de instalación en WHM
PLUGIN_NAME="hostium_toolkit"
PLUGIN_DIR="/usr/local/cpanel/whostmgr/docroot/cgi/${PLUGIN_NAME}"
CONF_FILE="/var/cpanel/apps/${PLUGIN_NAME}.conf"
SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Instalando Hostium Toolkit desde ${SOURCE_DIR}..."

# 🧹 Limpiar carpeta de instalación temporal si existe
if [[ "$SOURCE_DIR" =~ /root ]]; then
    echo "🧹 Eliminando instalación previa del plugin..."
    rm -rf "$PLUGIN_DIR"
fi


# Eliminar carpeta existente si ya está
if [ -d "$PLUGIN_DIR" ]; then
    echo "Eliminando carpeta anterior en $PLUGIN_DIR..."
    rm -rf "$PLUGIN_DIR"
fi

# Crear carpeta del plugin
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

# Copiar entrada al menú de WHM (addonfeatures)
ADDONFEATURES_DIR="/usr/local/cpanel/whostmgr/addonfeatures"
ADDONFEATURES_FILE="${ADDONFEATURES_DIR}/${PLUGIN_NAME}.conf"

echo "Agregando entrada al menú WHM en ${ADDONFEATURES_FILE}..."
mkdir -p "$ADDONFEATURES_DIR"
cp "${SOURCE_DIR}/${PLUGIN_NAME}.addonfeatures.conf" "$ADDONFEATURES_FILE"
chmod 644 "$ADDONFEATURES_FILE"
# 🧼 Eliminando carpeta de origen si es un directorio temporal bajo /root
if [[ "$SOURCE_DIR" =~ /root ]]; then
    echo "🧼 Eliminando carpeta de instalación temporal: $SOURCE_DIR"
    cd /root && rm -rf "$SOURCE_DIR"
fi
