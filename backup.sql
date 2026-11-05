--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

-- Started on 2026-11-05 16:33:57

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 235 (class 1259 OID 27235)
-- Name: conquista_legado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conquista_legado (
    id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    descricao character varying(150) NOT NULL
);


ALTER TABLE public.conquista_legado OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 27234)
-- Name: conquista_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conquista_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conquista_id_seq OWNER TO postgres;

--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 234
-- Name: conquista_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conquista_id_seq OWNED BY public.conquista_legado.id;


--
-- TOC entry 253 (class 1259 OID 27423)
-- Name: conquistas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conquistas (
    id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    descricao character varying(1000) NOT NULL,
    CONSTRAINT conquistas_descricao_check CHECK ((length(btrim((descricao)::text)) > 0)),
    CONSTRAINT conquistas_nome_check CHECK ((length(btrim((nome)::text)) > 0))
);


ALTER TABLE public.conquistas OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 27422)
-- Name: conquistas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conquistas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conquistas_id_seq OWNER TO postgres;

--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 252
-- Name: conquistas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conquistas_id_seq OWNED BY public.conquistas.id;


--
-- TOC entry 217 (class 1259 OID 27167)
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 27191)
-- Name: inventario_legado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventario_legado (
    id bigint NOT NULL,
    capacidade integer
);


ALTER TABLE public.inventario_legado OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 27190)
-- Name: inventario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventario_id_seq OWNER TO postgres;

--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 222
-- Name: inventario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inventario_id_seq OWNED BY public.inventario_legado.id;


--
-- TOC entry 243 (class 1259 OID 27338)
-- Name: inventarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventarios (
    id bigint NOT NULL,
    personagem_id bigint NOT NULL,
    capacidade integer DEFAULT 20 NOT NULL,
    CONSTRAINT inventarios_capacidade_check CHECK (((capacidade >= 1) AND (capacidade <= 500)))
);


ALTER TABLE public.inventarios OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 27337)
-- Name: inventarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventarios_id_seq OWNER TO postgres;

--
-- TOC entry 5092 (class 0 OID 0)
-- Dependencies: 242
-- Name: inventarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inventarios_id_seq OWNED BY public.inventarios.id;


--
-- TOC entry 227 (class 1259 OID 27205)
-- Name: item_legado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_legado (
    id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    "descrição" integer NOT NULL,
    tipo character varying(50) NOT NULL,
    valor numeric NOT NULL
);


ALTER TABLE public.item_legado OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 27204)
-- Name: item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.item_id_seq OWNER TO postgres;

--
-- TOC entry 5093 (class 0 OID 0)
-- Dependencies: 226
-- Name: item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.item_id_seq OWNED BY public.item_legado.id;


--
-- TOC entry 225 (class 1259 OID 27198)
-- Name: iteminventario_legado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.iteminventario_legado (
    id bigint NOT NULL,
    quantidade integer
);


ALTER TABLE public.iteminventario_legado OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 27197)
-- Name: iteminventario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.iteminventario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.iteminventario_id_seq OWNER TO postgres;

--
-- TOC entry 5094 (class 0 OID 0)
-- Dependencies: 224
-- Name: iteminventario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.iteminventario_id_seq OWNED BY public.iteminventario_legado.id;


--
-- TOC entry 245 (class 1259 OID 27354)
-- Name: itens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.itens (
    id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    descricao character varying(1000) NOT NULL,
    tipo character varying(50) NOT NULL,
    valor numeric(12,2) NOT NULL,
    CONSTRAINT itens_descricao_check CHECK ((length(btrim((descricao)::text)) > 0)),
    CONSTRAINT itens_nome_check CHECK ((length(btrim((nome)::text)) > 0)),
    CONSTRAINT itens_tipo_check CHECK ((length(btrim((tipo)::text)) > 0)),
    CONSTRAINT itens_valor_check CHECK ((valor >= (0)::numeric))
);


ALTER TABLE public.itens OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 27353)
-- Name: itens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.itens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.itens_id_seq OWNER TO postgres;

--
-- TOC entry 5095 (class 0 OID 0)
-- Dependencies: 244
-- Name: itens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.itens_id_seq OWNED BY public.itens.id;


--
-- TOC entry 247 (class 1259 OID 27367)
-- Name: itens_inventario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.itens_inventario (
    id bigint NOT NULL,
    inventario_id bigint NOT NULL,
    item_id bigint NOT NULL,
    quantidade integer NOT NULL,
    CONSTRAINT itens_inventario_quantidade_check CHECK (((quantidade >= 1) AND (quantidade <= 1000000)))
);


ALTER TABLE public.itens_inventario OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 27366)
-- Name: itens_inventario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.itens_inventario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.itens_inventario_id_seq OWNER TO postgres;

--
-- TOC entry 5096 (class 0 OID 0)
-- Dependencies: 246
-- Name: itens_inventario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.itens_inventario_id_seq OWNED BY public.itens_inventario.id;


--
-- TOC entry 219 (class 1259 OID 27177)
-- Name: jogador_legado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jogador_legado (
    id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    senha character varying(20) NOT NULL
);


ALTER TABLE public.jogador_legado OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 27176)
-- Name: jogador_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jogador_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jogador_id_seq OWNER TO postgres;

--
-- TOC entry 5097 (class 0 OID 0)
-- Dependencies: 218
-- Name: jogador_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jogador_id_seq OWNED BY public.jogador_legado.id;


--
-- TOC entry 233 (class 1259 OID 27228)
-- Name: jogadorconquista_legado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jogadorconquista_legado (
    id bigint NOT NULL,
    dataobtencao date NOT NULL
);


ALTER TABLE public.jogadorconquista_legado OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 27227)
-- Name: jogadorconquista_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jogadorconquista_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jogadorconquista_id_seq OWNER TO postgres;

--
-- TOC entry 5098 (class 0 OID 0)
-- Dependencies: 232
-- Name: jogadorconquista_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jogadorconquista_id_seq OWNED BY public.jogadorconquista_legado.id;


--
-- TOC entry 239 (class 1259 OID 27303)
-- Name: jogadores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jogadores (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    CONSTRAINT jogadores_nome_check CHECK ((length(btrim((nome)::text)) > 0))
);


ALTER TABLE public.jogadores OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 27434)
-- Name: jogadores_conquistas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jogadores_conquistas (
    id bigint NOT NULL,
    jogador_id bigint NOT NULL,
    conquista_id bigint NOT NULL,
    data_obtencao date NOT NULL
);


ALTER TABLE public.jogadores_conquistas OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 27433)
-- Name: jogadores_conquistas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jogadores_conquistas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jogadores_conquistas_id_seq OWNER TO postgres;

--
-- TOC entry 5099 (class 0 OID 0)
-- Dependencies: 254
-- Name: jogadores_conquistas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jogadores_conquistas_id_seq OWNED BY public.jogadores_conquistas.id;


--
-- TOC entry 238 (class 1259 OID 27302)
-- Name: jogadores_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jogadores_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jogadores_id_seq OWNER TO postgres;

--
-- TOC entry 5100 (class 0 OID 0)
-- Dependencies: 238
-- Name: jogadores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jogadores_id_seq OWNED BY public.jogadores.id;


--
-- TOC entry 231 (class 1259 OID 27221)
-- Name: missao_legado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.missao_legado (
    id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    descricao character varying(50) NOT NULL,
    recompensa character varying(100) NOT NULL
);


ALTER TABLE public.missao_legado OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 27220)
-- Name: missao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.missao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.missao_id_seq OWNER TO postgres;

--
-- TOC entry 5101 (class 0 OID 0)
-- Dependencies: 230
-- Name: missao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.missao_id_seq OWNED BY public.missao_legado.id;


--
-- TOC entry 249 (class 1259 OID 27388)
-- Name: missoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.missoes (
    id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    descricao character varying(1000) NOT NULL,
    recompensa_xp bigint NOT NULL,
    CONSTRAINT missoes_descricao_check CHECK ((length(btrim((descricao)::text)) > 0)),
    CONSTRAINT missoes_nome_check CHECK ((length(btrim((nome)::text)) > 0)),
    CONSTRAINT missoes_recompensa_xp_check CHECK (((recompensa_xp >= 0) AND (recompensa_xp <= 1000000)))
);


ALTER TABLE public.missoes OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 27387)
-- Name: missoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.missoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.missoes_id_seq OWNER TO postgres;

--
-- TOC entry 5102 (class 0 OID 0)
-- Dependencies: 248
-- Name: missoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.missoes_id_seq OWNED BY public.missoes.id;


--
-- TOC entry 229 (class 1259 OID 27214)
-- Name: personagemmissao_legado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personagemmissao_legado (
    id bigint NOT NULL,
    status character varying(30) NOT NULL,
    datainicio date NOT NULL,
    datacomclusao date NOT NULL
);


ALTER TABLE public.personagemmissao_legado OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 27213)
-- Name: personagemmissao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personagemmissao_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personagemmissao_id_seq OWNER TO postgres;

--
-- TOC entry 5103 (class 0 OID 0)
-- Dependencies: 228
-- Name: personagemmissao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personagemmissao_id_seq OWNED BY public.personagemmissao_legado.id;


--
-- TOC entry 221 (class 1259 OID 27184)
-- Name: personagen_legado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personagen_legado (
    id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    nivel integer NOT NULL,
    experiencia integer NOT NULL,
    classe character varying(50) NOT NULL
);


ALTER TABLE public.personagen_legado OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 27183)
-- Name: personagen_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personagen_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personagen_id_seq OWNER TO postgres;

--
-- TOC entry 5104 (class 0 OID 0)
-- Dependencies: 220
-- Name: personagen_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personagen_id_seq OWNED BY public.personagen_legado.id;


--
-- TOC entry 241 (class 1259 OID 27318)
-- Name: personagens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personagens (
    id bigint NOT NULL,
    jogador_id bigint NOT NULL,
    nome character varying(150) NOT NULL,
    classe character varying(50) NOT NULL,
    nivel integer DEFAULT 1 NOT NULL,
    experiencia bigint DEFAULT 0 NOT NULL,
    CONSTRAINT ck_personagem_nivel CHECK ((nivel = (1 + (experiencia / 100)))),
    CONSTRAINT personagens_classe_check CHECK ((length(btrim((classe)::text)) > 0)),
    CONSTRAINT personagens_experiencia_check CHECK (((experiencia >= 0) AND (experiencia <= 1000000000))),
    CONSTRAINT personagens_nivel_check CHECK ((nivel > 0)),
    CONSTRAINT personagens_nome_check CHECK ((length(btrim((nome)::text)) > 0))
);


ALTER TABLE public.personagens OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 27317)
-- Name: personagens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personagens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personagens_id_seq OWNER TO postgres;

--
-- TOC entry 5105 (class 0 OID 0)
-- Dependencies: 240
-- Name: personagens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personagens_id_seq OWNED BY public.personagens.id;


--
-- TOC entry 251 (class 1259 OID 27400)
-- Name: personagens_missoes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personagens_missoes (
    id bigint NOT NULL,
    personagem_id bigint NOT NULL,
    missao_id bigint NOT NULL,
    status character varying(30) NOT NULL,
    data_inicio date NOT NULL,
    data_conclusao date,
    recompensa_xp bigint NOT NULL,
    CONSTRAINT ck_missao_datas CHECK (((((status)::text = 'EM_ANDAMENTO'::text) AND (data_conclusao IS NULL)) OR (((status)::text = 'CONCLUIDA'::text) AND (data_conclusao IS NOT NULL) AND (data_conclusao >= data_inicio)))),
    CONSTRAINT personagens_missoes_recompensa_xp_check CHECK (((recompensa_xp >= 0) AND (recompensa_xp <= 1000000))),
    CONSTRAINT personagens_missoes_status_check CHECK (((status)::text = ANY ((ARRAY['EM_ANDAMENTO'::character varying, 'CONCLUIDA'::character varying])::text[])))
);


ALTER TABLE public.personagens_missoes OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 27399)
-- Name: personagens_missoes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personagens_missoes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personagens_missoes_id_seq OWNER TO postgres;

--
-- TOC entry 5106 (class 0 OID 0)
-- Dependencies: 250
-- Name: personagens_missoes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personagens_missoes_id_seq OWNED BY public.personagens_missoes.id;


--
-- TOC entry 237 (class 1259 OID 27242)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(250) NOT NULL,
    email character varying(250) NOT NULL,
    password character varying(250) NOT NULL,
    role character varying(20) DEFAULT 'JOGADOR'::character varying NOT NULL,
    CONSTRAINT ck_users_role CHECK (((role)::text = ANY ((ARRAY['JOGADOR'::character varying, 'ADMIN'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 27241)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5107 (class 0 OID 0)
-- Dependencies: 236
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4798 (class 2604 OID 27238)
-- Name: conquista_legado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conquista_legado ALTER COLUMN id SET DEFAULT nextval('public.conquista_id_seq'::regclass);


--
-- TOC entry 4811 (class 2604 OID 27426)
-- Name: conquistas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conquistas ALTER COLUMN id SET DEFAULT nextval('public.conquistas_id_seq'::regclass);


--
-- TOC entry 4792 (class 2604 OID 27194)
-- Name: inventario_legado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario_legado ALTER COLUMN id SET DEFAULT nextval('public.inventario_id_seq'::regclass);


--
-- TOC entry 4805 (class 2604 OID 27341)
-- Name: inventarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventarios ALTER COLUMN id SET DEFAULT nextval('public.inventarios_id_seq'::regclass);


--
-- TOC entry 4794 (class 2604 OID 27208)
-- Name: item_legado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_legado ALTER COLUMN id SET DEFAULT nextval('public.item_id_seq'::regclass);


--
-- TOC entry 4793 (class 2604 OID 27201)
-- Name: iteminventario_legado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iteminventario_legado ALTER COLUMN id SET DEFAULT nextval('public.iteminventario_id_seq'::regclass);


--
-- TOC entry 4807 (class 2604 OID 27357)
-- Name: itens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens ALTER COLUMN id SET DEFAULT nextval('public.itens_id_seq'::regclass);


--
-- TOC entry 4808 (class 2604 OID 27370)
-- Name: itens_inventario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_inventario ALTER COLUMN id SET DEFAULT nextval('public.itens_inventario_id_seq'::regclass);


--
-- TOC entry 4790 (class 2604 OID 27180)
-- Name: jogador_legado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jogador_legado ALTER COLUMN id SET DEFAULT nextval('public.jogador_id_seq'::regclass);


--
-- TOC entry 4797 (class 2604 OID 27231)
-- Name: jogadorconquista_legado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jogadorconquista_legado ALTER COLUMN id SET DEFAULT nextval('public.jogadorconquista_id_seq'::regclass);


--
-- TOC entry 4801 (class 2604 OID 27306)
-- Name: jogadores id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jogadores ALTER COLUMN id SET DEFAULT nextval('public.jogadores_id_seq'::regclass);


--
-- TOC entry 4812 (class 2604 OID 27437)
-- Name: jogadores_conquistas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jogadores_conquistas ALTER COLUMN id SET DEFAULT nextval('public.jogadores_conquistas_id_seq'::regclass);


--
-- TOC entry 4796 (class 2604 OID 27224)
-- Name: missao_legado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missao_legado ALTER COLUMN id SET DEFAULT nextval('public.missao_id_seq'::regclass);


--
-- TOC entry 4809 (class 2604 OID 27391)
-- Name: missoes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missoes ALTER COLUMN id SET DEFAULT nextval('public.missoes_id_seq'::regclass);


--
-- TOC entry 4795 (class 2604 OID 27217)
-- Name: personagemmissao_legado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personagemmissao_legado ALTER COLUMN id SET DEFAULT nextval('public.personagemmissao_id_seq'::regclass);


--
-- TOC entry 4791 (class 2604 OID 27187)
-- Name: personagen_legado id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personagen_legado ALTER COLUMN id SET DEFAULT nextval('public.personagen_id_seq'::regclass);


--
-- TOC entry 4802 (class 2604 OID 27321)
-- Name: personagens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personagens ALTER COLUMN id SET DEFAULT nextval('public.personagens_id_seq'::regclass);


--
-- TOC entry 4810 (class 2604 OID 27403)
-- Name: personagens_missoes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personagens_missoes ALTER COLUMN id SET DEFAULT nextval('public.personagens_missoes_id_seq'::regclass);


--
-- TOC entry 4799 (class 2604 OID 27245)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5062 (class 0 OID 27235)
-- Dependencies: 235
-- Data for Name: conquista_legado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conquista_legado (id, nome, descricao) FROM stdin;
\.


--
-- TOC entry 5080 (class 0 OID 27423)
-- Dependencies: 253
-- Data for Name: conquistas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conquistas (id, nome, descricao) FROM stdin;
1	primeiros passos	morreu a primeira vez
\.


--
-- TOC entry 5044 (class 0 OID 27167)
-- Dependencies: 217
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	create jogadorSQL	SQL	V1__create_jogadorSQL.sql	-361662439	postgres	2026-10-05 20:45:25.470998	12	t
2	2	create personagemSQL	SQL	V2__create_personagemSQL.sql	490947404	postgres	2026-10-05 20:45:25.502383	3	t
3	3	create inventarioSQL	SQL	V3__create_inventarioSQL.sql	-1482955234	postgres	2026-10-05 20:45:25.514151	4	t
4	4	create iteminventarioSQL	SQL	V4__create_iteminventarioSQL.sql	2091705496	postgres	2026-10-05 20:45:25.524789	4	t
5	5	create itemSQL	SQL	V5__create_itemSQL.sql	620426608	postgres	2026-10-05 20:45:25.533838	5	t
6	6	create personagemMissao	SQL	V6__create_personagemMissao.sql	-75181887	postgres	2026-10-05 20:45:25.544952	4	t
7	7	create missao	SQL	V7__create_missao.sql	1142630388	postgres	2026-10-05 20:45:25.554492	4	t
8	8	create jogadorconquista	SQL	V8__create_jogadorconquista.sql	-109511290	postgres	2026-10-05 20:45:25.563545	4	t
9	9	create conquista	SQL	V9__create_conquista.sql	721370221	postgres	2026-10-05 20:45:25.572369	5	t
10	10	create table user	SQL	V10__create_table_user.sql	-44660419	postgres	2026-10-05 20:45:25.582321	5	t
11	11	relacionamentos jogo	SQL	V11__relacionamentos_jogo.sql	1686532219	postgres	2026-11-02 20:27:35.817475	144	t
\.


--
-- TOC entry 5050 (class 0 OID 27191)
-- Dependencies: 223
-- Data for Name: inventario_legado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventario_legado (id, capacidade) FROM stdin;
\.


--
-- TOC entry 5070 (class 0 OID 27338)
-- Dependencies: 243
-- Data for Name: inventarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventarios (id, personagem_id, capacidade) FROM stdin;
1	1	20
2	2	20
3	3	20
\.


--
-- TOC entry 5054 (class 0 OID 27205)
-- Dependencies: 227
-- Data for Name: item_legado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.item_legado (id, nome, "descrição", tipo, valor) FROM stdin;
\.


--
-- TOC entry 5052 (class 0 OID 27198)
-- Dependencies: 225
-- Data for Name: iteminventario_legado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.iteminventario_legado (id, quantidade) FROM stdin;
\.


--
-- TOC entry 5072 (class 0 OID 27354)
-- Dependencies: 245
-- Data for Name: itens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.itens (id, nome, descricao, tipo, valor) FROM stdin;
1	darck sword	sword	sword	1000000.00
\.


--
-- TOC entry 5074 (class 0 OID 27367)
-- Dependencies: 247
-- Data for Name: itens_inventario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.itens_inventario (id, inventario_id, item_id, quantidade) FROM stdin;
1	1	1	1
\.


--
-- TOC entry 5046 (class 0 OID 27177)
-- Dependencies: 219
-- Data for Name: jogador_legado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jogador_legado (id, nome, email, senha) FROM stdin;
\.


--
-- TOC entry 5060 (class 0 OID 27228)
-- Dependencies: 233
-- Data for Name: jogadorconquista_legado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jogadorconquista_legado (id, dataobtencao) FROM stdin;
\.


--
-- TOC entry 5066 (class 0 OID 27303)
-- Dependencies: 239
-- Data for Name: jogadores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jogadores (id, user_id, nome) FROM stdin;
1	1	miguel
\.


--
-- TOC entry 5082 (class 0 OID 27434)
-- Dependencies: 255
-- Data for Name: jogadores_conquistas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jogadores_conquistas (id, jogador_id, conquista_id, data_obtencao) FROM stdin;
1	1	1	2026-11-04
\.


--
-- TOC entry 5058 (class 0 OID 27221)
-- Dependencies: 231
-- Data for Name: missao_legado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.missao_legado (id, nome, descricao, recompensa) FROM stdin;
\.


--
-- TOC entry 5076 (class 0 OID 27388)
-- Dependencies: 249
-- Data for Name: missoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.missoes (id, nome, descricao, recompensa_xp) FROM stdin;
1	iniciação	missão 1	1
\.


--
-- TOC entry 5056 (class 0 OID 27214)
-- Dependencies: 229
-- Data for Name: personagemmissao_legado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personagemmissao_legado (id, status, datainicio, datacomclusao) FROM stdin;
\.


--
-- TOC entry 5048 (class 0 OID 27184)
-- Dependencies: 221
-- Data for Name: personagen_legado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personagen_legado (id, nome, nivel, experiencia, classe) FROM stdin;
\.


--
-- TOC entry 5068 (class 0 OID 27318)
-- Dependencies: 241
-- Data for Name: personagens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personagens (id, jogador_id, nome, classe, nivel, experiencia) FROM stdin;
1	1	lupin	guerreiro	1	0
2	1	Farfarfet	Mago	1	0
3	1	luigi	bardo	1	0
\.


--
-- TOC entry 5078 (class 0 OID 27400)
-- Dependencies: 251
-- Data for Name: personagens_missoes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personagens_missoes (id, personagem_id, missao_id, status, data_inicio, data_conclusao, recompensa_xp) FROM stdin;
\.


--
-- TOC entry 5064 (class 0 OID 27242)
-- Dependencies: 237
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, password, role) FROM stdin;
1	miguel	miguel@gmail.com	$2a$10$cl/VXXncu3JTY7jQLtF.J.czPN11HTHELvtsyHYFK/al/nncK63oW	ADMIN
2	luigi	luigi@gmail.com	$2a$10$WjoioMgMA0xicQqGsACaIuy6m1gAsQHJ8m6tN2ngmNbqBlKBHAx82	JOGADOR
\.


--
-- TOC entry 5108 (class 0 OID 0)
-- Dependencies: 234
-- Name: conquista_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conquista_id_seq', 1, false);


--
-- TOC entry 5109 (class 0 OID 0)
-- Dependencies: 252
-- Name: conquistas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conquistas_id_seq', 1, true);


--
-- TOC entry 5110 (class 0 OID 0)
-- Dependencies: 222
-- Name: inventario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventario_id_seq', 1, false);


--
-- TOC entry 5111 (class 0 OID 0)
-- Dependencies: 242
-- Name: inventarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventarios_id_seq', 3, true);


--
-- TOC entry 5112 (class 0 OID 0)
-- Dependencies: 226
-- Name: item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.item_id_seq', 1, false);


--
-- TOC entry 5113 (class 0 OID 0)
-- Dependencies: 224
-- Name: iteminventario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.iteminventario_id_seq', 1, false);


--
-- TOC entry 5114 (class 0 OID 0)
-- Dependencies: 244
-- Name: itens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.itens_id_seq', 1, true);


--
-- TOC entry 5115 (class 0 OID 0)
-- Dependencies: 246
-- Name: itens_inventario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.itens_inventario_id_seq', 1, true);


--
-- TOC entry 5116 (class 0 OID 0)
-- Dependencies: 218
-- Name: jogador_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jogador_id_seq', 1, false);


--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 232
-- Name: jogadorconquista_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jogadorconquista_id_seq', 1, false);


--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 254
-- Name: jogadores_conquistas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jogadores_conquistas_id_seq', 1, true);


--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 238
-- Name: jogadores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jogadores_id_seq', 1, true);


--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 230
-- Name: missao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.missao_id_seq', 1, false);


--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 248
-- Name: missoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.missoes_id_seq', 1, true);


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 228
-- Name: personagemmissao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personagemmissao_id_seq', 1, false);


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 220
-- Name: personagen_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personagen_id_seq', 1, false);


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 240
-- Name: personagens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personagens_id_seq', 3, true);


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 250
-- Name: personagens_missoes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personagens_missoes_id_seq', 1, false);


--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 236
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 4854 (class 2606 OID 27240)
-- Name: conquista_legado conquista_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conquista_legado
    ADD CONSTRAINT conquista_pkey PRIMARY KEY (id);


--
-- TOC entry 4884 (class 2606 OID 27432)
-- Name: conquistas conquistas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conquistas
    ADD CONSTRAINT conquistas_pkey PRIMARY KEY (id);


--
-- TOC entry 4835 (class 2606 OID 27174)
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- TOC entry 4842 (class 2606 OID 27196)
-- Name: inventario_legado inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario_legado
    ADD CONSTRAINT inventario_pkey PRIMARY KEY (id);


--
-- TOC entry 4866 (class 2606 OID 27347)
-- Name: inventarios inventarios_personagem_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventarios
    ADD CONSTRAINT inventarios_personagem_id_key UNIQUE (personagem_id);


--
-- TOC entry 4868 (class 2606 OID 27345)
-- Name: inventarios inventarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventarios
    ADD CONSTRAINT inventarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4846 (class 2606 OID 27212)
-- Name: item_legado item_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_legado
    ADD CONSTRAINT item_pkey PRIMARY KEY (id);


--
-- TOC entry 4844 (class 2606 OID 27203)
-- Name: iteminventario_legado iteminventario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iteminventario_legado
    ADD CONSTRAINT iteminventario_pkey PRIMARY KEY (id);


--
-- TOC entry 4872 (class 2606 OID 27373)
-- Name: itens_inventario itens_inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_inventario
    ADD CONSTRAINT itens_inventario_pkey PRIMARY KEY (id);


--
-- TOC entry 4870 (class 2606 OID 27365)
-- Name: itens itens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens
    ADD CONSTRAINT itens_pkey PRIMARY KEY (id);


--
-- TOC entry 4838 (class 2606 OID 27182)
-- Name: jogador_legado jogador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jogador_legado
    ADD CONSTRAINT jogador_pkey PRIMARY KEY (id);


--
-- TOC entry 4852 (class 2606 OID 27233)
-- Name: jogadorconquista_legado jogadorconquista_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jogadorconquista_legado
    ADD CONSTRAINT jogadorconquista_pkey PRIMARY KEY (id);


--
-- TOC entry 4887 (class 2606 OID 27439)
-- Name: jogadores_conquistas jogadores_conquistas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jogadores_conquistas
    ADD CONSTRAINT jogadores_conquistas_pkey PRIMARY KEY (id);


--
-- TOC entry 4859 (class 2606 OID 27309)
-- Name: jogadores jogadores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jogadores
    ADD CONSTRAINT jogadores_pkey PRIMARY KEY (id);


--
-- TOC entry 4861 (class 2606 OID 27311)
-- Name: jogadores jogadores_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jogadores
    ADD CONSTRAINT jogadores_user_id_key UNIQUE (user_id);


--
-- TOC entry 4850 (class 2606 OID 27226)
-- Name: missao_legado missao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missao_legado
    ADD CONSTRAINT missao_pkey PRIMARY KEY (id);


--
-- TOC entry 4877 (class 2606 OID 27398)
-- Name: missoes missoes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missoes
    ADD CONSTRAINT missoes_pkey PRIMARY KEY (id);


--
-- TOC entry 4848 (class 2606 OID 27219)
-- Name: personagemmissao_legado personagemmissao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personagemmissao_legado
    ADD CONSTRAINT personagemmissao_pkey PRIMARY KEY (id);


--
-- TOC entry 4840 (class 2606 OID 27189)
-- Name: personagen_legado personagen_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personagen_legado
    ADD CONSTRAINT personagen_pkey PRIMARY KEY (id);


--
-- TOC entry 4880 (class 2606 OID 27408)
-- Name: personagens_missoes personagens_missoes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personagens_missoes
    ADD CONSTRAINT personagens_missoes_pkey PRIMARY KEY (id);


--
-- TOC entry 4864 (class 2606 OID 27330)
-- Name: personagens personagens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personagens
    ADD CONSTRAINT personagens_pkey PRIMARY KEY (id);


--
-- TOC entry 4875 (class 2606 OID 27375)
-- Name: itens_inventario uq_inventario_item; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_inventario
    ADD CONSTRAINT uq_inventario_item UNIQUE (inventario_id, item_id);


--
-- TOC entry 4889 (class 2606 OID 27441)
-- Name: jogadores_conquistas uq_jogador_conquista; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jogadores_conquistas
    ADD CONSTRAINT uq_jogador_conquista UNIQUE (jogador_id, conquista_id);


--
-- TOC entry 4882 (class 2606 OID 27410)
-- Name: personagens_missoes uq_personagem_missao; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personagens_missoes
    ADD CONSTRAINT uq_personagem_missao UNIQUE (personagem_id, missao_id);


--
-- TOC entry 4857 (class 2606 OID 27249)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4836 (class 1259 OID 27175)
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- TOC entry 4873 (class 1259 OID 27386)
-- Name: ix_itens_inventario_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_itens_inventario_item ON public.itens_inventario USING btree (item_id);


--
-- TOC entry 4885 (class 1259 OID 27452)
-- Name: ix_jogadores_conquistas_conquista; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_jogadores_conquistas_conquista ON public.jogadores_conquistas USING btree (conquista_id);


--
-- TOC entry 4862 (class 1259 OID 27336)
-- Name: ix_personagens_jogador; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_personagens_jogador ON public.personagens USING btree (jogador_id);


--
-- TOC entry 4878 (class 1259 OID 27421)
-- Name: ix_personagens_missoes_missao; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_personagens_missoes_missao ON public.personagens_missoes USING btree (missao_id);


--
-- TOC entry 4855 (class 1259 OID 27299)
-- Name: uq_users_email_ci; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX uq_users_email_ci ON public.users USING btree (lower((email)::text));


--
-- TOC entry 4892 (class 2606 OID 27348)
-- Name: inventarios inventarios_personagem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventarios
    ADD CONSTRAINT inventarios_personagem_id_fkey FOREIGN KEY (personagem_id) REFERENCES public.personagens(id) ON DELETE CASCADE;


--
-- TOC entry 4893 (class 2606 OID 27376)
-- Name: itens_inventario itens_inventario_inventario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_inventario
    ADD CONSTRAINT itens_inventario_inventario_id_fkey FOREIGN KEY (inventario_id) REFERENCES public.inventarios(id) ON DELETE CASCADE;


--
-- TOC entry 4894 (class 2606 OID 27381)
-- Name: itens_inventario itens_inventario_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itens_inventario
    ADD CONSTRAINT itens_inventario_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.itens(id) ON DELETE RESTRICT;


--
-- TOC entry 4897 (class 2606 OID 27447)
-- Name: jogadores_conquistas jogadores_conquistas_conquista_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jogadores_conquistas
    ADD CONSTRAINT jogadores_conquistas_conquista_id_fkey FOREIGN KEY (conquista_id) REFERENCES public.conquistas(id) ON DELETE RESTRICT;


--
-- TOC entry 4898 (class 2606 OID 27442)
-- Name: jogadores_conquistas jogadores_conquistas_jogador_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jogadores_conquistas
    ADD CONSTRAINT jogadores_conquistas_jogador_id_fkey FOREIGN KEY (jogador_id) REFERENCES public.jogadores(id) ON DELETE CASCADE;


--
-- TOC entry 4890 (class 2606 OID 27312)
-- Name: jogadores jogadores_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jogadores
    ADD CONSTRAINT jogadores_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE RESTRICT;


--
-- TOC entry 4891 (class 2606 OID 27331)
-- Name: personagens personagens_jogador_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personagens
    ADD CONSTRAINT personagens_jogador_id_fkey FOREIGN KEY (jogador_id) REFERENCES public.jogadores(id) ON DELETE CASCADE;


--
-- TOC entry 4895 (class 2606 OID 27416)
-- Name: personagens_missoes personagens_missoes_missao_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personagens_missoes
    ADD CONSTRAINT personagens_missoes_missao_id_fkey FOREIGN KEY (missao_id) REFERENCES public.missoes(id) ON DELETE RESTRICT;


--
-- TOC entry 4896 (class 2606 OID 27411)
-- Name: personagens_missoes personagens_missoes_personagem_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personagens_missoes
    ADD CONSTRAINT personagens_missoes_personagem_id_fkey FOREIGN KEY (personagem_id) REFERENCES public.personagens(id) ON DELETE CASCADE;


-- Completed on 2026-11-05 16:33:58

--
-- PostgreSQL database dump complete
--

