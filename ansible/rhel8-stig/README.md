# DISA STIG for Red Hat Enterprise Linux 8

| Platform | Tool Type | RMF STEP |
| --- | --- | --- |
| ~"OS::Linux" | ~"TYPE::FOSS" | ~"Implement"  | 

## Overview

**This role is still under active development.**

Configure a Red Hat Enterprise Linux or CentOS 8 system to be DISA STIG compliant.

The Red Hat Enterprise Linux 8 STIG can be downloaded from DISA at https://public.cyber.mil/stigs/downloads/

This role is based on RHEL 8 DISA STIG: [Version 1, Rel 8](https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/U_RHEL_8_V1R8_STIG.zip)

Requirements
------------
| OS Version | Ansible Version | 
| --- | --- |
| RHEL 8 or CentOS 8 | Ansible >= 2.9.10 |

Dependencies
------------
- [aide](https://gitlab.us.lmco.com/cybertoolkit/cyber-security-tools/misc-cyber-tools/ansible/aide)

- [usbguard](https://gitlab.us.lmco.com/cybertoolkit/cyber-security-tools/misc-cyber-tools/ansible/usbguard)

Role Variables
--------------

[Variables can be changed in defaults/main.yml, changed per group of hosts in groups_vars, or individual host in host_vars](./defaults/main.yml)

| Name              | Default Value       | Description          |
|-------------------|---------------------|----------------------|
| `rhel8stig_cat1_patch` | `true` | Correct CAT I Findings |
| `rhel8stig_cat2_patch` | `true` | Correct CAT II Findings |
| `rhel8stig_cat3_patch` | `true` | Correct CAT III Findings |
| `rhel_08_######` | [see defaults/main.yml](./defaults/main.yml) | Individual variables to enable/disable each STIG ID. |
| `rhel_08_pam_rules` | `true` | Apply PAM specific STIG IDs |
| `rhel_08_audit_rules` | `true` | Apply audit.rules specific STIG IDs |
| `rhel8stig_min_ansible_version` | `2.9` | Minimum Ansible Version needed to run the role |
| `rhel8stig_gui` | `Dynamic` | Dynamically generated varible - Does the system have Gnome Desktop installed |
| `rhel8stig_machine_uses_uefi` | `Dynamic` | Dynamically generated varible - Does the system utilize a UEFI or traditional BIOS |
| `rhel8_fips_mode` | `true` | Does the system require FIPS- 140-2 compliance |
| `rhel8stig_mfa` | `false` | Does the system require PKI/Smart Cards/PIV/CAC for authentication |
| `rhel8stig_standalone_auth` | `true` | Does the system authenticate with any Central Authentication tools (IPA/IDM/AD) |
| `rhel8stig_deny_root` | `true` | Should the root account be locked out if it fails to authenticate multiple times |
| `rhel8stig_sssd` | `false` | Does the system utilize SSSD as a part of its authentication implementation |
| `rhel8stig_kerberos` | `false` | Does the system utilize Kerberos as a part of its authentication implementation |
| `rhel8stig_gssapi` | `false` | Does the system utilize GSSAPI as a part of its authentication implementation |
| `rhel8stig_autofs` | `false` | Does the system utilize AutoFS |
| `rhel8stig_usbstorage` | `false` | Does the system require the ability to mount USB Storage Devices |
| `rhel8stig_wifi` | `false` | Does the system require Wireless Network connectivity |
| `rhel8stig_bluetooth` | `false` | Does the system require Bluetooth connectivity |
| `rhel8stig_whitelisting` | `false` | Does the system require the fapolicyd open source whitelisting application be configured |
| `rhel8stig_usbguard` | `true` | Does the system require the USBGuard open source USB port blocking application be configured |
| `rhel8stig_postfix` | `false` | Does the system require Postfix or act as a mail server/relay |
| `rhel8stig_x11` | `false` | Does the system require allowing x11 forwarding of GUI based applications from it |
| `rhel8stig_audit_rules_immutable` | `true` | Does the system require auditd rules are immutable |
| `rhel8stig_bootloader_password` | `{{ vault_bootloader }}` | Password to be used for limiting access to the Grub Bootloader |
| `vault_bootloader` | `vaulted` | Create /etc/ansible/group_vars/vault.yml with this variable and a password then encrypt it with ansible-vault |
| `rhel8stig_boot_superuser` | `hulk` | Grub 2 Bootloader superuser name (cannot be root to be STIG compliant) |
| `rhel8stig_dns_server1/2` | `10.10.1.1` | The DNS Servers within the systems environment |
| `rhel8stig_homedir_mode` | `g-w,o-rwx` | Default permissions to be assigned to user home directories upon user creation |
| `rhel8stig_maxlogins` | `10` | Maximum concurrent logins for all user accounts |
| `rhel8stig_password_complexity.ucredit` | `-1` | Require Uppercase character class for password complexity |
| `rhel8stig_password_complexity.lcredit` | `-1` | Require Lowercase character class for password complexity |
| `rhel8stig_password_complexity.dcredit` | `-1` | Require Digit character class for password complexity |
| `rhel8stig_password_complexity.maxclassrepeat` | `4` | Require no more then 4 of the same character class in a row for password complexity |
| `rhel8stig_password_complexity.maxrepeat` | `3` | Require no more then 3 of the same character in a row for password complexity |
| `rhel8stig_password_complexity.minclass` | `4` | Require 4 Character Classes for password complexity |
| `rhel8stig_password_complexity.difok` | `8` | Require at least 8 characters change between the new and old password for password complexity |
| `rhel8stig_password_complexity.minlen` | `15` | Require 15 character minimum password for password complexity |
| `rhel8stig_password_complexity.ocredit` | `-1` | Require Special character class for password complexity |
| `rhel8stig_password_complexity.dictcheck` | `-1` | Require Dictionary Check for password complexity |
| `rhel8stig_login_defaults.encrypt_method` | `SHA512` | Hashing algorithm applied to passwords in /etc/shadow |
| `rhel8stig_login_defaults.create_home` | `true` | Create the user's home directory when new user is created |
| `rhel8stig_login_defaults.pass_min_days` | `1` | Minimum number of days between password changes |
| `rhel8stig_login_defaults.pass_max_days` | `60` | Maximum number of days between password changes |
| `rhel8stig_login_defaults.pass_min_len` | `15` | Password minimum length |
| `rhel8stig_login_defaults.fail_delay_secs` | `4` | Delay between password attempts |
| `rhel8stig_login_defaults.umask` | `077` | Default umask for new user home directories |
| `rhel8stig_sudo_timeout` | `0` | Timeout for sudo password cacheing |
| `rhel8stig_root_pw_age` | `60` | The root user account is often subject to a different maximum password age |
| `rhel8stig_unnecessary_accounts` | `games` | List of user accounts to be removed and are considered unnessesary for the system to operate |
| `rhel8stig_remove_unnecessary_user_files` | `false` | Should the home directory be removed when the unnessesary account is removed (This can cause issues so be sure) |
| `rhel8stig_disk_error_action` | `SYSLOG` | Auditd action to take the log storage disk enters an error state |
| `rhel8stig_max_log_file_action` | `SYSLOG` | Auditd action to take when the log file size reaches its maximum |
| `rhel8stig_disk_full_action` | `SYSLOG` | Auditd action to take when the log storage partition is full |
| `rhel8stig_name_format` | `fqd` | Auditd setting for the system name displayed in the log message (hostname, fqd, numeric, none) |
| `rhel8stig_usbguard_audit` | `LinuxAudit` | Method for usbguard to create audit logs |
| `rhel8stig_time_server1/2` | `0.north-america.pool.ntp.org` | NTP time servers within the the systems environment |
| `rhel8stig_timeserver` | `false` | Does the system act as a Time Server |
| `rhel8stig_syslog_forward_logs` | `true` | Does the system forward syslog to a central location |
| `rhel8stig_log_aggregation_server` | `10.10.1.1` | Syslog servers within the the systems environment |
| `rhel8stig_log_aggregation_port` | `514` | Syslog application port used within the the systems environment |
| `rhel8stig_overflow_action` | `SYSLOG` | Auditd action to take when the daemon is receiving more events then it can process |
| `rhel8stig_requires_telnet` | `false` | Does the system need the telnet server application |
| `rhel8stig_requires_rsh` | `false` | Does the system need the rsh server application |
| `rhel8stig_requires_old_openssh` | `false` | Does the system need an openssh application older than v7.6 |
| `rhel8stig_whitelisting_state` | `1` | If fapolicyd was installed should it be configured in permissive mode (1=yes) |
| `rhel8stig_requires_tftp` | `false` | Does the system need the tftp server application |
| `rhel8stig_user_namespaces` | `0` | Does the system utilize user namespaces (Set to 7182 or higher if the server runs containers ) |
| `rhel8stig_requires_vsftpd` | `false` | Does the system need the vsftp server application |
| `rhel8stig_router` | `false` | Does the system act as a router |
| `rhel8stig_aide` | `true` | Does the system require aide be installed and configured |

Role Tags
---------
| Tag |  Required for Specific task to Run | Description |
| --- | --- | --- |
| `prelim_tasks` | no | Runs only Prelim tasks | 
| `cat1` | no | Runs only Catagory 1 STIG Lockdowns | 
| `high` | no | Runs only Catagory 1 STIG Lockdowns | 
| `cat2` | no | Runs only Catagory 2 STIG Lockdowns | 
| `medium` | no | Runs only Catagory 2 STIG Lockdowns | 
| `cat3` | no | Runs only Catagory 3 STIG Lockdowns | 
| `low` | no | Runs only Catagory 3 STIG Lockdowns | 
| `reboot_yes` | yes | Global tag that will execute **ALL** STIG Lockdowns then reboot **ALL** endpoints |
| `reboot_no` | yes | Global tag that will execute **ALL** STIG Lockdowns **BUT WILL NOT** reboot **ANY** endpoints | 
| `reboot_endpoints` | yes | Task unique tag that is made to be callable for reboot functions of all endpoints but only that. | 

Dependency Tags
---------
| Tag |  Required for Specific task to Run | Description |
| --- | --- | --- |
| `install_aide` | yes | Runs the installation of AIDE to become Compliant with the STIG | 
| `install_usbguard` | yes | Runs the installation and configuration of USBGuard to become Compliant with the STIG | 

Example Playbook
----------------

```YAML
---
- hosts: all
  become: yes

  roles:
    - rhel8-stig
```

Example Execution
-----------------
**Important** This role calls additional roles, therefore, TAGS are required to be passed. See below for examples of each type.

*Note:* If passwordless SSH is not configured (ex: through use of ssh-keys), additional flag will need to be passed.

| Flag |  Flag Descriptions |
| --- | --- |
| `-k` | Prompts user to input user ssh password |
| `-K` | Prompts user to input sudo/super user password |
| `--ask-vault` | Prompts user to input ansible vault decryption password |

Execute ALL STIGs and **Reboot** ALL (**exception is control node/localhost**) endpoints to ensure STIG is applied
```BASH
ansible-playbook configure-rhel8-stig.yml -K --ask-vault --tag reboot_yes,install_aide,install_usbguard
```
Execute ALL STIGs and **DO NOT Reboot** endpoints
```BASH
ansible-playbook configure-rhel8-stig.yml -K --ask-vault --tag reboot_no,install_aide,install_usbguard
```
Execute Specific STIGs and Reboot endpoints afterwards (**exception is control node/localhost**)
```BASH
ansible-playbook configure-rhel8-stig.yml -K --ask-vault --tag cat1,reboot_endpoints
```
Already STIG'd and need to Reboot endpoints (**exception is control node/localhost**)
```BASH
ansible-playbook configure-rhel8-stig.yml -K --ask-vault --tag reboot_endpoints
```

License
-------
MIT

Contributors
------------------
### Original Author 
Chad Zimmerman (Chad.Zimmerman@lmco.com)

### Contributors
Sorrel Paris (sorrel.e.paris@lmco.com)