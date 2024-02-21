composer-install:
	cd webroot && docker-compose -f docker-compose-makefile.yml run main composer install