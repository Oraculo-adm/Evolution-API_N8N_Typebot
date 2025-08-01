#!/bin/bash
set -e

execute_sql() {
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
        $1
EOSQL
}

# --- Criação para N8N ---
if [ -n "${N8N_DB_USER:-}" ] && [ -n "${N8N_DB_PASSWORD:-}" ]; then
    echo "INFO: Criando banco de dados para N8N..."
    execute_sql "
        CREATE USER ${N8N_DB_USER} WITH PASSWORD '${N8N_DB_PASSWORD}';
        CREATE DATABASE ${N8N_DB_NAME};
        GRANT ALL PRIVILEGES ON DATABASE ${N8N_DB_NAME} TO ${N8N_DB_USER};
    "
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "${N8N_DB_NAME}" -c "GRANT CREATE ON SCHEMA public TO ${N8N_DB_USER};"
fi

# --- Criação para Chatwoot ---
if [ -n "${CHATWOOT_DB_USER:-}" ] && [ -n "${CHATWOOT_DB_PASSWORD:-}" ]; then
    echo "INFO: Criando banco de dados para Chatwoot..."
    execute_sql "
        CREATE USER ${CHATWOOT_DB_USER} WITH PASSWORD '${CHATWOOT_DB_PASSWORD}';
        CREATE DATABASE ${CHATWOOT_DB_NAME};
        GRANT ALL PRIVILEGES ON DATABASE ${CHATWOOT_DB_NAME} TO ${CHATWOOT_DB_USER};
    "
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "${CHATWOOT_DB_NAME}" -c "GRANT CREATE ON SCHEMA public TO ${CHATWOOT_DB_USER};"
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "${CHATWOOT_DB_NAME}" -c "CREATE EXTENSION IF NOT EXISTS pg_stat_statements;"
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "${CHATWOOT_DB_NAME}" -c "CREATE EXTENSION IF NOT EXISTS vector;"
fi

# --- Criação para Evolution API ---
if [ -n "${EVOLUTION_DB_USER:-}" ] && [ -n "${EVOLUTION_DB_PASSWORD:-}" ]; then
    echo "INFO: Criando banco de dados para Evolution API..."
    execute_sql "
        CREATE USER ${EVOLUTION_DB_USER} WITH PASSWORD '${EVOLUTION_DB_PASSWORD}';
        CREATE DATABASE ${EVOLUTION_DB_NAME};
        GRANT ALL PRIVILEGES ON DATABASE ${EVOLUTION_DB_NAME} TO ${EVOLUTION_DB_USER};
    "
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "${EVOLUTION_DB_NAME}" -c "GRANT CREATE ON SCHEMA public TO ${EVOLUTION_DB_USER};"
fi

# --- Criação para Typebot ---
if [ -n "${TYPEBOT_DB_USER:-}" ] && [ -n "${TYPEBOT_DB_PASSWORD:-}" ]; then
    echo "INFO: Criando banco de dados para Typebot..."
    execute_sql "
        CREATE USER ${TYPEBOT_DB_USER} WITH PASSWORD '${TYPEBOT_DB_PASSWORD}';
        CREATE DATABASE ${TYPEBOT_DB_NAME};
        GRANT ALL PRIVILEGES ON DATABASE ${TYPEBOT_DB_NAME} TO ${TYPEBOT_DB_USER};
    "
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "${TYPEBOT_DB_NAME}" -c "GRANT CREATE ON SCHEMA public TO ${TYPEBOT_DB_USER};"
fi

echo "Script de inicialização do banco de dados concluído."