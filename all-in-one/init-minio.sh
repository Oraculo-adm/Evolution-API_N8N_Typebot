#!/bin/sh
set -e
sleep 5
mc alias set local http://minio:9000 ${MINIO_ROOT_USER} ${MINIO_ROOT_PASSWORD}
for bucket in $(echo ${MINIO_BUCKETS} | tr ',' ' '); do
  # Verifica se o bucket já existe
  if ! mc ls local/${bucket} > /dev/null 2>&1; then
    echo "INFO: Criando bucket '${bucket}'..."
    mc mb local/${bucket}
  else
    echo "AVISO: Bucket '${bucket}' já existe, pulando a criação."
  fi
done

echo "Script de inicialização do Minio concluído."