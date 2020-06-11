FROM debian
ADD docker.list /etc/apt/sources.list.d/
RUN apt-get update && apt-get -y upgrade && apt -y install nginx && apt-get clean && \
    cd /var/www/ && rm -rf ./* && \
    mkdir -p nastyatzarOS.com/img && \
    chmod -R 754 /var/www/nastyatzarOS.com/ && \
    useradd Nastya && groupadd Tsarkova && usermod -aG Tsarkova Nastya && \
    chown -R Nastya:Tsarkova /var/www/nastyatzarOS.com/ && \
    sed -i 's/\/var\/www\/html/\/var\/www\/nastyatzarOS.com/g' /etc/nginx/sites-enabled/default && \
    sed -i 's/user www-data/user Nastya/g' /etc/nginx/nginx.conf
ADD index.html /var/www/nastyatzarOS.com/
ADD img.jpg /var/www/nastyatzarOS.com/img/
CMD ["nginx", "-g", "daemon off;"]
