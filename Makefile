.PHONY: all up build rebuild stop restart status rails_c help

all: up

build: stop
	@echo "*** Building containers... ***"
	docker-compose build

rebuild: stop
	@echo "*** Rebuilding containers... ***"
	docker-compose build --no-cache

up:
	@echo "*** Spinning up containers... ***"
	docker-compose up
	@$(MAKE) --no-print-directory status

stop:
	@echo "*** Halting containers... ***"
	docker-compose stop
	@$(MAKE) --no-print-directory status

restart:
	@echo "*** Restarting containers... ***"
	@$(MAKE) --no-print-directory stop
	@$(MAKE) --no-print-directory up

status:
	@echo "*** Containers statuses ***"
	@docker-compose ps

migrate: stop
	@echo "*** run db migrations ***"
	docker-compose run app rake db:migrate

rails_c:
	@echo "*** run rails console ***"
	docker-compose run app rails console

help:
	@echo "init\t\t\t- init project"
	@echo "clone\t\t\t- clone repositories"
	@echo "build\t\t\t- build containers"
	@echo "rebuild\t\t\t- build containers w/o cache"
	@echo "up\t\t\t- start project"
	@echo "stop\t\t\t- stop project"
	@echo "restart\t\t\t- restart project"
	@echo "status\t\t\t- show status of containers"