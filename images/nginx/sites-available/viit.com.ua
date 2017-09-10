server {
        listen       80;
        server_name  viit.com.ua www.viit.com.ua;
        root   /var/www/viit.com.ua;
        index  index.html index.htm index.php;

        
	#редиректим http://www.viit.com.ua => http://viit.com.ua
        if ($host ~* www\.(.*)) {
        set $host_without_www $1;
        rewrite ^(.*)$ http://$host_without_www$1 permanent;
        }


         access_log      /var/log/httpd/viit.com.ua-access.log;
         error_log        /var/log/httpd/viit.com.ua-error.log;

     
error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   /usr/local/www/nginx-dist;
        }
        

  if (!-e $request_filename) {
      rewrite  ^(.*)$  /bitrix/urlrewrite.php last;
   }


        location ~ \.php$ {
            fastcgi_pass   unix:/var/run/php-fpm.sock;
            fastcgi_param  SCRIPT_FILENAME  /var/www/viit.com.ua$fastcgi_script_name;
            include        /usr/local/etc/nginx/fastcgi_params;
	} 
 if (!-f $request_filename) {
         rewrite  ^(.*)/index.php$  $1/ redirect;

        }

           
        
 # Явно указываем путь к robots.txt, если не указать то файл будет не найден
         location = /robots.txt {
          allow all;
          root /var/www/viit.com.ua;
  }


  # По скольку apache у нас нету, то закрываем папки, файлы, типы файлов для доступа nginx'ом
 location ~* \.(override|tools|translations|webservice|modules|char|classes|install|config|controllers|docs|export|localization|log|.*sql|.*bz2|.*csv|.*tpl(\.php)?|xtmpl)$|^(\..*|Entries.*)$|\.php_ {
 
                deny all;
                }


        # с этой странички мы будем брать статистику по нгинксу для мртг
        location /nginx_status {
            stub_status on;
            access_log   off;
            allow 192.168.20.2;
            deny all;
        }


location ~ /\.ht {
            deny  all;
        }

}
