CREATE TABLE item(
    id BIGSERIAL primary key,
    nome VARCHAR(150) NOT NULL,
    descrição INTEGER NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    valor DOUBLE NOT NULL
);