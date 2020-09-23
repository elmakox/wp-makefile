# wp-makefile
Makefile for init a wordpress project

### Description

This makefile automates the process of creating a wordpress project. It uses wp-cli to download wp core, setup database, config and install.

#### Install with default options :
  ```bash
    git clone https://github.com/elmakox/wp-makefile.git <your-project-folder-name>
    cd <your-project-folder-name>
    make install
  ```
Will setup a fresh wordpress with following default options:

* Host : Localhost
* DB User : root
* DB Password : 
* Table preffix: wp_
* Admin name : godwin
* Admin email : godwin.elitcha@gmail.com
* Admin password : {Get it in terminal}

#### Install with custom options :

Just set new value for variable

```bash
  git clone https://github.com/elmakox/wp-makefile.git <your-project-folder-name>
  cd <your-project-folder-name>
  make install ADMIN_NAME=godwin ADMIN_EMAIL=godwin.elitcha@gmail.com
```

#### Update the project

```bash
  make update
```

#### Clean project

This command will drop the database and delete all wordpress files

```bash
  make clean
```

