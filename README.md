# P4 – Implantación de servicios telemáticos en Internet (TDRC)

## 📌 Descripción
Práctica realizada en la asignatura **Transmisión de Datos y Redes de Computadores (TDRC)**, enfocada en la implantación de servicios accesibles desde Internet utilizando **DNS dinámico (DDNS)** y **servidores XMPP** para comunicación instantánea.

Se ha desplegado **ejabberd** en contenedores Docker y configurado la comunicación entre **dos dominios públicos** registrados con DDNS, validando la mensajería instantánea con clientes XMPP (Pidgin).

---

## 🎯 Objetivos
- Configurar un servicio XMPP accesible desde Internet mediante DDNS.
- Abrir y redirigir puertos en el router para permitir el acceso externo (**port forwarding**).
- Desplegar **ejabberd** en Docker y configurar dominio, usuarios y ACL.
- Conectar clientes XMPP en dominios distintos y validar la comunicación.
- Analizar la conectividad con herramientas como `ping`, `nslookup`, `traceroute` y **Wireshark**.

---

## ⚙️ Requisitos y configuración previa

### Puertos abiertos
Es necesario abrir y redirigir los siguientes puertos en el router hacia la IP local del servidor:

- **5222 (TCP):** Cliente a servidor (c2s).
- **5269 (TCP):** Servidor a servidor (s2s).
- **5280 (TCP):** Panel web de administración de ejabberd.

### Configuración
1.  **Reservar IP local del servidor** en el router (configurar DHCP estático).

2.  **Crear dominios DDNS** en un proveedor como `noip.com`:
    - `todormartin.ddns.net`
    - `cortesmiras.ddns.net`

3.  **Permitir puertos en el firewall** del servidor (si se usa `ufw`):
    ```bash
    sudo ufw allow 5222/tcp comment 'XMPP client'
    sudo ufw allow 5269/tcp comment 'XMPP server'
    sudo ufw allow 5280/tcp comment 'ejabberd web admin'
    ```

4.  **Crear usuarios en ejabberd:**
    El script `crear_usuarios.sh` automatiza el registro de nuevos usuarios en el servidor XMPP.
    ```bash
    ./crear_usuarios.sh
    ```

---

## 💬 Configuración de cliente XMPP (Pidgin)

1.  **Instalar Pidgin:**
    ```bash
    sudo apt install pidgin
    ```

2.  **Añadir cuenta de usuario:**
    - **Protocolo:** XMPP
    - **Usuario:** `cliente1`
    - **Dominio:** `todormartin.ddns.net`
    - **Recurso:** Dejar vacío o usar el valor por defecto.
    - **Contraseña:** La contraseña configurada para `cliente1`.

3.  **Añadir un amigo:**
    - En la ventana "Lista de amigos", ir a `Amigos > Añadir amigo...`.
    - Introducir el JID (Jabber ID) del usuario remoto (ej: `cliente2@cortesmiras.ddns.net`).
    - El usuario remoto recibirá una solicitud de amistad que deberá aceptar para que la comunicación pueda establecerse.

---

## 🧪 Pruebas realizadas
- **Comunicación exitosa** entre `cliente1@todormartin.ddns.net` y `cliente2@cortesmiras.ddns.net`.
- **Validación de resolución de dominios** con `nslookup` para confirmar que los DDNS apuntan a las IPs públicas correctas.
- **Análisis de conectividad** y rutas de red mediante `ping` y `traceroute`.
- **Captura y análisis de tráfico XMPP** con **Wireshark** para inspeccionar los intercambios de mensajes (stanzas).
- **Comprobación de puertos abiertos** desde una red externa utilizando herramientas online como `ping.eu`.

---

## 📈 Conclusiones
- Se ha aprendido a abrir y redirigir puertos en un router doméstico para exponer servicios locales a Internet de forma segura.
- Se ha puesto en práctica el uso de DDNS como solución para servidores con IP dinámica, el *port forwarding* y el diagnóstico de conectividad.
- Se ha desplegado y configurado un servicio XMPP funcional con **ejabberd** sobre Docker, una habilidad clave para la administración de sistemas.
- Se ha validado la comunicación segura y federada entre dos dominios distintos utilizando el cliente **Pidgin**.
- El procedimiento aprendido es directamente aplicable a proyectos reales que requieran autoalojamiento, como servidores multimedia (Plex, Jellyfin), aplicaciones web o sistemas de diagnóstico de red.
