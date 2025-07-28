#!/bin/bash

echo "🔍 Verificando plugin WHM: Hostium Toolkit"
echo

PLUGIN_NAME="hostium_toolkit"
PLUGIN_DIR="/usr/local/cpanel/whostmgr/docroot/cgi/${PLUGIN_NAME}"
CONF_FILE="/var/cpanel/apps/${PLUGIN_NAME}.conf"

echo "📁 Verificando existencia del archivo de configuración..."
if [ -f "$CONF_FILE" ]; then
    echo "✅ Archivo de configuración encontrado en $CONF_FILE"
else
    echo "❌ Archivo de configuración no encontrado en $CONF_FILE"
    exit 1
fi

echo
echo "📄 Contenido de $CONF_FILE:"
cat "$CONF_FILE"
echo

echo "🔐 Verificando permisos de $CONF_FILE..."
ls -l "$CONF_FILE"

echo
echo "📁 Verificando existencia del directorio del plugin..."
if [ -d "$PLUGIN_DIR" ]; then
    echo "✅ Carpeta del plugin encontrada: $PLUGIN_DIR"
else
    echo "❌ Carpeta del plugin no existe: $PLUGIN_DIR"
    exit 1
fi

echo
echo "📄 Verificando script index.cgi..."
if [ -f "$PLUGIN_DIR/index.cgi" ]; then
    echo "✅ index.cgi encontrado"
    ls -l "$PLUGIN_DIR/index.cgi"
else
    echo "❌ index.cgi no encontrado"
    exit 1
fi

echo
echo "🔄 Verificando si el plugin está registrado con show_appconfig..."
/usr/local/cpanel/bin/show_appconfig | grep -A15 "$PLUGIN_NAME"

echo
echo "🌐 Probá acceder directamente desde el navegador:"
hostname=$(hostname)
echo "   https://$hostname:2087/cgi/${PLUGIN_NAME}/index.cgi"
echo

echo "🔁 Reiniciando cpsrvd para aplicar cambios..."
/scripts/restartsrv_cpsrvd

echo
echo "✅ Revisión finalizada. Verificá si el plugin aparece en WHM > Plugins."
