FROM ubuntu
EXPOSE 80
RUN apt-get update && apt install -y nginx 
WORKDIR /devops
