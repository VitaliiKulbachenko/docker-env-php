server {
        listen       80;
        server_name  test.viit.com.ua www.test.viit.com.ua;
        root   /var/www/virtual/www.test.viit.com.ua;
        index  index.html index.htm index.php;

        
         access_log      /var/log/httpd/pma.viit.com.ua-access.log;
         error_log        /var/log/httpd/pma.viit.com.ua-error.log;

  error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }

        
        location ~ \.php$ {
	#fastcgi_pass   127.0.0.1:9000;           
	fastcgi_pass   unix:/var/run/php-fpm.sock;
	fastcgi_index  index.php;        
	fastcgi_param       SCRIPT_FILENAME  $document_root$fastcgi_script_name;
        include fastcgi_params;
        }


location ~ /\.ht {
            deny  all;
        }

}
