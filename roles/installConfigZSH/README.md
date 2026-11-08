# installConfigZSH

Ставит пользователю oh-my-zsh, тему PowerLevel10K и шрифт FiraCode Nerd Font, подключает тему в `.zshrc`. Работает на Linux и macOS.

## Requirements

- Целевой пользователь должен существовать.
- Доступ в интернет: GitHub и raw.githubusercontent.com.
- Linux: роль ставит `zsh`, `git`, `unzip`, `fontconfig`; часть задач пишет в `/usr/share/fonts`, поэтому нужен `become: true`.
- macOS: роль ставит `git` через Homebrew (должен быть установлен), шрифты кладутся в `~/Library/Fonts`, sudo не нужен.

## Role Variables

| Переменная | По умолчанию | Описание |
| --- | --- | --- |
| `user` | не задана | Имя пользователя. Обязательна — задаётся в плейбуке или inventory. |
| `user_home` | `/home/{{ user }}` (Linux) или `/Users/{{ user }}` (macOS) | Домашний каталог. Переопредели, если путь нестандартный. |
| `fonts_dir` | `/usr/share/fonts/FiraCode` (Linux) или `~/Library/Fonts` (macOS) | Куда устанавливать шрифты. |
| `is_macos` | вычисляется по фактам | Выбор путей и пакетного менеджера. |

## Dependencies

Нет. Зависимости ставит сама роль.

## Example Playbook

```yaml
- hosts: lxc
  become: true
  vars:
    user: ansible
  roles:
    - role: installConfigZSH
```

На macOS роль подключена в `playbooks/localmac.yml`, запуск — `make localmac`.

## License

BSD
