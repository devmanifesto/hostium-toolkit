# Hostium Toolkit WHM Plugin

Este plugin agrega una entrada dentro de WHM > Plugins con el nombre **Hostium Toolkit**.

### Funcionalidad actual
- Muestra un mensaje "Hello World" al acceder desde WHM.

### Instalación

```bash
git clone https://github.com/devmanifesto/hostium-toolkit.git
cd hostium-toolkit
chmod +x install.sh
sudo ./install.sh
```

### Archivos incluidos

- `index.cgi`: Script CGI principal con salida "Hello World"
- `hostium_toolkit.conf`: Configuración para registrar el plugin en WHM
- `install.sh`: Script de instalación automática

### Autor
Desarrollado por el equipo de [Hostium](https://www.hostium.com.ar/)
