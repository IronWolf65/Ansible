.PHONY: localmac servers serverAddAnsibleUser

default: help

localmac: ## Настройка MacBook
	ansible-playbook localmac.yml --ask-become-pass

servers: ## Конфигурация серверов
	ansible-playbook -i ./inventory/homelab.yml configurateServers.yml

serverAddAnsibleUser: ## Добавление на ./inventory/tmp.yml пользователя "Ansible" с его ssh ключом
	ansible-playbook -i ./inventory/tmp.yml addAnsibleUser.yml --ask-pass --ask-become-pass -u wolf --private-key=~/.ssh/IronWolf

help: ## Показать справку
	@awk 'BEGIN {FS = ":.*##"; printf "\nИспользование:\n  make \033[36m<цель>\033[0m\n\nЦели:\n"} \
	/^[a-zA-Z_-]+:.*##/ { \
		count++; \
		targets[count] = $$1; \
		help[$$1] = $$2; \
		if (length($$1) > max_len) max_len = length($$1); \
	} \
	END { \
		for (i = 1; i <= count; i++) { \
			t = targets[i]; \
			printf "  \033[36m%-*s\033[0m  %s\n", max_len, t, help[t] \
		} \
	}' $(MAKEFILE_LIST)