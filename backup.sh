#!/bin/bash

clear 

#Exibe o usuário com base em cada decisão
#

inicio(){
	CONTROL=0
        if [ $CONTROL == 0 ] || [ $CONTROL <= 7 ]; then
                echo " "
                echo "Digite um numero para seguir com as opcoes abaixo!"
                echo " "
                echo "(1) - Verificar compatibilidade do Script com o Sistema"
                echo "(2) - Instalar o WebServer Apache"
                echo "(3) - Verificar Diretorio de BKP e Fazer BKP inicial"
                echo "(4) - Creted Bkp WebServer"
                echo "(5) - Exibir Diretório de BKP"
                echo "(6) - Automatizar Script"
                echo "(7) - Exit"
                read ver
        fi
        case $ver in
                1) seeSystem; inicio ;;
                2) apache; inicio ;;
                3) seeDir; doBackup; inicio ;;
                4) doBackup; inicio ;;
                5) showPath; inicio ;;
                6) autoScr; inicio ;;
                7) echo "Programa Encerrado"; exit ;;
                *) echo "Opcao desconhecida"; inicio ;;
        esac
}


#INSTALAR APACHE
apache(){
    	sudo apt-get install apache2
	return inicio;
}

#VERIFICAR SISTEMMA
seeSystem(){
    	#SYSTEM INFORMATION.
    	SO=$(cat /etc/*release | grep ^NAME | cut -d "=" -f2 | cut -d '"' -f2)

		#Detalhe do Sistema
    	if [ $SO == Ubuntu ]; then
    		echo "Sistema: $SO"
        	echo "Sistema $SO - COMPATÍVEL"
    	else
    		echo "Sistema $SO - INCOMPATÍVEL"
    		exit
    	fi
}

#Varredura se existe um diretório para BKP
seeDir(){
		#Criando/confirmando se há um diretório de bkp
    	if [ -e "/Backup_WebServer" ]; then
    		echo "DIRETÓRIO NÃO EXISTE"
    	else
    		echo "DIRETÓRIO NÃO ENCONTRADIO"
    		mkdir /Backup_WebServer
		echo "DIRETORIO CRIADO!"
	fi
}

#Funcao para fazer o BKP.
doBackup(){
    	#Sera feito um BKP dos Diretorios e dos Arquivos abaixo para a pasta na Raiz "/Backup_WebServer"
    	#	Diretorio: /var/www/
    	#	Diretorio: /var/log/apache2/
    	#	Arquivo:   /etc/apache2/apache2.conf
    	#	Arquivo:   /etc/apache2/conf-available
    	#	Arquivo:   /etc/apache2/conf-enabled

    	#Diretorio e Arquivos
    	#Hora e Data.
    	DATA=$(date "+%d-%m-%y_%Hh%Mm")
    	LOCAL_BACKUP="/Backup_WebServer"
    	VAR_DIR=("/var/log/apache2" "/var/www")
    	VAR_ARC=("/etc/apache2/apache2.conf" "/etc/apache2/conf-available" "/etc/apache2/conf-enabled")
    	BACKUP=("${VAR_DIR[@]}" "${VAR_ARC[@]}")
   	NOME_ARC="Apache-"$DATA".tgz"
	echo " "
	echo "Realizando BKP..."
	echo " "
    	#Compactando os arquivos e enviando para diretório de BKP
    	sudo tar -czvf ${LOCAL_BACKUP}/${NOME_ARC} ${BACKUP[@]}
	echo " "
	echo "BKP realizado com Sucesso para a pasta $LOCAL_BACKUP."
	echo " "
}

#Exibe o diretório de destino do BKP.
showPath(){
    	echo " "
    	echo "Local a pasta $LOCAL_BACKUP foi criada na RAIZ do sistema."
    	echo " "
    	ls -l /
}

#Automação do Scrip de BKP
autoScr(){
	echo " "
	#Variavel padrao que e necessaria para executar o script.
	BB="/bin/bash"
    	echo "Automatizando Script"
    	echo "Caso queria dar bypass como Hora, Minuto ou etc, inserir asterisco *"
	echo " "
	read -p "Digite a hora - 0 a 23: " H
    	read -p "Digite a minuto - 0 a 59: " MIN
    	read -p "Digite a Dia do Mês - 1 a 31: " DDM
    	read -p "Digite a Mês - 1 a 12: " MES
    	read -p "Digite a Dia da Semana - 0 a 6 (0 é Domingo): " DDS
    	read -p "Digite o Caminho do Script de BKP Automatico, e adiciona o script _aut.sh: " P
    	echo " "
	echo "$MIN $H $DDM $MES $DDS $BB $P" >> /var/spool/cron/crontabs/root
}

#Chamado a função Principal do Script
inicio
