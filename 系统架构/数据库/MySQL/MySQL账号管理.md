







```sh




CREATE USER 'lwx'@'%' IDENTIFIED WITH mysql_native_password BY 'lwx666666';

grant create,alter,drop,select,insert,update,delete on *.* to lwx@'%'
flush privileges; 





create database analysis default character set utf8mb4 collate utf8mb4_unicode_ci;
CREATE USER 'analysis'@'%' IDENTIFIED WITH mysql_native_password BY 'kmBtXYeMbb8eHyLKxkmE';
grant create,alter,drop,select,insert,update,delete on analysis.* to analysis@'%'
flush privileges; 

grant create,alter,drop,select,insert,update,delete on aws.* to chf@'%'
flush privileges; 

CREATE DATABASE cl_cloud CHARACTER SET utf8 COLLATE utf8_general_ci;
```

