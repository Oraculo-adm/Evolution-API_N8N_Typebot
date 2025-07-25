# Projeto de Automação com n8n, Evolution API e Typebot

Este projeto implanta um ambiente de automação completo utilizando Docker. Ele é composto por três serviços principais, cada um em seu próprio ambiente isolado:

1.  **n8n**: Uma poderosa ferramenta de automação de fluxos de trabalho (workflow automation) que funciona como o "cérebro" das operações.
2.  **Evolution API**: Uma API para integração com o WhatsApp, servindo como a "ponte de comunicação".
3.  **Typebot**: Uma ferramenta para a criação de fluxos de conversa (chatbots) de forma visual.

## ⚙️ Pré-requisitos

Para executar este projeto, você precisa ter instalado na sua máquina:
* [Docker](https://www.docker.com/)
* [Docker Compose V2](https://docs.docker.com/compose/)

## 🛠️ Configuração Inicial

Antes de iniciar os serviços pela primeira vez, é necessário configurar os arquivos de ambiente (`.env`) em cada subdiretório. Para cada serviço, siga os passos:

1.  Navegue até o diretório do serviço (ex: `cd n8n/`).
2.  Copie o arquivo de exemplo para um novo arquivo `.env`.
3.  Edite o arquivo `.env` com suas senhas, chaves de API e outras configurações sensíveis.

### Configuração do conteiners

```bash
# Copie o arquivo de exemplo contido nas pastas
cp .env.example .env

# Edite o arquivo com suas credenciais
nano .env
```

## ▶️ Como Usar

Scripts foram criados na raiz do projeto para facilitar o gerenciamento de todos os serviços de uma só vez.

Para Iniciar Todos os Serviços
Execute o script start_all.sh. Ele navegará para cada diretório e iniciará os contêineres em segundo plano.

```bash
# Acesse o diretorio da raiz do repositorio.
./docker/start_all.sh
```


### 🔗 Acesso aos Serviços
Após iniciar os contêineres, os serviços estarão acessíveis nos seguintes endereços (substitua <IP_DO_SERVIDOR> pelo IP do seu servidor):

Evolution API (Documentação):
http://<IP_DO_SERVIDOR>:4000/docs

n8n (Interface de Workflows):
http://<IP_DO_SERVIDOR>:4001

Typebot (Construtor de Chatbots):
http://<IP_DO_SERVIDOR>:4002