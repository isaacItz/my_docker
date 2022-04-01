# Imagen y Etiquetas
FROM ubuntu:20.04
LABEL maintainer="Isaac <isaac@gmail.com>"
LABEL description="este es mi docker file"

# Definir variables de entorno
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Europe/Dublin
ENV TZ=America/Mexico_City

# Instalar Dependencias y el servidor Web
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt install apache2 -y

# Mensaje de bienvenida
RUN echo 'I am a huge geek that only copy text' > /var/www/html/index.html

# Configurar apache
RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh && \
 echo 'mkdir -p /var/run/apache2' >> /root/run_apache.sh && \
 echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh && \ 
 echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh && \ 
 chmod 755 /root/run_apache.sh


EXPOSE 80/tcp

CMD /root/run_apache.sh
