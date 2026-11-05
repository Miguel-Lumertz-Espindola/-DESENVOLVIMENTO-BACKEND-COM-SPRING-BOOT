Sistema web para gerenciar jogadores, personagens, inventários, missões e conquistas. O projeto reúne uma interface em português e uma API REST com autenticação JWT, permissões de jogador e administrador e persistência em PostgreSQL.

O fluxo principal é: **criar uma conta → criar o perfil de jogador → cadastrar um personagem → preparar o inventário → concluir missões → acompanhar experiência e conquistas**.


<img width="1440" height="1085" alt="painel" src="https://github.com/user-attachments/assets/1b73fccb-3080-4baf-815e-b4957d36366e" />


## Acesso rápido

Com a aplicação em execução na porta padrão:

| Recurso | Endereço |
| --- | --- |
| Interface do sistema | [http://localhost:8080/](http://localhost:8080/) |
| Swagger: documentação e testes da API | [http://localhost:8080/swagger-ui/index.html](http://localhost:8080/swagger-ui/index.html) |
| Definição OpenAPI em JSON | [http://localhost:8080/v3/api-docs](http://localhost:8080/v3/api-docs) |

Se o sistema já está funcionando no seu computador, vá para [Como usar o sistema](#como-usar-o-sistema).

### Neste guia

- [Preparação e execução](#preparação-do-ambiente)
- [Como usar o sistema](#como-usar-o-sistema)
- [Como preparar um administrador](#como-preparar-um-administrador)
- [Uso da API pelo Swagger](#uso-da-api-pelo-swagger)
- [Testes](#testes)
- [Solução de problemas](#solução-de-problemas)

## Funcionalidades

- Cadastro e login de contas, com senhas protegidas por BCrypt.
- CRUD completo de jogadores, personagens, itens, missões e conquistas.
- Controle de acesso por perfil e pelo proprietário dos dados.
- Inventário por personagem, com capacidade e quantidade de itens.
- Início e conclusão de missões, com entrega de experiência uma única vez.
- Evolução automática do nível do personagem.
- Concessão e revogação de conquistas pela administração.
- Listagens paginadas, validação de formulários e mensagens de erro.
- Interface adaptada para computador e celular.
- Documentação da API com Swagger/OpenAPI e migrations com Flyway.

## Conta, jogador e personagem

Esses três cadastros possuem funções diferentes:

| Cadastro | O que representa | Tabela |
| --- | --- | --- |
| Conta | Nome, e-mail, senha e permissão de acesso (`JOGADOR` ou `ADMIN`) | `users` |
| Perfil de jogador | Perfil da pessoa dentro da guilda, vinculado à conta | `jogadores` |
| Personagem | Nome, classe, nível e experiência de um personagem do jogador | `personagens` |

Cada conta pode ter **um perfil de jogador**. Cada jogador pode ter **vários personagens**. A permissão de administrador pertence à conta e pode ser concedida mesmo sem um personagem cadastrado.

## Tecnologias

| Área | Tecnologias |
| --- | --- |
| Linguagem do backend | Java 21 |
| Framework | Spring Boot 4.1.1 |
| Persistência | Spring Data JPA / Hibernate e PostgreSQL |
| Segurança | Spring Security, JWT e BCrypt |
| Validação | Jakarta Bean Validation |
| Versionamento do banco | Flyway |
| Documentação da API | Springdoc OpenAPI / Swagger UI |
| Interface | HTML, CSS e JavaScript |
| Build | Maven Wrapper |
| Testes | JUnit, Spring Boot Test, MockMvc e PostgreSQL isolado |

O frontend é servido pelo próprio Spring Boot. Não é necessário instalar Node.js nem iniciar outro servidor para usar as telas.

## Preparação do ambiente

### 1. Pré-requisitos

- JDK **21** instalado.
- PostgreSQL instalado e em execução; as versões **12 a 17** atendem ao escopo do trabalho. Os testes registrados usam PostgreSQL 17.
- IntelliJ IDEA ou outra IDE com suporte a Java/Maven.
- Navegador com JavaScript habilitado.
- Git, caso o projeto seja obtido por clone do repositório.

O Maven Wrapper acompanha o projeto; na primeira execução, pode ser necessário acesso à internet para baixar o Maven e as dependências.

### 2. Localizar o módulo Maven

Na estrutura atual, o código da aplicação fica na pasta **`security`**, dentro da pasta principal do projeto. Ela contém o arquivo `pom.xml`.

**Execute os comandos deste guia na pasta que contém o `pom.xml`.** Se o repositório já foi publicado diretamente a partir do módulo, essa será a própria raiz do repositório.

### 3. Preparar o banco

Para uma instalação nova, crie um banco no PostgreSQL pelo pgAdmin ou por outra ferramenta SQL:

```sql
CREATE DATABASE seguranca;
```

Se esse banco já existe e é o usado pela aplicação, utilize-o sem executar novamente o comando de criação.

Os exemplos deste guia usam o banco **`seguranca`**, em `localhost:5432`. O nome efetivo do banco é definido na configuração de conexão; ele não precisa ser igual ao nome da pasta `security`.

Ao iniciar a aplicação, o **Flyway cria ou atualiza as tabelas** pelas migrations. O Hibernate valida o esquema com `ddl-auto=validate`.

### 4. Configurar conexão e chave JWT

Para desenvolvimento local, crie um arquivo chamado **`application-local.properties` ao lado do `pom.xml`**:

```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/seguranca
spring.datasource.username=postgres
spring.datasource.password=COLOQUE_SUA_SENHA_DO_POSTGRESQL
api.security.jwt.secret=COLE_A_CHAVE_ALEATORIA_GERADA_ABAIXO
```

Substitua o usuário e a senha pelos dados da sua instalação. Se utilizar outro banco, servidor ou porta, ajuste a URL.

Gere uma chave para o JWT no PowerShell:

```powershell
$jwtBytes = New-Object byte[] 48
[Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($jwtBytes)
[Convert]::ToBase64String($jwtBytes)
```

Copie o resultado para `api.security.jwt.secret`. A aplicação exige uma chave de pelo menos **32 bytes**. Essa chave é diferente da senha de login e da senha do PostgreSQL.

O arquivo local já está ignorado pelo `.gitignore`. Mantenha nele as configurações particulares de cada computador; publique somente o código e os exemplos sem credenciais reais.

Em um ambiente configurado por variáveis, a aplicação também aceita `DB_URL`, `DB_USERNAME`, `DB_PASSWORD` e `JWT_SECRET`. Essa alternativa dispensa o arquivo local. As variáveis precisam estar disponíveis no processo que inicia a aplicação; variáveis definidas em um terminal não são aplicadas automaticamente a uma configuração de execução do IntelliJ já aberto.

### 5. Executar pelo IntelliJ

1. Abra o `pom.xml` como projeto Maven ou abra a pasta que o contém.
2. Configure o SDK do projeto e a execução para **Java 21**.
3. Recarregue as dependências do Maven.
4. Confirme que o PostgreSQL está em execução e que a configuração do passo anterior está preenchida.
5. Abra `SecurityApplication.java` e execute seu método `main`.
6. Acesse [http://localhost:8080/](http://localhost:8080/).

### 6. Executar pelo PowerShell

Na pasta do `pom.xml`, ajuste o caminho do JDK:

```powershell
$env:JAVA_HOME = 'C:\CAMINHO\DO\JDK_21'
.\mvnw.cmd -DskipTests package
& "$env:JAVA_HOME\bin\java.exe" -jar .\target\security-0.0.1-SNAPSHOT.jar
```

O comando de empacotamento acima pula os testes de integração, que possuem configuração de banco separada. Consulte [Testes](#testes) para executá-los.

O nome do JAR permanece `security-0.0.1-SNAPSHOT.jar`, mesmo que a pasta principal tenha sido renomeada para `Avaliacao_2_V_final`.

## Como usar o sistema

### 1. Criar uma conta e entrar

1. Acesse a página inicial e clique em **Criar conta**.
2. Informe nome, e-mail e senha.
3. Use uma senha com pelo menos **8 caracteres**, respeitando o limite de **72 bytes**. Caracteres acentuados podem ocupar mais de um byte.
4. Depois do cadastro, entre com o mesmo e-mail e senha.

Toda conta criada pela interface ou por `POST /auth/register` recebe inicialmente a permissão **`JOGADOR`**. As contas usadas na interface e no Swagger são as mesmas contas da aplicação.

### 2. Criar o perfil de jogador

1. Entre na área **Jogadores**.
2. Clique em **Criar meu perfil**.
3. Informe o nome do jogador e salve.

O perfil fica vinculado à conta conectada. Uma conta que já possui perfil não pode criar um segundo. A tela também permite consultar, editar e excluir os registros acessíveis ao usuário.

### 3. Criar um personagem

1. Entre em **Personagens**.
2. Clique em **Cadastrar personagem**.
3. Informe o nome e a classe, por exemplo, `Artemis` e `Mago`.
4. Salve o cadastro.

O personagem começa com **nível 1**, **0 XP** e **inventário de 20 espaços**. Nível, experiência e proprietário são controlados pelo sistema. É necessário ter criado o perfil de jogador antes.

### 4. Usar o inventário

1. Abra **Inventário** e selecione um personagem.
2. Em **Adicionar ao inventário**, escolha um item do catálogo e a quantidade.
3. Use **Alterar quantidade** para definir a quantidade de um item já armazenado.
4. Use **Remover** para retirar todas as unidades daquele item do inventário.
5. Use **Alterar capacidade** para ajustar a quantidade de espaços.

Cada **item distinto** ocupa um espaço. Por exemplo, cinco espadas do mesmo item ocupam um espaço; uma espada e uma poção ocupam dois.

- Capacidade permitida: **1 a 500 espaços**.
- Quantidade por item: **1 a 1.000.000 de unidades**.
- A capacidade não pode ficar abaixo dos espaços já ocupados.
- Se o catálogo estiver vazio, um administrador precisa cadastrar os itens.

### 5. Iniciar e concluir missões

1. Abra **Minha jornada** e selecione um personagem.
2. Nas missões disponíveis, clique em **Iniciar missão**.
3. Quando desejar concluir a missão, clique em **Concluir missão** e confirme.
4. Confira a experiência e o nível atualizados.

A recompensa é fixada quando a missão é iniciada. Cada missão entrega XP **uma única vez por personagem**. Uma missão concluída não pode ser reiniciada para repetir a recompensa.

O nível segue a regra:

```text
nivel = 1 + parte inteira de (experiencia / 100)
```

Exemplo: ao concluir uma missão de **150 XP**, um personagem que estava com 0 XP passa para **nível 2 e 150 XP**.

### 6. Consultar conquistas

Na área **Conquistas**, o usuário consulta o catálogo. Em **Conquistas recebidas**, consulta os reconhecimentos concedidos ao seu perfil de jogador.

As conquistas são concedidas pela administração. Um jogador pode receber cada conquista uma vez; o administrador pode revogar a concessão.

### 7. Editar, excluir e sair

Nas listagens, **Ver** abre os detalhes, **Editar** altera os campos permitidos e **Excluir** solicita confirmação. O filtro de texto atua somente nos registros da página atual; use **Anterior** e **Próxima** para navegar pelas outras páginas.

A exclusão de um personagem também remove seu inventário e progresso de missões. A exclusão de um perfil de jogador remove seus personagens e dependências do jogo, preservando a conta de login. Itens, missões e conquistas do catálogo com vínculos existentes têm a exclusão recusada até que os vínculos sejam removidos.

Para encerrar o acesso, clique em **Sair**. A interface mantém o JWT no `sessionStorage` da aba, não persiste a senha e retorna ao login quando uma chamada identifica sessão inválida ou expirada. A duração padrão do token é de **uma hora**.

## Como preparar um administrador

Esta configuração é feita pelo responsável pelo banco. A interface não permite que uma conta promova a si mesma.

1. Crie a conta normalmente e anote o e-mail.
2. No pgAdmin, abra a **Ferramenta de consulta / Query Tool** no mesmo banco configurado na aplicação; nos exemplos, `seguranca`.
3. Confira o banco e localize a conta:

```sql
SELECT current_database();

SELECT id, name, email, role
FROM public.users
ORDER BY id;
```

4. Promova somente a conta desejada, substituindo o e-mail do exemplo:

```sql
UPDATE public.users
SET role = 'ADMIN'
WHERE lower(email) = lower('admin@example.com')
RETURNING id, name, email, role;
```

5. Confirme que a linha retornada corresponde à conta e mostra `ADMIN`.
6. Na interface, clique em **Sair** e entre novamente para atualizar os controles exibidos.

Se o comando não retornar uma linha, verifique o e-mail e a conexão com o banco. A permissão está em `users`, não na tabela `personagens`.

### Permissões por perfil

| Operação | JOGADOR | ADMIN |
| --- | --- | --- |
| Criar perfil e personagens | Na própria conta | Na própria conta |
| Consultar, editar e excluir jogadores/personagens | Somente os próprios | Todos |
| Consultar catálogos de itens, missões e conquistas | Sim | Sim |
| Criar, editar e excluir registros dos catálogos | Não | Sim |
| Usar inventário e iniciar/concluir missões | Dos próprios personagens | De todos os personagens |
| Consultar conquistas recebidas | Do próprio jogador | De todos os jogadores |
| Conceder e revogar conquistas | Não | Sim |

O servidor verifica essas permissões em cada operação, independentemente dos botões apresentados na interface.

## Roteiro de demonstração

O projeto não cria contas nem dados de demonstração automaticamente. Para uma demonstração local, cadastre duas contas com estes dados de exemplo:

| Conta de exemplo | E-mail | Senha de exemplo | Preparação |
| --- | --- | --- | --- |
| Administrador Demo | `admin@example.com` | `SenhaDemo123!` | Promover a `ADMIN` pelo procedimento anterior |
| Jogador Demo | `jogador@example.com` | `SenhaDemo123!` | Manter como `JOGADOR` |

Essas credenciais são exemplos para dados de demonstração; só funcionarão depois de você criar as contas correspondentes.

1. Como administrador, cadastre um item, uma missão de 150 XP e uma conquista.
2. Saia e entre como jogador.
3. Crie o perfil e um personagem.
4. Adicione o item ao inventário e altere sua quantidade.
5. Inicie e conclua a missão; mostre o nível e o XP atualizados.
6. Como administrador, selecione o jogador em **Conquistas recebidas** e conceda a conquista.
7. Como jogador, consulte a conquista recebida.
8. Para demonstrar exclusões, crie registros temporários e utilize os botões de exclusão.

## Uso da API pelo Swagger

1. Abra o [Swagger local](http://localhost:8080/swagger-ui/index.html) com a aplicação em execução.
2. Em `POST /auth/login`, clique em **Try it out**, informe e-mail e senha e clique em **Execute**.
3. Copie o valor de `token` da resposta, sem as aspas.
4. Clique em **Authorize** e cole **somente o token**, sem escrever `Bearer` nesse campo.
5. Execute as operações permitidas para a conta.

Em clientes HTTP próprios, envie o cabeçalho `Authorization: Bearer SEU_TOKEN`. O Swagger local usa as contas cadastradas nesta aplicação; uma conta no serviço online Swagger Catalog não cadastra um usuário no GuildaQuest.

### Exemplos de requisições e respostas

**Cadastro de conta — `POST /auth/register`:**

```json
{
  "name": "Jogador Demo",
  "email": "jogador@example.com",
  "password": "SenhaDemo123!"
}
```

Resposta `201 Created`:

```json
{
  "name": "Jogador Demo",
  "email": "jogador@example.com"
}
```

**Login — `POST /auth/login`:**

```json
{
  "email": "jogador@example.com",
  "password": "SenhaDemo123!"
}
```

Resposta `200 OK`:

```json
{
  "token": "JWT_GERADO_PELA_API"
}
```

**Criar perfil — `POST /jogadores`, com token:**

```json
{
  "nome": "Jogador Demo"
}
```

Resposta `201 Created` (IDs ilustrativos):

```json
{
  "id": 1,
  "userId": 2,
  "nome": "Jogador Demo"
}
```

**Criar personagem — `POST /personagens`, com token:**

```json
{
  "nome": "Artemis",
  "classe": "Mago"
}
```

Resposta `201 Created` (IDs ilustrativos):

```json
{
  "id": 1,
  "jogadorId": 1,
  "nome": "Artemis",
  "classe": "Mago",
  "nivel": 1,
  "experiencia": 0
}
```

### Recursos principais

Cada recurso possui `POST` para criar e `GET` para listar na coleção; em `/{id}`, possui `GET` para consultar, `PUT` para atualizar e `DELETE` para excluir.

| Recurso | Campos de criação/edição |
| --- | --- |
| `/jogadores` | `nome` |
| `/personagens` | `nome`, `classe` |
| `/itens` | `nome`, `descricao`, `tipo`, `valor` |
| `/missoes` | `nome`, `descricao`, `recompensaXp` |
| `/conquistas` | `nome`, `descricao` |

Os catálogos exigem `ADMIN` para escrita. As listagens da API aceitam `?page=0&size=20`, com limite de 100 por página, e retornam `conteudo`, `pagina`, `tamanho`, `totalElementos` e `totalPaginas`. A interface utiliza dez registros por página.

### Inventário e progresso

| Método | Rota | Ação / corpo quando necessário |
| --- | --- | --- |
| `GET` | `/auth/me` | Consultar a conta conectada e seu perfil de acesso |
| `GET` | `/personagens/{id}/inventario` | Consultar inventário |
| `PUT` | `/personagens/{id}/inventario` | Alterar capacidade: `{"capacidade":30}` |
| `POST` | `/personagens/{id}/inventario/itens` | Adicionar/somar unidades: `{"itemId":1,"quantidade":2}` |
| `PUT` | `/personagens/{id}/inventario/itens/{itemId}` | Definir quantidade: `{"quantidade":5}` |
| `DELETE` | `/personagens/{id}/inventario/itens/{itemId}` | Remover item do inventário |
| `GET` | `/personagens/{id}/missoes` | Consultar progresso |
| `POST` | `/personagens/{id}/missoes/{missaoId}` | Iniciar missão |
| `PATCH` | `/personagens/{id}/missoes/{missaoId}/concluir` | Concluir missão e entregar XP |
| `GET` | `/jogadores/{id}/conquistas` | Consultar conquistas recebidas |
| `POST` | `/jogadores/{id}/conquistas/{conquistaId}` | Conceder conquista (`ADMIN`) |
| `DELETE` | `/jogadores/{id}/conquistas/{conquistaId}` | Revogar conquista (`ADMIN`) |

### Respostas e erros

| Status HTTP | Significado |
| --- | --- |
| `200` | Consulta ou atualização concluída; também utilizado ao adicionar item ao inventário |
| `201` | Registro, início de missão ou concessão de conquista criado |
| `204` | Exclusão concluída, sem corpo de resposta |
| `400` | Campos ou formato da requisição inválidos |
| `401` | Login inválido ou token ausente, inválido ou expirado |
| `403` | Conta sem permissão para a ação ou para o recurso |
| `404` | Recurso não encontrado |
| `409` | Conflito: duplicidade, capacidade excedida, vínculo existente ou regra de negócio |

Os erros seguem um formato centralizado com `timestamp`, `status`, `message`, `path` e `fieldErrors`. As respostas não expõem senhas nem entidades JPA diretamente.

## Estrutura do projeto

O conteúdo abaixo está dentro do módulo que contém o `pom.xml`:

```text
security/
├── pom.xml
├── mvnw / mvnw.cmd
├── .mvn/wrapper/
├── README.md
├── docs/
├── scripts/
│   └── test.ps1
└── src/
    ├── main/
    │   ├── java/com/example/security/
    │   │   ├── config/           # Segurança, JWT e OpenAPI
    │   │   ├── controller/       # Endpoints HTTP
    │   │   ├── service/          # Regras de negócio e transações
    │   │   ├── repository/       # Persistência e consultas
    │   │   ├── entity/           # Entidades e relacionamentos
    │   │   ├── dto/              # Contratos de entrada e saída
    │   │   ├── validation/       # Validações compartilhadas
    │   │   ├── exception/        # Tratamento centralizado de erros
    │   │   └── doc/              # Interfaces de documentação
    │   └── resources/
    │       ├── application.properties
    │       ├── db/migration/     # Versionamento do banco
    │       └── static/           # Interface HTML, CSS e JavaScript
    └── test/                     # Testes de integração
```

Para editar as telas no IntelliJ, abra `src/main/resources/static`. Após alterações, reinicie a aplicação e atualize o navegador com `Ctrl + F5`. A interface precisa ser aberta pelo endereço do servidor, não por duplo clique no HTML.

## Banco e relacionamentos

As tabelas ativas são `users`, `jogadores`, `personagens`, `inventarios`, `itens`, `itens_inventario`, `missoes`, `personagens_missoes`, `conquistas` e `jogadores_conquistas`.

- Conta → zero ou um perfil de jogador.
- Jogador → vários personagens.
- Personagem → um inventário criado automaticamente pela aplicação.
- Inventário ↔ itens, pela associação `itens_inventario`, que registra a quantidade.
- Personagem ↔ missões, pela associação `personagens_missoes`, que registra status, datas e recompensa.
- Jogador ↔ conquistas, pela associação `jogadores_conquistas`, que registra a data de obtenção.

As migrations V1 a V10 foram preservadas. A V11 mantém as tabelas antigas do jogo com o sufixo `_legado` e cria o modelo relacional corrigido. As tabelas `_legado` não são utilizadas pelas telas atuais; os dados antigos do jogo não são transferidos automaticamente porque o modelo anterior não registrava os vínculos necessários. As contas existentes em `users` são preservadas.

Alterações posteriores no banco devem ser feitas por novas migrations. As migrations antigas já aplicadas não devem ser editadas.

## Testes

Os testes de integração utilizam PostgreSQL real em um banco separado, com nome terminado em `_tests`.

No Windows, com Java 21 configurado e PostgreSQL instalado, execute na pasta do `pom.xml`:

```powershell
.\scripts\test.ps1 -PgBin 'C:\Program Files\PostgreSQL\17\bin'
```

O script prepara um cluster temporário dentro de `target`, executa os testes e encerra o cluster. Para uma instalação em outro caminho, ajuste `-PgBin`.

Também é possível usar um banco exclusivo de testes já preparado:

```powershell
$env:TEST_DB_URL = 'jdbc:postgresql://localhost:55439/security_tests'
$env:TEST_DB_USERNAME = 'security_test'
$env:TEST_DB_PASSWORD = 'SENHA_DO_BANCO_DE_TESTES'
.\mvnw.cmd test
```

Use somente um banco de testes nesse procedimento: a suíte limpa os dados entre os cenários.

Na verificação registrada em **04/11/2026**, passaram **21 testes de integração do backend** e **22 cenários no navegador**, em ambiente isolado. Os cenários incluem CRUDs, permissões, inventário, missões, XP, conquistas, expiração de sessão e comportamento em celular. Esses números correspondem à execução registrada, não a uma execução automática ao abrir o repositório.

## Solução de problemas

| Situação | O que conferir |
| --- | --- |
| Não encontro minha conta no PostgreSQL | Consulte `users` no mesmo banco e servidor da configuração; nos exemplos, `seguranca`, em `localhost:5432` |
| Não encontro meu personagem | Consulte `personagens`; o perfil está em `jogadores` e a conta em `users`. Tabelas `_legado` pertencem ao modelo anterior |
| Ainda apareço como jogador depois do SQL | Confira se o `UPDATE` retornou sua conta com `ADMIN`, saia da interface e entre novamente |
| Não consigo criar personagem | Crie primeiro seu perfil em Jogadores |
| Catálogo sem itens ou missões | Peça a um administrador para cadastrar os registros |
| Erro `JWT_SECRET` ou chave muito curta | Configure o segredo pelo arquivo local ou pelas variáveis da execução; utilize ao menos 32 bytes |
| Erro de conexão com o banco | Confira serviço PostgreSQL, URL, nome do banco, porta, usuário e senha |
| Porta 8080 ocupada | Encerre outra execução da aplicação ou configure outra porta e ajuste o endereço no navegador |
| Wrapper informa falta de `maven-wrapper.properties` | Confira se a pasta oculta `.mvn` foi incluída na cópia ou no repositório |
| Erro de versão do Java | Confira JDK 21 no projeto, na execução da IDE e em `JAVA_HOME` no terminal |
| `401` em uma operação autenticada | Faça login novamente e atualize o token no cliente HTTP |
| `403` ao alterar catálogo | Utilize uma conta com permissão `ADMIN` |
| `409` ao excluir um catálogo | O registro possui vínculos; remova os vínculos antes de excluir |

## Documentação complementar

- [Guia das telas e roteiro de demonstração](security/docs/FRONTEND.md)
- [Descrição da implementação](security/docs/IMPLEMENTACAO.md)
- [Relacionamentos e regras do modelo](security/docs/RELACIONAMENTOS.md)
- [Resultado registrado dos testes do backend](security/docs/RESULTADO-TESTES.json)
- [Resultado registrado dos testes da interface](security/docs/RESULTADO-FRONTEND.json)
