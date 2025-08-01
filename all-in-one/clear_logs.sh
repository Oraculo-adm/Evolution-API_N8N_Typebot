#!/bin/bash

echo "Iniciando a limpeza dos logs de todos os contêineres ativos..."
echo "-------------------------------------------------"

for container_name in $(docker compose ps -q); do
  echo "Limpando logs do contêiner: $(docker ps --format '{{.Names}}' -f id=${container_name})"
  truncate -s 0 $(docker inspect --format='{{.LogPath}}' ${container_name})
done

echo "-------------------------------------------------"
echo -e "\033[0;32mLimpeza de logs concluída com sucesso.\033[0m"