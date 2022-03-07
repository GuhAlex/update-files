#!/usr/bin/env bash

clear

## IP Address of destination to file-copying
read -r -p "type the IP Address of hosts separated by space:" -a address
for i in "${address[@]}"; do
   echo "$i"
done
## Directories of source to file-copying
read -r -p "type the source directories separated by space: " -a directories
for i in "${directories[@]}"; do
   echo "$i"
done
## Directory of destination file-copying
read -r -p "type the destination directory: " destination
## trigger unit-timer run file-copying
read -r -p "type the time to trigger update-files ex[22:30]: " time

cat > "/usr/local/bin/update_files" << EOF
#!/bin/bash

machines=(${address[*]@Q})
src=(${directories[*]@Q})
dest=$destination
EOF

cat >> "/usr/local/bin/update_files" << 'EOF'
for i in ${machines[@]}
do
  for j in ${src[@]}
  do
     rsync -azhv $j  $i:$dest
  done
done
EOF

cat > "/usr/lib/systemd/system/update-files.service" << EOF
[Unit]
Description=Update files on my local environment

[Service]
Type=oneshot
ExecStart=/usr/local/bin/update_files

[Install]
WantedBy=multi-user.target
EOF

cat > "/usr/lib/systemd/system/update-files.timer" << EOF
[Unit]
Description=Scheduler for update-files

[Timer]
OnCalendar=*-*-* $time
RandomizedDelaySec=60m
Persistent=true

[Install]
WantedBy=timers.target
EOF

chmod +x /usr/local/bin/update_files
systemctl enable update-files
systemctl daemon-reload
