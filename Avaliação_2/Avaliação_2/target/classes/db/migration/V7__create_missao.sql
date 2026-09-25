CREATE TABLE missao(
    id BIGSERIAL primary key,
    nome VARCHAR(150) NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    recompensa VARCHAR(100) NOT NULL
);