FROM node:18-alpine

WORKDIR /app/medusa

# Instalamos python y herramientas de compilación
RUN apk add --no-cache python3 make g++ git

# Copiamos package.json y package-lock.json (OJO: Aquí cambiamos yarn.lock por package-lock.json)
COPY package.json package-lock.json ./

# Instalamos dependencias usando npm ci (más limpio para producción)
RUN npm ci

COPY . .

# Construimos el proyecto
RUN npm run build

EXPOSE 9000

# Comando de arranque por defecto
CMD ["npm", "run", "start"]