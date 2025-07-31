#!/bin/bash

# --- Alertas e Confirmações (Mantidos para segurança) ---
echo -e "\033[0;31m"
echo "======================================================================"
echo "==  AVISO MUITO IMPORTANTE: PERDA DE DADOS IRREVERSÍVEL             =="
echo "======================================================================"
echo "Este script irá apagar PERMANENTEMENTE:"
echo "  - TODOS os contêineres Docker"
echo "  - TODAS as imagens Docker"
echo "  - TODOS os volumes Docker (contendo bancos de dados, uploads, etc.)"
echo "  - TODAS as redes Docker customizadas"
echo ""
echo "Ele NÃO apaga dados em pastas locais que você tenha mapeado para"
echo "dentro de contêineres (bind mounts)."
echo "======================================================================"
echo -e "\033[0m"

echo -n "Você tem certeza ABSOLUTA de que deseja apagar TUDO? (digite 'sim' para continuar): "
read confirmation1

if [ "${confirmation1,,}" != "sim" ]; then
  echo "Operação cancelada."
  exit 0
fi

echo ""
echo -e "\033[0;93m"
echo -n "Esta é sua ÚLTIMA CHANCE. Confirme novamente (digite 'sim'): "
read confirmation2
echo -e "\033[0m"

if [ "${confirmation2,,}" != "sim" ]; then
  echo "Operação cancelada."
  exit 0
fi

echo ""
echo "Confirmado. Iniciando a purga completa do Docker..."
echo "-------------------------------------------------"

echo "Passo 1: Parando e Removendo todos os contêineres..."
if [ -n "$(docker ps -a -q)" ]; then
   docker rm -f $(docker ps -a -q)
else
   echo "Nenhum contêiner para remover."
fi

echo "Passo 2: Removendo todas as imagens..."
if [ -n "$(docker images -a -q)" ]; then
   docker rmi -f $(docker images -a -q)
else
   echo "Nenhuma imagem para remover."
fi

echo "Passo 3: Removendo todos os volumes (PERDA DE DADOS)..."
if [ -n "$(docker volume ls -q)" ]; then
   docker volume rm -f $(docker volume ls -q)
else
   echo "Nenhum volume para remover."
fi

echo "Passo 4: Removendo todas as redes..."
docker network prune -f

echo "-------------------------------------------------"
echo "Limpeza concluída. Verificando recursos restantes..."
echo "-------------------------------------------------"

echo "Contêineres restantes:"
docker ps -a
echo ""
echo "Imagens restantes:"
docker images -a
echo ""
echo "Volumes restantes:"
docker volume ls
echo ""
echo "Redes restantes:"
docker network ls

echo "-------------------------------------------------"
echo -e "\033[0;32mProcesso finalizado.\033[0m"