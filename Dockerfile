FROM node:18-alpine

WORKDIR /app/medusa

# Instalamos python y herramientas de compilación
RUN apk add --no-cache python3 make g++ git

# Copiamos package.json y package-lock.json
COPY package.json package-lock.json ./

# Instalamos dependencias usando npm ci
RUN npm ci

# Copiamos el resto del código fuente
COPY . .

# AUMENTAMOS EL LÍMITE DE MEMORIA DE NODE.JS PARA EL BUILD DE MEDUSA
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Construimos el proyecto
RUN npm run build

EXPOSE 9000

# Comando de arranque por defecto
CMD ["npm", "run", "start"]