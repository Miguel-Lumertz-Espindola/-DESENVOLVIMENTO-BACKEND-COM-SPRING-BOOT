CREATE TABLE personagen(
    id BIGSERIAL primary key,
    nome VARCHAR(150) NOT NULL,
    nivel INTEGER NOT NULL,
    experiencia INTEGER NOT NULL,
    classe VARCHAR(50) NOT NULL,
);