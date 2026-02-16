# Usa una imagen ligera de Node 18
FROM node:18-alpine

# Instala dependencias de sistema necesarias para 'sharp' y Python (para node-gyp)
# Esto evita que se compile desde cero y tarde horas
RUN apk add --no-cache python3 make g++ git

WORKDIR /app/medusa

# Copia los archivos de definición de paquetes
COPY package.json yarn.lock ./

# Instala las dependencias
RUN yarn install --frozen-lockfile

# Copia el resto del código
COPY . .

# Construye el backend de Medusa
RUN yarn build

# Expone el puerto por defecto
EXPOSE 9000

# El comando de arranque (Railway usará este si no especificas otro,
# pero tu Custom Start Command tendrá prioridad si lo dejas puesto)
CMD ["medusa", "start"]