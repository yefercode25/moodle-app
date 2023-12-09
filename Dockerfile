# Usa una imagen base de PHP con Apache
FROM php:7.4-apache

# Copia el código fuente de Moodle al directorio de trabajo en el contenedor
COPY . /var/www/html/

# Configuración adicional de Apache
RUN a2enmod rewrite \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Expone el puerto 80
EXPOSE 80

# Comando para iniciar Apache
CMD ["apache2-foreground"]
