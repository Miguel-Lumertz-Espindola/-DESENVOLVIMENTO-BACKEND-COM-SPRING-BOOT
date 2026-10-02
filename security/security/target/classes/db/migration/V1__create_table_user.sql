CREATE TABLE users(
    id bigserial PRIMARY KEY,
    name varchar(250) not null,
    email varchar(250) not null,
    password varchar(250) not null
)