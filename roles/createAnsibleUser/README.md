# createAnsibleUser

Создаёт служебного пользователя `ansible`, даёт ему sudo без пароля и кладёт публичный SSH-ключ для входа.

## Requirements

- Коллекции: `community.general` (модуль `sudoers`), `ansible.posix` (модуль `authorized_key`).
- Публичный ключ `~/.ssh/ansible.pub` на управляющей машине.
- Запуск с `become: true` (через `--ask-become-pass` или `ansible_become_password`).

## Role Variables

| Переменная | Значение по умолчанию | Описание |
| --- | --- | --- |
| `userName` | `ansible` (`vars/main.yml`) | Имя создаваемого пользователя. |

Путь к ключу (`~/.ssh/ansible.pub`) задан прямо в задаче и не вынесен в переменные.

## Dependencies

Нет.

## Example Playbook

```yaml
- hosts: lxc
  vars_prompt:
    - name: ansible_password
      prompt: "Пароль SSH"
      private: true
    - name: ansible_become_password
      prompt: "Пароль sudo"
      private: true
  roles:
    - role: createAnsibleUser
```

Готовый плейбук: `playbooks/addAnsibleUser.yml`, запуск — `make serverAddAnsibleUser`.

## License

BSD
