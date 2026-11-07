# setTimezone

Выставляет часовой пояс сервера.

## Requirements

Нет. Запуск с `become: true`.

## Role Variables

| Переменная | По умолчанию | Описание |
| --- | --- | --- |
| `timezone` | `Europe/Volgograd` | Часовой пояс в формате tz database. |

## Dependencies

Нет.

## Example Playbook

```yaml
- hosts: lxc
  become: true
  roles:
    - role: setTimezone
```

Готовый плейбук: `playbooks/configurateServers.yml`, запуск — `make servers`.

## License

BSD
