# USBGuard

Ansible Role for installation & configuration of USBGuard on RHEL 7

This role is intended to be executed using tags. Four tags are defined in the tasks/main.yml file.

Tags
----
| Tag | Purpose |
|-----|---------|
| `install` | Install USBGuard |
| `install_tools` | Global Install (to be used with rollback tools) |
| `configure` | Configure USBGuard |
| `start` | Start USBGuard and ensure it persists through reboot |
| `setup` | Execute the tasks associated with the `install` `configure` and `start` tags |
| `stop` | Stop USBGuard and ensure it persists through reboot |
| `uninstall_tools` | Global Uninstall (to be used with rollback tools) |

Example Commands to Execute Playbook
------------------------------------
`ansible-playbook /etc/ansible/playbooks/install-usbguard.yml --ask-pass --ask-become-pass --ask-vault-pass --tag setup`

`ansible-playbook /etc/ansible/playbooks/install-usbguard.yml --ask-pass --ask-become-pass --ask-vault-pass --tag stop`

Role Variables
--------------

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `requires_usbguard` | `no` | The Host or Group requires USBGuard to be installed `Recommend setting to YES via the /etc/ansible/group_vars/<group>/vars.yml file` |


Example Playbook
----------------

	- hosts: all
	  become: yes
	  roles:
	    - role: usbguard