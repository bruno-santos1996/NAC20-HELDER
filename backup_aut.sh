#!/bin/bash

#Hora e Data
DATA=$(date "+%d-%m-%y_%Hh%Mm")

#SYSTEM INFORMATION
SO=$(cat /etc/*release | grep ^NAME | cut -d "=" -f2 | cut -d '"' -f2)

#VERIFICAR SISTEMA
if [ $SO == Ubuntu ]; then
	echo "Sistema: $SO"
else
	echo "Sistema: $SO"
	exit
fi

#Realizar o BKP.
#	Diretorio: /var/log/apache2/
#	Arquivo:   /etc/apache2/apache2.conf
#	Arquivo:   /etc/apache2/conf-available
#	Arquivo:   /etc/apache2/conf-enabled

#Varredura se existe um diretório para BKP
if [ -e "/Backup_WebServer" ]; then
	echo "DIRETÓRIO NÃO EXISTE"
else
	echo " CRIANDO DIRETÓRIO"
	mkdir /Backup_WebServer
fi

#Diretorio e Arquivos
LOCAL_BACKUP="/Backup_WebServer"
VAR_DIR=("/var/log/apache2" "/var/www")
VAR_ARC=("/etc/apache2/apache2.conf" "/etc/apache2/conf-available" "/etc/apache2/conf-enabled")
BACKUP=("${VAR_DIR[@]}" "${VAR_ARC[@]}")
NOME_ARC="Apache-$DATA.tgz"

#Compactando os arquivos e enviando para o destino de BKP
sudo tar -czvf ${LOCAL_BACKUP}/${NOME_ARC} ${BACKUP[@]}
