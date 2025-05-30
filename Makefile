up:
	docker-compose up -d

down:
	docker-compose down

build:
	docker-compose build

migrate:
	docker-compose run web rails db:migrate

sql:
	docker-compose exec db mysql -uroot -p