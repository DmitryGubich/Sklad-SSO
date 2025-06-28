shell := uv run

.PHONY: pre-commit
pre-commit:
	$(shell) pre-commit run --all-files

.PHONY: type-checking
type-checking:
	$(shell) pyre

.PHONY: run
run:
	docker compose up

.PHONY: migrate
migrate:
	docker compose exec sso python manage.py migrate

.PHONY: superuser
superuser:
	docker compose exec sso python manage.py createsuperuser

.PHONY: collectstatic
collectstatic:
	docker compose exec sso python manage.py collectstatic