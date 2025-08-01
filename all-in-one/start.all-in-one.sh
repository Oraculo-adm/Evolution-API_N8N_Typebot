#!/bin/bash
echo "INFO: Verificando arquivos de ambiente..."
if [ ! -f "envs/databases.env" ]; then
  echo "AVISO: Arquivo 'databases.env' não encontrado. Executando script de criação..."
  ./create-envs.sh
  echo "-------------------------------------------------"
fi

echo "INFO: Verificando a chave de segurança (REGKEY)..."
if grep -q "your_random_string" "envs/databases.env"; then
  echo "AVISO: Chave de segurança padrão encontrada. Gerando uma nova chave..."
  ./generate_key.sh
  echo "-------------------------------------------------"
else
  echo "INFO: Chave de segurança personalizada já está definida."
fi

echo ""
echo "Tudo pronto. Iniciando os contêineres..."
echo "-------------------------------------------------"

docker compose --env-file ./envs/databases.env up -d

echo ""
echo "-------------------------------------------------"
echo -e "\033[0;32mComando de inicialização enviado. Os contêineres estão subindo em segundo plano.\033[0m"
echo "Use 'docker compose ps' para ver o status e 'docker compose logs -f' para acompanhar os logs."