# Usa una imagen base de PHP
FROM php:7.4

# Copia el código fuente de Moodle al directorio de trabajo en el contenedor
COPY . /var/www/html/

# Establece el directorio de trabajo
WORKDIR /var/www/html/

# Instala las dependencias necesarias (puedes ajustar según sea necesario)
RUN apt-get update && apt-get install -y \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Exponer el puerto 80 del contenedor
EXPOSE 80

# Comando para ejecutar el servidor web incorporado de PHP en el puerto 3000
CMD ["php", "-S", "0.0.0.0:3000"]