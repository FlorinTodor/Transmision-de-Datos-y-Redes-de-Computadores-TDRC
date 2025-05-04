#!/bin/bash

# Nombre del contenedor
CONTAINER="ejabberd"

# Dominio de tu servidor
DOMINIO="todormartin.ddns.net"

# Usuarios a crear: usuario contraseña
declare -A USUARIOS=(
  [admin]="adminpassword"
  [profesor]="tstc_1234!"
  [cliente1]="cliente123"
  [cliente2]="cliente123"
)

echo "📦 Creando usuarios en $DOMINIO..."

for usuario in "${!USUARIOS[@]}"; do
  echo "➤ Creando usuario: $usuario@$DOMINIO"
  docker exec -it "$CONTAINER" bin/ejabberdctl register "$usuario" "$DOMINIO" "${USUARIOS[$usuario]}" 2>/dev/null \
    && echo "✔ Usuario $usuario creado" \
    || echo "⚠️  Usuario $usuario ya existe o falló"
done

echo
echo "📄 Lista actual de usuarios en $DOMINIO:"
docker exec -it "$CONTAINER" bin/ejabberdctl registered_users "$DOMINIO"
