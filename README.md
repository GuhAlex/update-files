# UpdateFiles
---


Bash file-copying for multiple hosts and multiples directories using rsync

---
### Requirements

- Shell Bash
- ssh-copy-id with root user for all server hosts


1. clone repo
```
git clone git@github.com:GuhAlex/update-files.git
```
2. run bash script
```
sudo bash setup.sh
```
An interactive session will be initialized requesting the ip addresses of the server hosts as well as the source directories of client and destination directory of the servers.\
Also, will be prompted for the trigger time for the systemd.timer.

3. check configurations
```
systemctl status update-files
```
