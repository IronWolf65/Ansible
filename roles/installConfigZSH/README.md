# installConfigZSH

Ставит пользователю oh-my-zsh, тему PowerLevel10K и шрифт FiraCode Nerd Font, подключает тему в `.zshrc`.

## Requirements

- Целевой пользователь должен существовать, у него должен быть `/bin/zsh` и `.zshrc` (создаётся oh-my-zsh).
- Доступ в интернет: GitHub и raw.githubusercontent.com.
- Часть задач пишет в `/usr/share/fonts`, поэтому нужен `become: true`.

## Role Variables

| Переменная | По умолчанию | Описание |
| --- | --- | --- |
| `user` | не задана | Имя пользователя, которому настраивается zsh. Обязательна — задаётся в плейбуке или inventory. |

## Dependencies

Нет.

## Example Playbook

```yaml
- hosts: lxc
  become: true
  vars:
    user: ansible
  roles:
    - role: installConfigZSH
```

## License

BSD
