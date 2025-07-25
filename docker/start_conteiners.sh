#!/bin/bash
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
clear
echo -e "${YELLOW}=====================================================${NC}"
echo -e "${YELLOW}Iniciando todos os serviços Docker...${NC}"
echo -e "${YELLOW}=====================================================${NC}"
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

# Inicia o n8n
echo -e "\n${GREEN}--> Iniciando o ambiente n8n...${NC}"
cd "$BASE_DIR/n8n"
docker compose up -d

# Inicia a Evolution API
echo -e "\n${GREEN}--> Iniciando o ambiente Evolution API...${NC}"
cd "$BASE_DIR/evolution-api"
docker compose up -d

# Inicia o Typebot
echo -e "\n${GREEN}--> Iniciando o ambiente Typebot...${NC}"
cd "$BASE_DIR/typebot"
docker compose up -d

echo -e "\n${YELLOW}=====================================================${NC}"
echo -e "${YELLOW}Script finalizado! Os contêineres foram iniciados.${NC}"
echo -e "Use o comando ${GREEN}'docker ps'${NC} para verificar o status."
echo -e "${YELLOW}=====================================================${NC}"
