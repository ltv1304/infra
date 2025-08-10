REGISTRY := registry.toolbox.local:5000
USER     := toolbox
PASS     := 2116
CA_CERT := ssl/public.pem

# Основные цели
.PHONY: clean gc remove-image list help

## list: Показать все репозитории
list:
	@curl --cacert $(CA_CERT) -s -u $(USER):$(PASS) "https://$(REGISTRY)/v2/_catalog" | jq

## remove-image: Удалить все теги образа (использование: make remove-image IMAGE=имя_образа)
remove-image:
ifndef IMAGE
	$(error IMAGE не указан. Использование: make remove-image IMAGE=имя_образа)
endif
	@echo "Удаление всех тегов $(IMAGE)..."
	@TAGS=$$(curl --cacert $(CA_CERT) -s -u $(USER):$(PASS) "https://$(REGISTRY)/v2/$(IMAGE)/tags/list" | jq -r '.tags[]?'); \
	for tag in $$TAGS; do \
		digest=$$(curl --cacert $(CA_CERT) -I -s -u $(USER):$(PASS) -H "Accept: application/vnd.docker.distribution.manifest.v2+json" \
		"https://$(REGISTRY)/v2/$(IMAGE)/manifests/$$tag" | grep -i "Docker-Content-Digest" | awk '{print $$2}' | tr -d '\r'); \
		curl --cacert $(CA_CERT) -X DELETE -u $(USER):$(PASS) "https://$(REGISTRY)/v2/$(IMAGE)/manifests/$$digest"; \
		echo "Удален тег: $$tag"; \
	done

## gc: Запустить garbage collection
gc:
	docker exec registry bin/registry garbage-collect /etc/docker/registry/config.yml --delete-untagged=true
	docker compose restart registry

## clean: Полная очистка (требует остановки Registry) (использование: make clean IMAGE=имя_образа)
clean:
ifndef IMAGE
	$(error IMAGE не указан. Использование: make clean IMAGE=имя_образа)
endif
	docker compose stop registry
	sudo rm -rf ./registry/docker/registry/v2/repositories/$(IMAGE)
	sudo rm -f ./registry/docker/registry/v2/repositories/_catalog
	docker compose start registry

## help: Показать справку
help:
	@echo "Доступные команды:"
	@awk -F ': ' '/^## / { cmd = $$1; sub(/^## /, "", cmd);desc = $$2; printf "  \033[36m%-15s\033[0m %s\n", cmd, desc }' $(MAKEFILE_LIST)