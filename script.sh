#!/bin/bash


# Copier le fichier de configuration sur le serveur

cp ./config__files/ssh/sshd_config /etc/ssh/sshd_config

cp ./config__files/ssh/Banner /etc/Banner


# Redemarrer le service sshd

systemctl restart sshd


#Création d'un utilisateur et ajout de celui-ci dans le gorupe root

printf "Création d'un utilisateur. Entrez le nom d'utilisateur désiré :\n"

read user

useradd -m -d/home/$user -s /bin/bash -c "$user" $user && passwd $user && usermod -aG sudo $user && echo -e $user "est devenu un utilisateur root\n"


#Ajout de la clé publique

printf "Entrez votre clé publique : \n"

read key

echo $key >> tmp.txt

cat tmp.txt >> ~/.ssh/authorized_keys && cat tmp.txt >> /home/ubuntu/.ssh/authorized_keys && echo "Clé ssh ajoutée"
service ssh restart
rm tmp.txt
