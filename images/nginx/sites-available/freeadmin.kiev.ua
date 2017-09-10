server {
        listen       80;
        server_name  freeadmin.kiev.ua www.freeadmin.kiev.ua;
        root   /var/www/virtual/freeadmin.kiev.ua;
        index  index.html index.htm index.php;

       # Реализуем "красивые" ссылки для Drupal (и для ряда других CMS)
        location / {
        try_files $uri $uri/ /index.php?q=$uri&$args;

        limit_req  zone=freeadmin_kiev_ua burst=10;
	limit_req zone=bots burst=5 nodelay;

        }

        
	#http://www.freeadmin.kiev.ua => http://freeadmin.kiev.ua
        if ($host ~* www\.(.*)) {
        set $host_without_www $1;
        rewrite ^(.*)$ http://$host_without_www$1 permanent;
        }


         access_log      /var/log/httpd/freeadmin.kiev.ua-access.log;
         error_log        /var/log/httpd/freeadmin.kiev.ua-error.log;

     
# Подключаем все шаблоны для проверки, на реальных хостах будем использовать только нужные.
include /etc/nginx/templates/default;
include /etc/nginx/templates/php;
#include /etc/nginx/templates/phpmyadmin;
}
