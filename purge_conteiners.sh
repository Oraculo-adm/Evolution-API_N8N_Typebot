#!/bin/bash

echo -e "\033[0;31m"
echo "======================================================================"
echo "==  AVISO MUITO IMPORTANTE: PERDA DE DADOS IRREVERSÍVEL             =="
echo "======================================================================"
echo "Este script irá apagar PERMANENTEMENTE:"
echo "  - TODOS os contêineres Docker (em execução ou parados)"
echo "  - TODAS as imagens Docker (incluindo as que você baixou ou construiu)"
echo "  - TODOS os volumes Docker (contendo bancos de dados, uploads, etc.)"
echo "  - TODAS as redes Docker customizadas"
echo ""
echo "Certifique-se de que você fez backup de qualquer dado importante."
echo "======================================================================"
echo -e "\033[0m"

echo -n "Você tem certeza ABSOLUTA de que deseja apagar TUDO? (digite 'sim' para continuar): "
read confirmation1

if [ "${confirmation1,,}" != "sim" ]; then
  echo "Operação cancelada pelo usuário."
  exit 0
fi

echo ""

echo -e "\033[0;93m"
echo -n "Esta é sua ÚLTIMA CHANCE. Não haverá volta. Confirme novamente (digite 'sim'): "
read confirmation2
echo -e "\033[0m"

if [ "${confirmation2,,}" != "sim" ]; then
  echo "Operação cancelada pelo usuário."
  exit 0
fi

echo ""
echo "Confirmado. Iniciando a purga completa do Docker..."
echo "-------------------------------------------------"

echo "Passo 1/5: Parando todos os contêineres..."
if [ -n "$(docker ps -a -q)" ]; then
   docker stop $(docker ps -a -q)
else
   echo "Nenhum contêiner para parar."
fi

echo "Passo 2/5: Removendo todos os contêineres..."
docker container prune -f

echo "Passo 3/5: Removendo todas as imagens..."
docker image prune -a -f

echo "Passo 4/5: Removendo todos os volumes (PERDA DE DADOS)..."
docker volume prune -f

echo "Passo 5/5: Removendo todas as redes..."
docker network prune -f

echo "-------------------------------------------------"
echo -e "\033[0;32m"
echo "Limpeza completa do Docker concluída com sucesso."
echo -e "\033[0m"