#--------------------------------------------------------------------------------------------------
# Automating Wordpress site creation process
# By Godwin ELITCHA godwin.elitcha@gmail.com
#--------------------------------------------------------------------------------------------------


#Variables
_END=\x1b[0m
_BOLD=\x1b[1m
_UNDER=\x1b[4m
_REV=\x1b[7m

# Colors
_RED=\x1b[31m
_GREEN=\x1b[32m
_BLUE=\x1b[34m

## WP Variables
PROJECT_NAME?=$(shell basename $(CURDIR))

MYSQL_HOST?=localhost
MYSQL_USER?=root
MYSQL_PWD?=
DB_NAME?=${PROJECT_NAME}
DB_PREFIX?=wp_

ADMIN_NAME?=admin
ADMIN_EMAIL?=admin@mail.com
ADMIN_PASSWORD?=12345678

#Functions for displaying message

define show_message
	@echo -e "\n${_BOLD}${_GREEN}---- $1 ----${_END}"
endef

.PHONY: help update install clean
.SILENT: help update install clean

help: ## Display help
	@echo $(shell )
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

update: ## update WP core and plugins all
	$(call show_message, "UPDATE WP CORE")
	wp core update
	$(call show_message, "UPDATE PLUGINS")
	wp plugin update --all

install: ## Install Wp
	$(call show_message, "DOWNLOAD WP")
	wp core download --locale=fr_FR --force

	$(call show_message, "WP VERSION INSTALLED")
	wp core version

	$(call show_message, "CONFIG DATABASE")
	wp core config \
		--dbhost=$(MYSQL_HOST) \
		--dbname=$(DB_NAME) \
		--dbuser=$(MYSQL_USER) \
		--dbpass=$(MYSQL_PWD) \
		--dbprefix=$(DB_PREFIX) \
		--locale=fr_FR \
		--skip-check

	$(call show_message, "CREATE DB")
	wp db create

	$(call show_message, "INSTALL WP")
	wp core install \
		--url=$(PROJECT_NAME).test \
		--title=$(PROJECT_NAME) \
		--admin_user=$(ADMIN_NAME) \
		--admin_password=$(ADMIN_PASSWORD) \
		--admin_email=$(ADMIN_EMAIL) \
		--skip-plugins \
		--skip-themes \
		--skip-email \

	$(call show_message, "INSTALL DEFAULT THEME")
	#wp theme install astra --activate
	wp theme install twentytwenty --activate

	$(call show_message, "CREATE DEFAULT MENU")
	wp menu create "Main Menu"
	
	$(call show_message, "SET PERMALINKS STRUCTURE TO /%postname")
	wp option get permalink_structure
	wp option update permalink_structure '/%postname%'
	wp rewrite flush --hard

	$(call show_message, "OPEN WP-ADMIN")
	wp admin

clean: ##Delete Database and files
	$(call show_message, "DELETE DATABASE")
	wp db drop --yes

	$(call show_message, "DELETE FILES")
	rm -Rf wp-* index.php readme.html xmlrpc.php license.txt