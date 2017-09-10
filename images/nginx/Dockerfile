FROM centos:centos7
MAINTAINER  vitalii.kulbachenko@gmail.com

# -----------------------------------------------------------------------------
# Labels
# -----------------------------------------------------------------------------

LABEL \
	name="vitaliikulbachenko" \
	image="centos7-nginx \
	vendor="centos7" \
	license="MIT" \
	build-date="2017-09-08"


# -----------------------------------------------------------------------------
#  Nginx Install
# -----------------------------------------------------------------------------

RUN \
		yum -y install openssl hostname && \
		yum clean all && \
		rm -fr /var/cache/*


RUN \
	 rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm && \
	 yum -y install nginx 
       

RUN \
	 	mkdir  /tmp/fcgi-cache && \
	 	mkdir -p /etc/nginx && \
	 	mkdir -p /etc/nginx/sites-enabled 
	 	

ADD     nginx.conf /etc/nginx/nginx.conf  
ADD     sites-available /etc/nginx/sites-available 
ADD     templates /etc/nginx/templates 
ADD     www /var/www 

RUN \
	   chown root:nginx /etc/nginx/nginx.conf; chmod 644 /etc/nginx/nginx.conf && \
	   chown -R root:nginx /etc/nginx/sites-available; chmod -R 644 /etc/nginx/sites-available/* && \
       chown -R root:nginx /etc/nginx/sites-enabled && \
       chown -R root:nginx /etc/nginx/templates; chmod -R 644 /etc/nginx/templates/* && \
       chown -R root:nginx /var/www; chmod -R 755 /var/www && \
   	   chown -R nginx:nginx /tmp/fcgi-cache/ && \
	   ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default
	

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
