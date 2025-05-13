# 📂 Backend - Hybrix

Este README te guiará paso a paso para configurar y ejecutar el backend de la aplicación Hybrix. 🛠️

---

## 🛠️ **Requisitos Previos**

Asegúrate de tener instaladas las siguientes herramientas:

- **Node.js:** v23.7.0
- **npm:** v11.1.0
- **nvm (Node Version Manager):** Para cambiar de versión si es necesario

### 📌 **Instalación de NVM**

Si no tienes `nvm`, instálalo siguiendo estos pasos:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
```

Luego, reinicia tu terminal y verifica la instalación:

```bash
nvm --version
```

Para instalar la versión correcta de Node.js y npm:

```bash
nvm install 23.7.0
nvm use 23.7.0
```

Verifica que las versiones sean las correctas:

```bash
node -v
npm -v
```

---

## 📂 **Instalación del Proyecto**

1. Clona el repositorio:

```bash
git clone <URL_DEL_REPO>
```

2. Navega a la carpeta del backend:

```bash
cd app_backend
```

3. Instala las dependencias:

```bash
npm install
```

4. Instala nodemon para desarrollo (opcional):

```bash
npm install --save-dev nodemon
```

---

## 🚀 **Ejecución del Servidor**

Para correr el servidor en producción:

```bash
npm run start
```

Para correrlo en modo desarrollo con recarga automática:

```bash
npm run dev
```

El servidor estará escuchando en:

```
http://localhost:3000
```

---

## ✅ **Verificación del Proyecto**

Abre un navegador o usa `curl` para probar que todo esté funcionando:

```bash
curl http://localhost:3000
```
