#!/bin/sh

/usr/bin/mysqladmin -uroot -p password Jdwa*2003

/usr/bin/mysql -uroot -pJdwa*2003 << EOF

use mysql;
DROP DATABASE IF EXISTS audit;
DROP DATABASE IF EXISTS multilevel_inter;
DROP DATABASE IF EXISTS fydbconf;
DROP DATABASE IF EXISTS fydbaudit;
CREATE DATABASE audit DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE multilevel_inter DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE DATABASE fydbconf DEFAULT CHARACTER SET gbk COLLATE gbk_chinese_ci;
CREATE DATABASE fydbaudit DEFAULT CHARACTER SET gbk COLLATE gbk_chinese_ci;
create user fydbconf identified by 'jdwafydbconf';
grant select,insert,update,delete on *.* to 'fydbconf'@'localhost' identified by 'jdwafydbconf';
create user fydbaudit identified by 'jdwafydbaudit';
grant select,insert,update,delete on *.* to 'fydbaudit'@'localhost' identified by 'jdwafydbaudit';
delete from user where Host='%' and User='fydbconf';
delete from user where Host='%' and User='fydbaudit';
flush privileges;

EOF

