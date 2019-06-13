#!/bin/ksh
# Script gerado para a ativacao de um determinado executavel para profiling com o valgrind especifico para oper_server
# Autor : Adriano Ferreira de Paula
# Data : 22/05/2013

# Para o oper_server.sh, fazer a seguinte alteracao:
# de:
# 
# $JAVA_HOME/bin/java -Xmx512m -Dlog.name=operWeb.log -Dlog.dir=${LOG_DIR} -Djava.library.path=$LD_LIBRARY_PATH -d64 -cp ${CLASSPATH} $1 $2 $3
#
# para:
#
# ARQ_SUPP=/home/adrianof/fontes_diversos/valgrind-src/valgrind-3.9.0/default.supp
# CMD="$JAVA_HOME/bin/java -Xmx512m -Dlog.name=operWeb.log -Dlog.dir=${LOG_DIR} -Djava.library.path=$LD_LIBRARY_PATH -d64 -cp ${CLASSPATH} $1 $2 $3"
# inicia_valgrind.sh "$CMD" -log $ARQ_SUPP $LOG_DIR operWeb_valgrind
# 

###############################################################################################
PS="ps auxwww"
GREP="grep"

_uso () {
	echo "Uso: $0 <comando do executavel> <modo de log> <arq supp> <dir log> <nome arq log>"
	echo " <comando do executavel> : Comando do executavel com parametros."
	echo " <modo de log>  : constante para ativar opcoes de log para utilizacao do valgrind:"
	echo "   	   -log   : grava log no farmato esepcifico do valgrind; (nome arq log.log)"
	echo "   	   -xml   : grava log em formato xml; (nome arq log.xml - o formato xml eh utilizado pela interface grafica \"valkyrie\")"
	echo " <arq supp>     : arquivo de supressao de mensagens; "
	echo " <dir log>      : diretorio onde os arquivos de log serao criados;"
   	echo " <nome arq log> : Nome do arquivo de log sem especificar a extensao (.log ou .qualquer coisa);"
	exit 0
}

# checa a quantidade de parametros obrigatorios
if [  $# -ne 5 ]; then
	_uso;
	exit 0
fi

# checa se o parametro <modo de log> foi informado corretamente
if [ "$2" != "-log" ] && [ "$2" != "-xml" ]; then
	echo "[ERRO] :: Parametro invalido. (modo de log)"
	_uso;
	exit 0
else 
	V_MODO=$2
fi

# checa se o arquivo de supressao existe
if [ ! -e "$3" ]; then
	echo "[ERRO] :: Arquivo de supressao nao foi encontrado."
	exit 0
else 
	V_ARQ_SUPP=$3
fi

# checa se o diretorio de log existe
if [ ! -e "$4" ] || [ ! -d "$4" ]; then
	echo "[ERRO] :: Diretorio de log invalido."
	exit 0
else 
	if [ $((${#4}-1)) != "/" ]; then
		V_LOG_DIR=$4"/"
	else 
		V_LOG_DIR=$4
	fi
fi

# recupera o nome do log sem nenhuma extensao
V_NOME_LOG=`echo $5 | sed 's/\..*//g'`

# Setando paramtros 
V_EXEC_FULL=$1
V_EXECUTAVEL=`echo $1 | awk '{print $1}'`
V_ULTIMO_PARAMETRO=`echo $1 | awk '{print $NF}'`

if [ "$V_EXECUTAVEL" == "$V_ULTIMO_PARAMETRO" ]; then
	V_ARQ_LOG=$V_LOG_DIR$V_NOME_LOG"_valgrind.log"
	V_ARQ_XML=$V_LOG_DIR$V_NOME_LOG"_valgrind.xml"
else 
	V_ARQ_LOG=$V_LOG_DIR$V_NOME_LOG"_"$V_ULTIMO_PARAMETRO".log"
	V_ARQ_XML=$V_LOG_DIR$V_NOME_LOG"_"$V_ULTIMO_PARAMETRO".xml"
fi


echo ""
echo "##################################################################################"
echo "###"
echo "###  EXECUTAVEL   : $V_EXECUTAVEL"
if [ "$V_MODO" == "-log" ]; then
	echo "###  ARQ LOG      : $V_ARQ_LOG"
else
	echo "###  ARQ_XML      : $V_ARQ_XML"
fi
echo "###  ARQ_SUPP     : $V_ARQ_SUPP"
echo "###"
echo "##################################################################################"


# Setando parametros para log
[ "$V_MODO" == "-log" ] && VALGRIND_OPTS="--log-file=$V_ARQ_LOG --suppressions=$V_ARQ_SUPP"
[ "$V_MODO" == "-xml" ] && VALGRIND_OPTS="--xml=yes --xml-file=$V_ARQ_XML --suppressions=$V_ARQ_SUPP"

# Utilizado para gerar o log de supressao. (comentar apos o uso)
#VALGRING_OPTS+=" --gen-suppressions=all"

# Parametros comuns do valgrind (optimizado para o oper_server.sh)
VALGRIND_OPTS+=" --leak-check=full --show-leak-kinds=definite --error-limit=no --track-origins=yes --show-reachable=yes --read-var-info=yes --trace-children=yes --trace-children-skip-by-arg=Process0,Process1"
#(normal)VALGRIND_OPTS+=" --leak-check=full --error-limit=no --track-origins=yes --show-reachable=yes --read-var-info=yes --trace-children=yes "

# Valgrind
VALGRIND=/home/adrianof/bin/valgrind

### ATIVACAO do executvel
v_ativacao=`$PS | $GREP $V_EXECUTAVEL | $GREP $V_ULTIMO_PARAMETRO | $GREP $USER | $GREP -v $GREP | $GREP -v $0`

if test "x$v_ativacao" = "x"
then
  echo "------------------- Iniciando Profilling do $V_EXECUTAVEL ---------------------"
  echo "$VALGRIND $VALGRIND_OPTS $V_EXEC_FULL"
  $VALGRIND $VALGRIND_OPTS $V_EXEC_FULL &
else
  echo "ATENCAO ==> JA' ha' um executavel $V_EXECUTAVEL ativo nesta maquina!!!"
  exit 0
fi
