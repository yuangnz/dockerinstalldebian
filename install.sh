#!/bin/bash

# Este script debe ejecutarse como root (administrador)

echo "🚀 Iniciando la instalación automática de Docker..."

# 1. Actualizar la lista de paquetes
echo "⚙️ Actualizando el índice de paquetes..."
apt update

# 2. Instalar certificados y curl
echo "📦 Instalando dependencias: ca-certificates y curl..."
apt install -y ca-certificates curl

# 3. Crear el directorio de claves GPG
echo "🔑 Creando el directorio /etc/apt/keyrings..."
install -m 0755 -d /etc/apt/keyrings

# 4. Descargar la clave GPG oficial de Docker
echo "⬇️ Descargando la clave GPG de Docker..."
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc

# 5. Configurar permisos de lectura para la clave
echo "🔒 Configurando permisos para la clave GPG..."
chmod a+r /etc/apt/keyrings/docker.asc

# 6. Añadir el repositorio de Docker a las fuentes de Apt
echo "📝 Añadiendo el repositorio de Docker a las fuentes de Apt..."

# Determinar el nombre en clave de la distribución (por ejemplo, "bookworm", "jammy")
export CODENAME=$(. /etc/os-release && echo "$VERSION_CODENAME")

# Crear el archivo de configuración del repositorio
tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $CODENAME
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

# 7. Actualizar la lista de paquetes con el nuevo repositorio
echo "🔄 Actualizando el índice de paquetes con el nuevo repositorio de Docker..."
apt update

# 8. Instalar Docker CE, cliente, containerd y plugins
echo "🛠️ Instalando Docker CE, containerd, y plugins..."
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "✅ Instalación de Docker completada."
echo "ℹ️ Puedes verificar la instalación ejecutando: docker run hello-world"
