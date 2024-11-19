#!/bin/bash

# Desde la ruta /202406/docker
df -h /var/lib/docker/ # Ver tamaño actual
ls -la
vim index.html
#Edito los datos del archivo index.htm con mis datos

#Creo el archivo docker
cat << EOF > dockerfile
FROM nginx:latest
COPY index.html /usr/share/nginx/html/index.html
EOF

#Creo el archivo run

cat << EOF > run.sh
        #! bin/bash
        docker run -d -p 8080:80 Carola10/webCastanheira:latest
EOF

#login
docker login -u Carola10

docker build -t Carola10/webCastanheira:lates .

docker image list
docker push Carola10/webCastanheira:latest


docker run -d -p 8080:80 Carola10/webCastanheira:latest

