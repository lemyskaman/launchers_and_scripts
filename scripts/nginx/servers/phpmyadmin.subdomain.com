server {
        root /home/phpmyadmin/public_html;
        index index.php index.html index.htm index.nginx-debian.html;
        server_name  phpmyadmin.kamansoft.com  www.phpmyadmin.kamansoft.com;

 #       location /blog {
 #           index index.php;
 #           try_files $uri $uri/ /blog/index.php?$args;
 #       }



#        if ($request_uri ~ ^/([^/]+)\.php$) {
#             return 301 /$1;
 #        }

        location /index {
                return 301 /$1;
        }

        location / {
                try_files $uri $uri.html $uri/ @extensionless-php;
                #try_files $uri $uri/ =404;
        }


        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/var/run/php/phpmyadmin-fpm.sock;
        }

        location @extensionless-php {
                rewrite ^(.*)$ $1.php last;
        }

        location ~ /\.ht {
                deny all;
        }

        location ~* \.(?:ico|css|js|gif|jpe?g|png)$ {
            expires 30d;
            add_header Pragma public;
            add_header Cache-Control "public";
        }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/phpmyadmin.kamansoft.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/phpmyadmin.kamansoft.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}



server {
    if ($host = phpmyadmin.kamansoft.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


        listen 80;
        server_name  phpmyadmin.kamansoft.com  www.phpmyadmin.kamansoft.com;
    return 404; # managed by Certbot


}
