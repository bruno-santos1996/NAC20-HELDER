# NAC20-HELDER
NAC 20 - HELDER - BKP AUTOMÁTICO

#Script que irá realizar o bkp do Apache WebServer


1º Passo: O Script irá verificar algumas informações junto ao usuário, lhe concedendo  automatizar o script, ou ainda permanecer "Manual" mesmo já sendo automatizado.

2º Passo: Os seguintes etapas que será realizada pelo script, consistirá em seguir uma rotina que o próprio usuario irá realizar no tempo que o mesmo achar necessário, ou simplesmente permitir que o script execute a mesma função com base na opção que o usuario escolher, executando Hora a Hora, Dia a Dia, Mês a Mês, a forma como o Usuario escolher.

3º Passo: É imprescindível realizar "git clone" do arquivo, configurar e concedero o acesso "chmod +x" dos arquivos ".sh", e os executar como root.

4º Passo: A rotina programada está da seguinte forma estado:

Inicialmente vamos verificar quais das opções o usuario irá escolher, foi criado uma função para que, com base em um "case" seja chamado outras funções, sendo que essas informações iniciais que será necessário uma interação do usuario para seguir para o proximo passo.

Informações a serem verificadas e ações a serem tomadas:

Verificar o SO e se o mesmo é compatível; instalar o Apache; verificar se o diretório "/Backup_webServer" existe, caso não, criar; realizar o BKP do diretório criado; exibir o caminho do diretório; automatizar o script;


Conforme a decisão tomada pelo usuário, o script irá executar uma das funções, abaixo a lista e funcionalidade de cada uma delas:



1: Função "inicio()" - Executa a verificação inicial do Usuario, qual será a ação que o mesmo ira tomar.

2: Função "seeSystem()" - Verifica se o SO é compativel com o Script (Ubuntu).

3: Função "apache()" - Confirma se o Servidor Apache está instalado, caso não, efetua a instalação

4: Função "seeDir()" - Confirma se o diretório "/Backup_webServer" existe para fazer os backup necessários, caso o diretório não exista, é criado, e é feito o Backup inicial.

5: Função "doBackup()" - Realiza o bkp necessário para a restauração do Apache em caso de falhas, e dos arquivos de configuração do mesmo.

6: Função "showPath()" - Mostra o caminho de onde está localizado o diretório do Backup.

7: Função "autoScr()" - Cria a automação do Script para executar automanticamente, necessário indicar todo o caminho até o arquivo, e o Script para  executar a automação é o "/backup_aut.sh", e ao colocar o nome dele na indicação do local, o script será executado automaticamente de acordo com o agendamento.
