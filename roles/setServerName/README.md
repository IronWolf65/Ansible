# setServerName

Устанавливает hostname хоста равным его имени в inventory.

## Requirements

Нет. Запуск с `become: true`.

## Role Variables

Своих переменных нет — используется `inventory_hostname`.

## Dependencies

Нет.

## Example Playbook

```yaml
- hosts: lxc
  become: true
  roles:
    - role: setServerName
```

В `playbooks/configurateServers.yml` роль закомментирована.

## License

BSD
