php-nginx-docker-compose/
├── docker-compose.yml
├── nginx/
│   └── default.conf
├── php/
│   └── index.php
└── Dockerfile


mkdir php-nginx-docker-compose
cd php-nginx-docker-compose


## 
version: '3.8'

services:
  nginx:
    image: nginx:latest
    container_name: nginx_container
    ports:
      - "8080:80"
    volumes:
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf
      - ./php:/var/www/html
    depends_on:
      - php

  php:
    build: ./php
    container_name: php_container
    volumes:
      - ./php:/var/www/html



default.conf

server {
    listen 80;
    server_name localhost;

    root /var/www/html;
    index index.php;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass php:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }

    location ~ /\.ht {
        deny all;
    }
}

---php--

index.php

<?php
phpinfo();


#### Dockerfile

# Use the official PHP image as a base image
FROM php:7.4-fpm

# Set working directory
WORKDIR /var/www/html

# Copy the existing application directory contents to the working directory
COPY . /var/www/html

# Install additional PHP extensions if needed
# RUN docker-php-ext-install pdo pdo_mysql

# Expose port 9000 and start PHP-FPM server
EXPOSE 9000
CMD ["php-fpm"]





