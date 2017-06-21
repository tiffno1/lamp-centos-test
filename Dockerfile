FROM centos:6.9

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

RUN yum install -y httpd vim-enhanced bash-completion unzip wget

RUN service httpd start 

RUN wget -O /etc/yum.repos.d/MariaDB.repo http://mariadb.if-not-true-then-false.com/centos/$(rpm -E %centos)/$(uname -i)/5

RUN yum install MariaDB MariaDB-server -y

RUN service mysql start


RUN yum install php56w php56w-gd php56w-json php56w-pdo php56w-common php56w-fpm php56w-mysql php56w-mbstring php56w-mcrypt php56w-xml -y

RUN echo -e '<?php \nphpinfo(); \n?>' > /var/www/html/test.php

RUN service httpd restart

RUN yum install phpmyadmin -y

EXPOSE 80 3306 

CMD /etc/init.d/httpd restart && \
    /etc/init.d/mysql restart && \
	/bin/bash
