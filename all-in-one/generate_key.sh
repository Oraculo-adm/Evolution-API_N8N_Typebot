#!/bin/bash
#
# Script para gerar e atualizar chaves de segurança de forma segura e flexível.
# Ele encontra as chaves pelo nome e substitui qualquer valor existente.
#

ENV_FILE="envs/databases.env"

if [ ! -f "$ENV_FILE" ]; then
  echo "❌ Erro: O arquivo '$ENV_FILE' não foi encontrado."
  echo "   Execute 'create-envs.sh' primeiro para criar os arquivos de ambiente."
  exit 1
fi

update_key() {
  local KEY_NAME=$1
  local NEW_VALUE=$2

  if grep -q "^${KEY_NAME}=" "$ENV_FILE"; then
    sed -i "s|^${KEY_NAME}=.*|${KEY_NAME}=${NEW_VALUE}|" "$ENV_FILE"
    echo "✅ Chave '${KEY_NAME}' foi atualizada com sucesso."
  else
    echo "⚠️ AVISO: Chave '${KEY_NAME}' não encontrada em '$ENV_FILE'. Nenhuma alteração foi feita."
  fi
}

echo "-------------------------------------------------"
echo "🔑 Chaves Geradas (apenas para visualização):"
NEW_REGKEY=$(openssl rand -hex 24)
echo "REGKEY:     $NEW_REGKEY"
NEW_MINIO_ACCESS_KEY=$(openssl rand -hex 8)
echo "MINIO_ACCESS_KEY:   $NEW_MINIO_ACCESS_KEY"
NEW_MINIO_SECRET_KEY=$(openssl rand -hex 12)
echo "MINIO_SECRET_KEY: $NEW_MINIO_SECRET_KEY"
echo "-------------------------------------------------"
echo "🔄 Gerando e atualizando novas chaves de segurança..."
echo "-------------------------------------------------"
update_key "REGKEY" "$NEW_REGKEY"
update_key "MINIO_ACCESS_KEY" "$NEW_MINIO_ACCESS_KEY"
update_key "MINIO_SECRET_KEY" "$NEW_MINIO_SECRET_KEY"
echo "-------------------------------------------------"
echo "✨ Processo concluído!"
echo "-------------------------------------------------"