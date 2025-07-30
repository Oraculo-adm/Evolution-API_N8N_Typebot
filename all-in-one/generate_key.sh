#!/bin/bash
ENV_FILE="envs/databases.env"
PLACEHOLDER="your_random_string"
LINE_NUMBER=5

if [ ! -f "$ENV_FILE" ]; then
  echo "Erro: O arquivo '$ENV_FILE' não foi encontrado."
  echo "Execute 'create-envs.sh' primeiro para criar os arquivos de ambiente."
  exit 1
fi

NEW_KEY=$(openssl rand -hex 32)

echo "-------------------------------------------------"
echo "Sua nova chave de segurança gerada é:"
echo "$NEW_KEY"
echo "-------------------------------------------------"

if grep -q "$PLACEHOLDER" <<< "$(sed -n "${LINE_NUMBER}p" "$ENV_FILE")"; then
  sed -i "${LINE_NUMBER}s/${PLACEHOLDER}/${NEW_KEY}/" "$ENV_FILE"
  echo "A chave foi atualizada com sucesso no arquivo '$ENV_FILE' na linha ${LINE_NUMBER}."
else
  echo "AVISO: O texto '${PLACEHOLDER}' não foi encontrado na linha ${LINE_NUMBER} do arquivo '$ENV_FILE'."
  echo "Nenhuma alteração foi feita no arquivo."
fi