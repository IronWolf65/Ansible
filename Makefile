.PHONY: localmac servers

localmac:
	ansible-playbook localmac.yml --ask-become-pass

servers:
	ansible-playbook -i ./inventory/homelab.yml configurateServers.yml

serverAddAnsibleUser:
	ansible-playbook -i ./inventory/tmp.yml addAnsibleUser.yml --ask-pass --ask-become-pass -u wolf --private-key=~/.ssh/IronWolf