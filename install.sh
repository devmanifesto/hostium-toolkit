#!/bin/bash

PLUGIN_DIR="/usr/local/cpanel/whostmgr/docroot/cgi/hostium_toolkit"
CONF_FILE="/var/cpanel/apps/hostium_toolkit.conf"

echo "Instalando Hostium Toolkit..."

mkdir -p "$PLUGIN_DIR"
cp index.cgi "$PLUGIN_DIR/"
chmod 755 "$PLUGIN_DIR/index.cgi"

cp hostium_toolkit.conf "$CONF_FILE"
chmod 644 "$CONF_FILE"

/usr/local/cpanel/scripts/update_appconfig

echo "Instalación completa. Verifica en WHM > Plugins > Hostium Toolkit"
