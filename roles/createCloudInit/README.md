# createCloudInit

Собирает на хосте Proxmox шаблон VM из официального Ubuntu Cloud Image: скачивает образ, кастомизирует его через `virt-customize`, импортирует диск, настраивает Cloud-Init и конвертирует VM в шаблон. Если образ скачался заново, старый шаблон с тем же ID удаляется и собирается новый.

## Requirements

- Хост Proxmox VE с `qm`; роль ставит `libguestfs-tools` (нужен `virt-customize`) через `apt`.
- Права root на хосте Proxmox (`become: true`).
- Публичный ключ `proxmox_ci_sshkey_path` на управляющей машине.
- Директория `proxmox_image_dir` на хосте (создаётся ролью), место под образ ~600 МБ.
- Доступ к `cloud-images.ubuntu.com`.

## Role Variables

Все переменные лежат в `defaults/main.yml`.

| Переменная | По умолчанию | Описание |
| --- | --- | --- |
| `proxmox_vm_id` | `9999` | ID VM/шаблона в Proxmox. |
| `proxmox_vm_name` | `ubuntu-cloudimg` | Имя шаблона. |
| `proxmox_vm_memory` | `1024` | RAM, МБ. |
| `proxmox_vm_cores` | `1` | Количество ядер. |
| `proxmox_vm_bridge` | `vmbr0` | Сетевой мост. |
| `proxmox_image_dir` | `/storageN150NAS/ISO/template/iso` | Куда скачивать образ. |
| `proxmox_image_name` | `noble-server-cloudimg-amd64.img` | Имя файла образа. |
| `proxmox_image_url` | `https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img` | Откуда скачивать образ. |
| `proxmox_image_customize_args` | `--install qemu-guest-agent`, `--run-command 'truncate -s 0 /etc/machine-id'` | Аргументы `virt-customize`, по одному на элемент списка. |
| `proxmox_storage_pool` | `local-zfs` | Хранилище для диска и Cloud-Init. |
| `proxmox_min_free_space` | `5368709120` (5 GiB) | Минимум свободного места на пуле перед удалением старого шаблона, байты. |
| `proxmox_ci_user` | `ansible` | Пользователь Cloud-Init. |
| `proxmox_ci_sshkey_path` | `~/.ssh/ansible.pub` | Публичный ключ, добавляемый в шаблон. |
| `proxmox_ci_nameserver` | `192.168.88.1` | DNS для гостей. |

Как работает:

- Образ проверяется по `SHA256SUMS` из каталога `proxmox_image_url`; скачивание повторяется 2 раза при ошибке.
- `virt-customize` запускается только при новом образе и **до** удаления старого шаблона: если кастомизация упадёт, рабочий шаблон останется.
- Перед удалением старого шаблона проверяется свободное место на `proxmox_storage_pool`: если его меньше `proxmox_min_free_space`, плейбук падает, не трогая шаблон.
- В описание шаблона пишутся дата образа, дата пересборки и список применённых изменений.

## Dependencies

Нет. `libguestfs-tools` ставится самой ролью.

## Example Playbook

```yaml
- hosts: proxmox
  become: true
  vars_prompt:
    - name: ansible_password
      prompt: "Пароль SSH"
      private: true
    - name: ansible_become_password
      prompt: "Пароль sudo"
      private: true
  roles:
    - role: createCloudInit
```

Готовый плейбук: `playbooks/createCloudInit.yml`, запуск — `make createCloudInit`.

## License

BSD
