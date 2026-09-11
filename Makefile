# Basic ANSI Colors
RED_COLOR = \033[31m
GREEN_COLOR = \033[32m
YELLOW_COLOR = \033[33m
BLUE_COLOR = \033[34m
MAGENTA_COLOR = \033[35m
CYAN_COLOR = \033[36m
WHITE_COLOR = \033[37m

HELP_COLOR = $(CYAN_COLOR)
RESET_COLOR = \033[0m

default: help

.PHONY: localmac
localmac: ## 💻 Настройка MacBook
	ansible-playbook localmac.yml --ask-become-pass

.PHONY: servers
servers: ## ⚙️  Конфигурация серверов
	ansible-playbook -i ./inventory/homelab.yml configurateServers.yml

.PHONY: serverAddAnsibleUser
serverAddAnsibleUser: ## 👤 Добавление на ./inventory/tmp.yml пользователя "Ansible" с его ssh ключом
	ansible-playbook -i ./inventory/tmp.yml addAnsibleUser.yml --ask-pass --ask-become-pass -u wolf --private-key=~/.ssh/IronWolf

.PHONY: help
help: ## ℹ️  Показать справку
	@awk -v col="$(HELP_COLOR)" -v res="$(RESET_COLOR)" 'BEGIN { \
		FS = ":.*##"; \
		printf "Использование:\n  make %s<цель>%s\n\nЦели:\n", col, res \
	} \
	/^[a-zA-Z_-]+:.*##/ { \
		count++; \
		targets[count] = $$1; \
		help[$$1] = $$2; \
		if (length($$1) > max_len) max_len = length($$1); \
	} \
	END { \
		for (i = 1; i <= count; i++) { \
			t = targets[i]; \
			printf "  %s%-*s%s  %s\n", col, max_len, t, res, help[t] \
		} \
	}' $(MAKEFILE_LIST)