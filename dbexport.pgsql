--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO catthu;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO catthu;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO catthu;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO catthu;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO catthu;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO catthu;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO catthu;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO catthu;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO catthu;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO catthu;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO catthu;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO catthu;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO catthu;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO catthu;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO catthu;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO catthu;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO catthu;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO catthu;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO catthu;

--
-- Name: generics_character; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE generics_character (
    id integer NOT NULL,
    location_id integer NOT NULL,
    first_name character varying(16),
    last_name character varying(16),
    is_logged_in boolean NOT NULL
);


ALTER TABLE generics_character OWNER TO catthu;

--
-- Name: generics_character_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE generics_character_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE generics_character_id_seq OWNER TO catthu;

--
-- Name: generics_character_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE generics_character_id_seq OWNED BY generics_character.id;


--
-- Name: generics_item; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE generics_item (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    room_id integer NOT NULL
);


ALTER TABLE generics_item OWNER TO catthu;

--
-- Name: generics_item_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE generics_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE generics_item_id_seq OWNER TO catthu;

--
-- Name: generics_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE generics_item_id_seq OWNED BY generics_item.id;


--
-- Name: generics_puzzle; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE generics_puzzle (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    difficulty smallint NOT NULL,
    puzzle_text character varying(100) NOT NULL,
    puzzle_hint character varying(200) NOT NULL,
    puzzle_solution character varying(200) NOT NULL,
    puzzle_location_id integer NOT NULL,
    CONSTRAINT generics_puzzle_difficulty_check CHECK ((difficulty >= 0))
);


ALTER TABLE generics_puzzle OWNER TO catthu;

--
-- Name: generics_puzzle_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE generics_puzzle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE generics_puzzle_id_seq OWNER TO catthu;

--
-- Name: generics_puzzle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE generics_puzzle_id_seq OWNED BY generics_puzzle.id;


--
-- Name: generics_room; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE generics_room (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    code_name character varying(200),
    description text,
    indoor boolean NOT NULL,
    exit_id integer,
    js_filename character varying(64) NOT NULL,
    opening_script text
);


ALTER TABLE generics_room OWNER TO catthu;

--
-- Name: generics_room_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE generics_room_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE generics_room_id_seq OWNER TO catthu;

--
-- Name: generics_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE generics_room_id_seq OWNED BY generics_room.id;


--
-- Name: players_player; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE players_player (
    id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE players_player OWNER TO catthu;

--
-- Name: players_player_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE players_player_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE players_player_id_seq OWNER TO catthu;

--
-- Name: players_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE players_player_id_seq OWNED BY players_player.id;


--
-- Name: players_playertocharacters; Type: TABLE; Schema: public; Owner: catthu
--

CREATE TABLE players_playertocharacters (
    id integer NOT NULL,
    character_id integer NOT NULL,
    player_id integer NOT NULL
);


ALTER TABLE players_playertocharacters OWNER TO catthu;

--
-- Name: players_playertocharacters_id_seq; Type: SEQUENCE; Schema: public; Owner: catthu
--

CREATE SEQUENCE players_playertocharacters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE players_playertocharacters_id_seq OWNER TO catthu;

--
-- Name: players_playertocharacters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: catthu
--

ALTER SEQUENCE players_playertocharacters_id_seq OWNED BY players_playertocharacters.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: generics_character id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY generics_character ALTER COLUMN id SET DEFAULT nextval('generics_character_id_seq'::regclass);


--
-- Name: generics_item id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY generics_item ALTER COLUMN id SET DEFAULT nextval('generics_item_id_seq'::regclass);


--
-- Name: generics_puzzle id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY generics_puzzle ALTER COLUMN id SET DEFAULT nextval('generics_puzzle_id_seq'::regclass);


--
-- Name: generics_room id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY generics_room ALTER COLUMN id SET DEFAULT nextval('generics_room_id_seq'::regclass);


--
-- Name: players_player id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY players_player ALTER COLUMN id SET DEFAULT nextval('players_player_id_seq'::regclass);


--
-- Name: players_playertocharacters id; Type: DEFAULT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY players_playertocharacters ALTER COLUMN id SET DEFAULT nextval('players_playertocharacters_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add room	1	add_room
2	Can change room	1	change_room
3	Can delete room	1	delete_room
4	Can add item	2	add_item
5	Can change item	2	change_item
6	Can delete item	2	delete_item
7	Can add character	3	add_character
8	Can change character	3	change_character
9	Can delete character	3	delete_character
10	Can add puzzle	4	add_puzzle
11	Can change puzzle	4	change_puzzle
12	Can delete puzzle	4	delete_puzzle
13	Can add log entry	5	add_logentry
14	Can change log entry	5	change_logentry
15	Can delete log entry	5	delete_logentry
16	Can add permission	6	add_permission
17	Can change permission	6	change_permission
18	Can delete permission	6	delete_permission
19	Can add group	7	add_group
20	Can change group	7	change_group
21	Can delete group	7	delete_group
22	Can add user	8	add_user
23	Can change user	8	change_user
24	Can delete user	8	delete_user
25	Can add content type	9	add_contenttype
26	Can change content type	9	change_contenttype
27	Can delete content type	9	delete_contenttype
28	Can add session	10	add_session
29	Can change session	10	change_session
30	Can delete session	10	delete_session
31	Can add player	11	add_player
32	Can change player	11	change_player
33	Can delete player	11	delete_player
34	Can add player to characters	12	add_playertocharacters
35	Can change player to characters	12	change_playertocharacters
36	Can delete player to characters	12	delete_playertocharacters
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('auth_permission_id_seq', 36, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
5	pbkdf2_sha256$30000$Dp8EJkkocEPu$oW0Fh0SW9vcX5+d8lGQh9g+3sSxCCZkzZIvaUHq4hwU=	\N	f	storage				f	t	2017-03-29 17:36:20.932603-04
21	pbkdf2_sha256$30000$yifmBO5g5AVZ$dNrdweBc9Cse5zp0SSMxX5H0jgk2HNrMoDbauzjRdo4=	2017-04-01 03:02:58.597112-04	f	jade			catthunh@gmail.com	f	t	2017-03-31 17:10:44.739237-04
11	pbkdf2_sha256$30000$mqJEjwzzZH5N$03MPIJHWVAwYoro74sLX+9VyaNzfk6z/q5hk/gxBuWs=	2017-04-01 03:21:02.885375-04	f	catthu			catthunh@gmail.com	f	t	2017-03-30 03:10:20.795862-04
22	pbkdf2_sha256$30000$eesxRZbZ2jMv$FcL7hz67/AJ4ujL98PtTyl48iwZHOVwXxI2BCtnl8uk=	2017-04-01 03:47:36.49134-04	f	pepper			catthunh@gmail.com	f	t	2017-04-01 03:33:55.69287-04
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('auth_user_id_seq', 22, true);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 1, false);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	generics	room
2	generics	item
3	generics	character
4	generics	puzzle
5	admin	logentry
6	auth	permission
7	auth	group
8	auth	user
9	contenttypes	contenttype
10	sessions	session
11	players	player
12	players	playertocharacters
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('django_content_type_id_seq', 12, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2017-03-25 05:29:44.192928-04
2	auth	0001_initial	2017-03-25 05:29:44.387486-04
3	admin	0001_initial	2017-03-25 05:29:44.444772-04
4	admin	0002_logentry_remove_auto_add	2017-03-25 05:29:44.477835-04
5	contenttypes	0002_remove_content_type_name	2017-03-25 05:29:44.549606-04
6	auth	0002_alter_permission_name_max_length	2017-03-25 05:29:44.572237-04
7	auth	0003_alter_user_email_max_length	2017-03-25 05:29:44.595767-04
8	auth	0004_alter_user_username_opts	2017-03-25 05:29:44.615357-04
9	auth	0005_alter_user_last_login_null	2017-03-25 05:29:44.639822-04
10	auth	0006_require_contenttypes_0002	2017-03-25 05:29:44.64516-04
11	auth	0007_alter_validators_add_error_messages	2017-03-25 05:29:44.665068-04
12	generics	0001_initial	2017-03-25 05:29:44.797623-04
13	generics	0002_room_is_scripted	2017-03-25 05:29:44.843686-04
14	generics	0003_auto_20170318_0705	2017-03-25 05:29:45.043674-04
15	generics	0004_auto_20170318_2006	2017-03-25 05:29:45.106211-04
16	sessions	0001_initial	2017-03-25 05:29:45.138948-04
17	terminal	0001_initial	2017-03-25 05:29:45.269246-04
18	terminal	0002_auto_20170318_0653	2017-03-25 05:29:45.441688-04
19	players	0001_initial	2017-03-29 06:20:21.297713-04
20	auth	0008_alter_user_username_max_length	2017-03-29 17:19:41.804838-04
21	players	0002_player_user	2017-03-29 17:42:35.573818-04
22	generics	0005_auto_20170329_2331	2017-03-29 19:31:07.079447-04
23	generics	0006_room_opening_script	2017-03-30 00:24:29.594461-04
24	generics	0007_auto_20170330_0424	2017-03-30 00:24:29.632249-04
25	players	0003_auto_20170330_0424	2017-03-30 00:24:29.807929-04
26	generics	0008_room_opening_script	2017-03-30 00:29:30.87475-04
27	players	0004_auto_20170330_0724	2017-03-30 03:24:19.083278-04
28	generics	0009_auto_20170331_1852	2017-03-31 14:52:21.237907-04
29	players	0005_auto_20170331_1852	2017-03-31 14:52:21.524012-04
30	generics	0010_auto_20170331_2127	2017-03-31 17:27:16.464739-04
31	generics	0011_auto_20170331_2200	2017-03-31 18:01:02.509405-04
32	generics	0012_character_is_logged_in	2017-03-31 18:15:49.475148-04
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('django_migrations_id_seq', 32, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
7uubmc0ls03gqtmel7lsn7omfgfhsn68	ZTMzODkzNTljM2NlMzE0ZDYxNjUzM2VkZTdhOThmZGJlMzlhYmU3MDp7Il9hdXRoX3VzZXJfaGFzaCI6IjM3MDU0YTA3YzZjZjYxODRjNzZmMGYwNDBkYTk1ZjdmZjQ2MTE1NmEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=	2017-04-12 17:16:36.623015-04
ad9xewv1ij3xdrdqw6hwed47nv1pipji	YWRiNDc5NjVjNTExMjczNWU0NDhhNDBhMjAwYzU4YzkwMTliNjE4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkMDk0YmMzYzlkNjZlZDg2YmJlZTJlNjgwNzI4ODMxY2MwODBlNGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=	2017-04-12 17:19:49.972935-04
inhr3cni67ok7dym3o5d4gzxl6kogn7e	YWRiNDc5NjVjNTExMjczNWU0NDhhNDBhMjAwYzU4YzkwMTliNjE4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkMDk0YmMzYzlkNjZlZDg2YmJlZTJlNjgwNzI4ODMxY2MwODBlNGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=	2017-04-13 00:44:07.673178-04
95sae2h17yiqihhetwxmn1jfyqpekzjd	YWRiNDc5NjVjNTExMjczNWU0NDhhNDBhMjAwYzU4YzkwMTliNjE4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkMDk0YmMzYzlkNjZlZDg2YmJlZTJlNjgwNzI4ODMxY2MwODBlNGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=	2017-04-13 00:46:31.287422-04
zk2fnzlkh88c84zq8rn64bjm35sidly2	YWRiNDc5NjVjNTExMjczNWU0NDhhNDBhMjAwYzU4YzkwMTliNjE4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkMDk0YmMzYzlkNjZlZDg2YmJlZTJlNjgwNzI4ODMxY2MwODBlNGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=	2017-04-13 00:47:30.257136-04
sa40o8x4je5fiiqtzoyoqw9yfikm2czl	YWRiNDc5NjVjNTExMjczNWU0NDhhNDBhMjAwYzU4YzkwMTliNjE4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkMDk0YmMzYzlkNjZlZDg2YmJlZTJlNjgwNzI4ODMxY2MwODBlNGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=	2017-04-13 00:52:38.802429-04
olihn3mcol5j5gjtg9wcojoxex0vtijv	YWRiNDc5NjVjNTExMjczNWU0NDhhNDBhMjAwYzU4YzkwMTliNjE4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkMDk0YmMzYzlkNjZlZDg2YmJlZTJlNjgwNzI4ODMxY2MwODBlNGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=	2017-04-13 00:54:44.700044-04
0k1n283cy9jskdx2lipzhkox8i8t7xrt	YWRiNDc5NjVjNTExMjczNWU0NDhhNDBhMjAwYzU4YzkwMTliNjE4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkMDk0YmMzYzlkNjZlZDg2YmJlZTJlNjgwNzI4ODMxY2MwODBlNGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=	2017-04-13 00:55:18.520622-04
y5b8q9nzc6w8sv0rw1rw0nqfq5rhzfx3	YWRiNDc5NjVjNTExMjczNWU0NDhhNDBhMjAwYzU4YzkwMTliNjE4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkMDk0YmMzYzlkNjZlZDg2YmJlZTJlNjgwNzI4ODMxY2MwODBlNGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=	2017-04-13 00:56:14.28719-04
8vwk24e01ha8ljp10f7fqx8yymcbhujb	YWRiNDc5NjVjNTExMjczNWU0NDhhNDBhMjAwYzU4YzkwMTliNjE4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkMDk0YmMzYzlkNjZlZDg2YmJlZTJlNjgwNzI4ODMxY2MwODBlNGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=	2017-04-13 00:57:40.991341-04
jlvte0iutuz7nv4dbh2iplr3e7fcyu8u	YWRiNDc5NjVjNTExMjczNWU0NDhhNDBhMjAwYzU4YzkwMTliNjE4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkMDk0YmMzYzlkNjZlZDg2YmJlZTJlNjgwNzI4ODMxY2MwODBlNGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=	2017-04-13 01:00:33.840568-04
lomj058awm3gi1lddweal060gibmdttx	YWRiNDc5NjVjNTExMjczNWU0NDhhNDBhMjAwYzU4YzkwMTliNjE4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkMDk0YmMzYzlkNjZlZDg2YmJlZTJlNjgwNzI4ODMxY2MwODBlNGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=	2017-04-13 01:01:56.379332-04
4p949xyehwm8l22d6stjrfrrwe1epfq4	YWRiNDc5NjVjNTExMjczNWU0NDhhNDBhMjAwYzU4YzkwMTliNjE4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkMDk0YmMzYzlkNjZlZDg2YmJlZTJlNjgwNzI4ODMxY2MwODBlNGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=	2017-04-13 01:03:10.498356-04
a40u6ic18t1p1cixx0mree8o1go27qk2	YWRiNDc5NjVjNTExMjczNWU0NDhhNDBhMjAwYzU4YzkwMTliNjE4NDp7Il9hdXRoX3VzZXJfaGFzaCI6ImJkMDk0YmMzYzlkNjZlZDg2YmJlZTJlNjgwNzI4ODMxY2MwODBlNGMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIzIn0=	2017-04-13 01:04:16.578061-04
\.


--
-- Data for Name: generics_character; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY generics_character (id, location_id, first_name, last_name, is_logged_in) FROM stdin;
4	1	Jade	Weatherlight	t
3	6	Cat	Nguyen	t
\.


--
-- Name: generics_character_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('generics_character_id_seq', 4, true);


--
-- Data for Name: generics_item; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY generics_item (id, name, room_id) FROM stdin;
\.


--
-- Name: generics_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('generics_item_id_seq', 1, false);


--
-- Data for Name: generics_puzzle; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY generics_puzzle (id, name, difficulty, puzzle_text, puzzle_hint, puzzle_solution, puzzle_location_id) FROM stdin;
\.


--
-- Name: generics_puzzle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('generics_puzzle_id_seq', 1, false);


--
-- Data for Name: generics_room; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY generics_room (id, name, code_name, description, indoor, exit_id, js_filename, opening_script) FROM stdin;
2	Secret Cabin	Sanctuary	\N	t	\N	normalroom	\N
5	Room of Holding	Storage	\N	t	\N	normalroom	\N
3	Welcome	Login	Welcome to Platform 17. There are secrets, lores, heroes, villians, and any other dramatic nouns you can think of.<br /> <br /> But first, I don't recognize you. <br /> Create a NEW account, or SIGN IN? <br />	t	\N	login	\N
4	The Interstellar Express	Chargen	You are in a train packed with the most playful and fashionable denizens of the galaxy. Outside the large window on your right, an impressive colossal station stands against the vast backdrop of space.	t	\N	chargen	A smiling woman in uniform stops by your seat. <span class = 'dialogue'>"We are just a few minutes from boarding Platform 17. There’s just a few questions I need to ask. " </span><br /><br /><span class = 'dialogue'>"What's your first name? Just SAY your first name."</span>
1	The Astral Plane	Astral	\N	t	6	normalroom	\N
6	Platform 17	Platform17	This is the most amazing platform ever.	t	1	normalroom	\N
\.


--
-- Name: generics_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('generics_room_id_seq', 6, true);


--
-- Data for Name: players_player; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY players_player (id, user_id) FROM stdin;
6	11
9	21
10	22
\.


--
-- Name: players_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('players_player_id_seq', 10, true);


--
-- Data for Name: players_playertocharacters; Type: TABLE DATA; Schema: public; Owner: catthu
--

COPY players_playertocharacters (id, character_id, player_id) FROM stdin;
1	3	6
2	4	9
\.


--
-- Name: players_playertocharacters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: catthu
--

SELECT pg_catalog.setval('players_playertocharacters_id_seq', 2, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: generics_character generics_character_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY generics_character
    ADD CONSTRAINT generics_character_pkey PRIMARY KEY (id);


--
-- Name: generics_item generics_item_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY generics_item
    ADD CONSTRAINT generics_item_pkey PRIMARY KEY (id);


--
-- Name: generics_puzzle generics_puzzle_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY generics_puzzle
    ADD CONSTRAINT generics_puzzle_pkey PRIMARY KEY (id);


--
-- Name: generics_room generics_room_code_name_a1b41467_uniq; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY generics_room
    ADD CONSTRAINT generics_room_code_name_a1b41467_uniq UNIQUE (code_name);


--
-- Name: generics_room generics_room_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY generics_room
    ADD CONSTRAINT generics_room_pkey PRIMARY KEY (id);


--
-- Name: players_player players_player_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY players_player
    ADD CONSTRAINT players_player_pkey PRIMARY KEY (id);


--
-- Name: players_player players_player_user_id_0d595fa3_uniq; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY players_player
    ADD CONSTRAINT players_player_user_id_0d595fa3_uniq UNIQUE (user_id);


--
-- Name: players_playertocharacters players_playertocharacters_character_id_key; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY players_playertocharacters
    ADD CONSTRAINT players_playertocharacters_character_id_key UNIQUE (character_id);


--
-- Name: players_playertocharacters players_playertocharacters_pkey; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY players_playertocharacters
    ADD CONSTRAINT players_playertocharacters_pkey PRIMARY KEY (id);


--
-- Name: players_playertocharacters players_playertocharacters_player_id_key; Type: CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY players_playertocharacters
    ADD CONSTRAINT players_playertocharacters_player_id_key UNIQUE (player_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_0e939a4f; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX auth_group_permissions_0e939a4f ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_8373b171; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX auth_group_permissions_8373b171 ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_417f1b1c; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX auth_permission_417f1b1c ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_0e939a4f; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX auth_user_groups_0e939a4f ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_e8701ad4; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX auth_user_groups_e8701ad4 ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_8373b171; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX auth_user_user_permissions_8373b171 ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_e8701ad4; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX auth_user_user_permissions_e8701ad4 ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX auth_user_username_6821ab7c_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_417f1b1c; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX django_admin_log_417f1b1c ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_e8701ad4; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX django_admin_log_e8701ad4 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_de54fa62; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX django_session_de54fa62 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: generics_character_8273f993; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX generics_character_8273f993 ON generics_character USING btree (location_id);


--
-- Name: generics_item_8273f993; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX generics_item_8273f993 ON generics_item USING btree (room_id);


--
-- Name: generics_puzzle_9505913a; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX generics_puzzle_9505913a ON generics_puzzle USING btree (puzzle_location_id);


--
-- Name: generics_room_b637f42e; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX generics_room_b637f42e ON generics_room USING btree (exit_id);


--
-- Name: generics_room_code_name_a1b41467_like; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX generics_room_code_name_a1b41467_like ON generics_room USING btree (code_name varchar_pattern_ops);


--
-- Name: players_player_e8701ad4; Type: INDEX; Schema: public; Owner: catthu
--

CREATE INDEX players_player_e8701ad4 ON players_player USING btree (user_id);


--
-- Name: auth_group_permissions auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permiss_permission_id_84c5c92e_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permiss_content_type_id_2f476e4b_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_per_permission_id_1fbb5f2c_fk_auth_permission_id FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_content_type_id_c4bce8eb_fk_django_content_type_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_content_type_id_c4bce8eb_fk_django_content_type_id FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: generics_character generics_character_location_id_ac273b60_fk_generics_room_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY generics_character
    ADD CONSTRAINT generics_character_location_id_ac273b60_fk_generics_room_id FOREIGN KEY (location_id) REFERENCES generics_room(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: generics_item generics_item_room_id_42bf9e75_fk_generics_room_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY generics_item
    ADD CONSTRAINT generics_item_room_id_42bf9e75_fk_generics_room_id FOREIGN KEY (room_id) REFERENCES generics_room(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: generics_puzzle generics_puzzle_puzzle_location_id_6766b4c5_fk_generics_item_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY generics_puzzle
    ADD CONSTRAINT generics_puzzle_puzzle_location_id_6766b4c5_fk_generics_item_id FOREIGN KEY (puzzle_location_id) REFERENCES generics_item(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: generics_room generics_room_exit_id_925401b8_fk_generics_room_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY generics_room
    ADD CONSTRAINT generics_room_exit_id_925401b8_fk_generics_room_id FOREIGN KEY (exit_id) REFERENCES generics_room(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: players_player players_player_user_id_0d595fa3_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY players_player
    ADD CONSTRAINT players_player_user_id_0d595fa3_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: players_playertocharacters players_playerto_character_id_2fca742b_fk_generics_character_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY players_playertocharacters
    ADD CONSTRAINT players_playerto_character_id_2fca742b_fk_generics_character_id FOREIGN KEY (character_id) REFERENCES generics_character(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: players_playertocharacters players_playertocharact_player_id_a6e10a98_fk_players_player_id; Type: FK CONSTRAINT; Schema: public; Owner: catthu
--

ALTER TABLE ONLY players_playertocharacters
    ADD CONSTRAINT players_playertocharact_player_id_a6e10a98_fk_players_player_id FOREIGN KEY (player_id) REFERENCES players_player(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

