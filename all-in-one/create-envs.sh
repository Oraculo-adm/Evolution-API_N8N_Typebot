#!/bin/bash
ENV_DIR="envs"
if [ ! -d "$ENV_DIR" ]; then
  echo "Erro: O diretório '$ENV_DIR' não foi encontrado."
  echo "Por favor, crie a pasta 'envs' e coloque seus arquivos .env.example dentro dela."
  exit 1
fi

echo "Iniciando a preparação dos arquivos de ambiente..."
echo "-------------------------------------------------"

for example_file in "$ENV_DIR"/*.env.example; do

  if [ ! -f "$example_file" ]; then
      echo "Nenhum arquivo .env.example encontrado em '$ENV_DIR'."
      break
  fi

  env_file="${example_file%.example}"

  if [ -f "$env_file" ]; then
    echo "AVISO: O arquivo '$env_file' já existe. Pulando."
  else
    cp "$example_file" "$env_file"
    echo "CRIADO: '$env_file'"
  fi
done

echo "-------------------------------------------------"
echo "Processo concluído."
echo "-------------------------------------------------"