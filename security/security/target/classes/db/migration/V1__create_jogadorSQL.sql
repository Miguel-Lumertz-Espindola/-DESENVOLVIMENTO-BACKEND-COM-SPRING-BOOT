CREATE TABLE jogador(
    id BIGSERIAL primary key,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL,
    senha VARCHAR(20) NOT NULL
);

