--
-- PostgreSQL database dump
--

\restrict BfMcPHbGSFR3BPRF4oQnkw1IFWTxxc01ER87XQlzZ6AsapZwj1fYzvYy9x5Es2N

-- Dumped from database version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)

-- Started on 2026-04-04 19:21:38 -04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 255 (class 1255 OID 16696)
-- Name: guardar_sesion(integer, integer); Type: FUNCTION; Schema: public; Owner: candy
--

CREATE FUNCTION public.guardar_sesion(p_id_usern integer, p_pid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO "Sesion" ("id_userN", "pid", "inicio")
    VALUES (p_id_userN, p_pid, CURRENT_TIMESTAMP);
END;
$$;


ALTER FUNCTION public.guardar_sesion(p_id_usern integer, p_pid integer) OWNER TO candy;

--
-- TOC entry 254 (class 1255 OID 16697)
-- Name: obtener_roles(integer); Type: FUNCTION; Schema: public; Owner: candy
--

CREATE FUNCTION public.obtener_roles(p_id_usern integer) RETURNS TABLE(id_rol integer, nombre_rol character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT r."id_rol", r."nombre"
    FROM "Rol" r
    INNER JOIN "User_Rol" ur ON ur."id_rol" = r."id_rol"
    WHERE ur."id_userN" = p_id_userN
      AND (ur."fecha_hasta" IS NULL OR ur."fecha_hasta" > CURRENT_TIMESTAMP);
END;
$$;


ALTER FUNCTION public.obtener_roles(p_id_usern integer) OWNER TO candy;

--
-- TOC entry 253 (class 1255 OID 16695)
-- Name: verificar_usuario(character varying, character varying); Type: FUNCTION; Schema: public; Owner: candy
--

CREATE FUNCTION public.verificar_usuario(p_nombre character varying, p_password character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_id INTEGER;
BEGIN
    SELECT "id_userN"
      INTO v_id
      FROM "UserN"
     WHERE "nombreN"   = p_nombre
       AND "passwordN" = p_password;

    IF FOUND THEN
        RETURN v_id;
    ELSE
        RETURN -1;
    END IF;
END;
$$;


ALTER FUNCTION public.verificar_usuario(p_nombre character varying, p_password character varying) OWNER TO candy;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 244 (class 1259 OID 16565)
-- Name: ARCHIVO; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."ARCHIVO" (
    id_archivo integer NOT NULL,
    id_repositorio integer NOT NULL,
    id_tipo integer NOT NULL,
    id_usuario integer NOT NULL,
    id_dispositivo integer,
    id_estado integer NOT NULL,
    id_codec integer NOT NULL,
    nombre character varying(200) NOT NULL,
    formato character varying(20) NOT NULL,
    tamano_bytes bigint NOT NULL,
    contenido_binario bytea NOT NULL,
    hash_md5 character varying(32),
    fecha_subida date NOT NULL,
    fecha_modif date
);


ALTER TABLE public."ARCHIVO" OWNER TO candy;

--
-- TOC entry 252 (class 1259 OID 16679)
-- Name: ARCHIVO_ETIQUETA; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."ARCHIVO_ETIQUETA" (
    id_archivo integer NOT NULL,
    id_etiqueta integer NOT NULL
);


ALTER TABLE public."ARCHIVO_ETIQUETA" OWNER TO candy;

--
-- TOC entry 243 (class 1259 OID 16564)
-- Name: ARCHIVO_id_archivo_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."ARCHIVO_id_archivo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ARCHIVO_id_archivo_seq" OWNER TO candy;

--
-- TOC entry 3714 (class 0 OID 0)
-- Dependencies: 243
-- Name: ARCHIVO_id_archivo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."ARCHIVO_id_archivo_seq" OWNED BY public."ARCHIVO".id_archivo;


--
-- TOC entry 229 (class 1259 OID 16479)
-- Name: CODEC; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."CODEC" (
    id_codec integer NOT NULL,
    nombre character varying(50) NOT NULL,
    categoria character varying(30) NOT NULL,
    descripcion character varying(200)
);


ALTER TABLE public."CODEC" OWNER TO candy;

--
-- TOC entry 228 (class 1259 OID 16478)
-- Name: CODEC_id_codec_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."CODEC_id_codec_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CODEC_id_codec_seq" OWNER TO candy;

--
-- TOC entry 3715 (class 0 OID 0)
-- Dependencies: 228
-- Name: CODEC_id_codec_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."CODEC_id_codec_seq" OWNED BY public."CODEC".id_codec;


--
-- TOC entry 246 (class 1259 OID 16618)
-- Name: CONFIGURACION_APP; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."CONFIGURACION_APP" (
    id_archivo integer NOT NULL,
    nombre_app character varying(100) NOT NULL,
    version_app character varying(20),
    datos_config text NOT NULL,
    es_restaurado boolean DEFAULT false
);


ALTER TABLE public."CONFIGURACION_APP" OWNER TO candy;

--
-- TOC entry 239 (class 1259 OID 16517)
-- Name: DISPOSITIVO; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."DISPOSITIVO" (
    id_dispositivo integer NOT NULL,
    id_usuario integer NOT NULL,
    id_tipo_dispositivo integer NOT NULL,
    nombre_dispositivo character varying(100) NOT NULL,
    modelo character varying(100),
    version_so character varying(50),
    fecha_registro date NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public."DISPOSITIVO" OWNER TO candy;

--
-- TOC entry 238 (class 1259 OID 16516)
-- Name: DISPOSITIVO_id_dispositivo_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."DISPOSITIVO_id_dispositivo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."DISPOSITIVO_id_dispositivo_seq" OWNER TO candy;

--
-- TOC entry 3716 (class 0 OID 0)
-- Dependencies: 238
-- Name: DISPOSITIVO_id_dispositivo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."DISPOSITIVO_id_dispositivo_seq" OWNED BY public."DISPOSITIVO".id_dispositivo;


--
-- TOC entry 235 (class 1259 OID 16500)
-- Name: ESTADO_ARCHIVO; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."ESTADO_ARCHIVO" (
    id_estado integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(200)
);


ALTER TABLE public."ESTADO_ARCHIVO" OWNER TO candy;

--
-- TOC entry 234 (class 1259 OID 16499)
-- Name: ESTADO_ARCHIVO_id_estado_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."ESTADO_ARCHIVO_id_estado_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ESTADO_ARCHIVO_id_estado_seq" OWNER TO candy;

--
-- TOC entry 3717 (class 0 OID 0)
-- Dependencies: 234
-- Name: ESTADO_ARCHIVO_id_estado_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."ESTADO_ARCHIVO_id_estado_seq" OWNED BY public."ESTADO_ARCHIVO".id_estado;


--
-- TOC entry 251 (class 1259 OID 16668)
-- Name: ETIQUETA; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."ETIQUETA" (
    id_etiqueta integer NOT NULL,
    id_usuario integer NOT NULL,
    nombre character varying(50) NOT NULL,
    color_hex character varying(7)
);


ALTER TABLE public."ETIQUETA" OWNER TO candy;

--
-- TOC entry 250 (class 1259 OID 16667)
-- Name: ETIQUETA_id_etiqueta_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."ETIQUETA_id_etiqueta_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."ETIQUETA_id_etiqueta_seq" OWNER TO candy;

--
-- TOC entry 3718 (class 0 OID 0)
-- Dependencies: 250
-- Name: ETIQUETA_id_etiqueta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."ETIQUETA_id_etiqueta_seq" OWNED BY public."ETIQUETA".id_etiqueta;


--
-- TOC entry 222 (class 1259 OID 16420)
-- Name: Funcion; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."Funcion" (
    id_funcion integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public."Funcion" OWNER TO candy;

--
-- TOC entry 227 (class 1259 OID 16463)
-- Name: Funcion_UI; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."Funcion_UI" (
    id_funcion integer NOT NULL,
    id_ui integer NOT NULL
);


ALTER TABLE public."Funcion_UI" OWNER TO candy;

--
-- TOC entry 221 (class 1259 OID 16419)
-- Name: Funcion_id_funcion_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."Funcion_id_funcion_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Funcion_id_funcion_seq" OWNER TO candy;

--
-- TOC entry 3719 (class 0 OID 0)
-- Dependencies: 221
-- Name: Funcion_id_funcion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."Funcion_id_funcion_seq" OWNED BY public."Funcion".id_funcion;


--
-- TOC entry 245 (class 1259 OID 16603)
-- Name: MULTIMEDIA; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."MULTIMEDIA" (
    id_archivo integer NOT NULL,
    tipo_medio character varying(20) NOT NULL,
    id_codec integer NOT NULL,
    duracion_segundos integer,
    resolucion character varying(20),
    ubicacion_gps character varying(60),
    camara character varying(50)
);


ALTER TABLE public."MULTIMEDIA" OWNER TO candy;

--
-- TOC entry 241 (class 1259 OID 16535)
-- Name: REPOSITORIO; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."REPOSITORIO" (
    id_repositorio integer NOT NULL,
    id_usuario integer NOT NULL,
    nombre character varying(100) NOT NULL,
    descripcion text,
    es_publico boolean DEFAULT false NOT NULL,
    fecha_creacion date NOT NULL
);


ALTER TABLE public."REPOSITORIO" OWNER TO candy;

--
-- TOC entry 242 (class 1259 OID 16549)
-- Name: REPOSITORIO_COMPARTIDO; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."REPOSITORIO_COMPARTIDO" (
    id_repositorio integer NOT NULL,
    id_usuario_dest integer NOT NULL,
    permiso character varying(20) NOT NULL,
    fecha_compartido date NOT NULL
);


ALTER TABLE public."REPOSITORIO_COMPARTIDO" OWNER TO candy;

--
-- TOC entry 240 (class 1259 OID 16534)
-- Name: REPOSITORIO_id_repositorio_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."REPOSITORIO_id_repositorio_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."REPOSITORIO_id_repositorio_seq" OWNER TO candy;

--
-- TOC entry 3720 (class 0 OID 0)
-- Dependencies: 240
-- Name: REPOSITORIO_id_repositorio_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."REPOSITORIO_id_repositorio_seq" OWNED BY public."REPOSITORIO".id_repositorio;


--
-- TOC entry 220 (class 1259 OID 16413)
-- Name: Rol; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."Rol" (
    id_rol integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public."Rol" OWNER TO candy;

--
-- TOC entry 223 (class 1259 OID 16426)
-- Name: Rol_Funcion; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."Rol_Funcion" (
    id_rol integer NOT NULL,
    id_funcion integer NOT NULL
);


ALTER TABLE public."Rol_Funcion" OWNER TO candy;

--
-- TOC entry 219 (class 1259 OID 16412)
-- Name: Rol_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."Rol_id_rol_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Rol_id_rol_seq" OWNER TO candy;

--
-- TOC entry 3721 (class 0 OID 0)
-- Dependencies: 219
-- Name: Rol_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."Rol_id_rol_seq" OWNED BY public."Rol".id_rol;


--
-- TOC entry 218 (class 1259 OID 16400)
-- Name: Sesion; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."Sesion" (
    id_sesion integer NOT NULL,
    "id_userN" integer NOT NULL,
    pid integer NOT NULL,
    inicio timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."Sesion" OWNER TO candy;

--
-- TOC entry 217 (class 1259 OID 16399)
-- Name: Sesion_id_sesion_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."Sesion_id_sesion_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Sesion_id_sesion_seq" OWNER TO candy;

--
-- TOC entry 3722 (class 0 OID 0)
-- Dependencies: 217
-- Name: Sesion_id_sesion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."Sesion_id_sesion_seq" OWNED BY public."Sesion".id_sesion;


--
-- TOC entry 247 (class 1259 OID 16631)
-- Name: TEXTO; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."TEXTO" (
    id_archivo integer NOT NULL,
    id_codec integer NOT NULL,
    cantidad_lineas integer,
    lenguaje character varying(30),
    resumen text
);


ALTER TABLE public."TEXTO" OWNER TO candy;

--
-- TOC entry 231 (class 1259 OID 16486)
-- Name: TIPO_ARCHIVO; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."TIPO_ARCHIVO" (
    id_tipo integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(200)
);


ALTER TABLE public."TIPO_ARCHIVO" OWNER TO candy;

--
-- TOC entry 230 (class 1259 OID 16485)
-- Name: TIPO_ARCHIVO_id_tipo_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."TIPO_ARCHIVO_id_tipo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."TIPO_ARCHIVO_id_tipo_seq" OWNER TO candy;

--
-- TOC entry 3723 (class 0 OID 0)
-- Dependencies: 230
-- Name: TIPO_ARCHIVO_id_tipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."TIPO_ARCHIVO_id_tipo_seq" OWNED BY public."TIPO_ARCHIVO".id_tipo;


--
-- TOC entry 233 (class 1259 OID 16493)
-- Name: TIPO_DISPOSITIVO; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."TIPO_DISPOSITIVO" (
    id_tipo_dispositivo integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion character varying(200)
);


ALTER TABLE public."TIPO_DISPOSITIVO" OWNER TO candy;

--
-- TOC entry 232 (class 1259 OID 16492)
-- Name: TIPO_DISPOSITIVO_id_tipo_dispositivo_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."TIPO_DISPOSITIVO_id_tipo_dispositivo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."TIPO_DISPOSITIVO_id_tipo_dispositivo_seq" OWNER TO candy;

--
-- TOC entry 3724 (class 0 OID 0)
-- Dependencies: 232
-- Name: TIPO_DISPOSITIVO_id_tipo_dispositivo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."TIPO_DISPOSITIVO_id_tipo_dispositivo_seq" OWNED BY public."TIPO_DISPOSITIVO".id_tipo_dispositivo;


--
-- TOC entry 226 (class 1259 OID 16457)
-- Name: UI; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."UI" (
    id_ui integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public."UI" OWNER TO candy;

--
-- TOC entry 225 (class 1259 OID 16456)
-- Name: UI_id_ui_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."UI_id_ui_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UI_id_ui_seq" OWNER TO candy;

--
-- TOC entry 3725 (class 0 OID 0)
-- Dependencies: 225
-- Name: UI_id_ui_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."UI_id_ui_seq" OWNED BY public."UI".id_ui;


--
-- TOC entry 237 (class 1259 OID 16507)
-- Name: USUARIO; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."USUARIO" (
    id_usuario integer NOT NULL,
    nombre character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    contrasena character varying(255) NOT NULL,
    fecha_registro date NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


ALTER TABLE public."USUARIO" OWNER TO candy;

--
-- TOC entry 236 (class 1259 OID 16506)
-- Name: USUARIO_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."USUARIO_id_usuario_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."USUARIO_id_usuario_seq" OWNER TO candy;

--
-- TOC entry 3726 (class 0 OID 0)
-- Dependencies: 236
-- Name: USUARIO_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."USUARIO_id_usuario_seq" OWNED BY public."USUARIO".id_usuario;


--
-- TOC entry 216 (class 1259 OID 16391)
-- Name: UserN; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."UserN" (
    "id_userN" integer NOT NULL,
    "nombreN" character varying(100) NOT NULL,
    "passwordN" character varying(255) NOT NULL
);


ALTER TABLE public."UserN" OWNER TO candy;

--
-- TOC entry 215 (class 1259 OID 16390)
-- Name: UserN_id_userN_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."UserN_id_userN_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."UserN_id_userN_seq" OWNER TO candy;

--
-- TOC entry 3727 (class 0 OID 0)
-- Dependencies: 215
-- Name: UserN_id_userN_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."UserN_id_userN_seq" OWNED BY public."UserN"."id_userN";


--
-- TOC entry 224 (class 1259 OID 16441)
-- Name: User_Rol; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."User_Rol" (
    "id_userN" integer NOT NULL,
    id_rol integer NOT NULL,
    fecha_desde timestamp without time zone,
    fecha_hasta timestamp without time zone
);


ALTER TABLE public."User_Rol" OWNER TO candy;

--
-- TOC entry 249 (class 1259 OID 16649)
-- Name: VERSION_ARCHIVO; Type: TABLE; Schema: public; Owner: candy
--

CREATE TABLE public."VERSION_ARCHIVO" (
    id_version integer NOT NULL,
    id_archivo integer NOT NULL,
    id_usuario integer NOT NULL,
    numero_version integer NOT NULL,
    tamano_bytes bigint NOT NULL,
    contenido_binario bytea NOT NULL,
    comentario character varying(300),
    fecha_version timestamp without time zone NOT NULL
);


ALTER TABLE public."VERSION_ARCHIVO" OWNER TO candy;

--
-- TOC entry 248 (class 1259 OID 16648)
-- Name: VERSION_ARCHIVO_id_version_seq; Type: SEQUENCE; Schema: public; Owner: candy
--

CREATE SEQUENCE public."VERSION_ARCHIVO_id_version_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."VERSION_ARCHIVO_id_version_seq" OWNER TO candy;

--
-- TOC entry 3728 (class 0 OID 0)
-- Dependencies: 248
-- Name: VERSION_ARCHIVO_id_version_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: candy
--

ALTER SEQUENCE public."VERSION_ARCHIVO_id_version_seq" OWNED BY public."VERSION_ARCHIVO".id_version;


--
-- TOC entry 3446 (class 2604 OID 16568)
-- Name: ARCHIVO id_archivo; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ARCHIVO" ALTER COLUMN id_archivo SET DEFAULT nextval('public."ARCHIVO_id_archivo_seq"'::regclass);


--
-- TOC entry 3436 (class 2604 OID 16482)
-- Name: CODEC id_codec; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."CODEC" ALTER COLUMN id_codec SET DEFAULT nextval('public."CODEC_id_codec_seq"'::regclass);


--
-- TOC entry 3442 (class 2604 OID 16520)
-- Name: DISPOSITIVO id_dispositivo; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."DISPOSITIVO" ALTER COLUMN id_dispositivo SET DEFAULT nextval('public."DISPOSITIVO_id_dispositivo_seq"'::regclass);


--
-- TOC entry 3439 (class 2604 OID 16503)
-- Name: ESTADO_ARCHIVO id_estado; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ESTADO_ARCHIVO" ALTER COLUMN id_estado SET DEFAULT nextval('public."ESTADO_ARCHIVO_id_estado_seq"'::regclass);


--
-- TOC entry 3449 (class 2604 OID 16671)
-- Name: ETIQUETA id_etiqueta; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ETIQUETA" ALTER COLUMN id_etiqueta SET DEFAULT nextval('public."ETIQUETA_id_etiqueta_seq"'::regclass);


--
-- TOC entry 3434 (class 2604 OID 16423)
-- Name: Funcion id_funcion; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."Funcion" ALTER COLUMN id_funcion SET DEFAULT nextval('public."Funcion_id_funcion_seq"'::regclass);


--
-- TOC entry 3444 (class 2604 OID 16538)
-- Name: REPOSITORIO id_repositorio; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."REPOSITORIO" ALTER COLUMN id_repositorio SET DEFAULT nextval('public."REPOSITORIO_id_repositorio_seq"'::regclass);


--
-- TOC entry 3433 (class 2604 OID 16416)
-- Name: Rol id_rol; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."Rol" ALTER COLUMN id_rol SET DEFAULT nextval('public."Rol_id_rol_seq"'::regclass);


--
-- TOC entry 3431 (class 2604 OID 16403)
-- Name: Sesion id_sesion; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."Sesion" ALTER COLUMN id_sesion SET DEFAULT nextval('public."Sesion_id_sesion_seq"'::regclass);


--
-- TOC entry 3437 (class 2604 OID 16489)
-- Name: TIPO_ARCHIVO id_tipo; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."TIPO_ARCHIVO" ALTER COLUMN id_tipo SET DEFAULT nextval('public."TIPO_ARCHIVO_id_tipo_seq"'::regclass);


--
-- TOC entry 3438 (class 2604 OID 16496)
-- Name: TIPO_DISPOSITIVO id_tipo_dispositivo; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."TIPO_DISPOSITIVO" ALTER COLUMN id_tipo_dispositivo SET DEFAULT nextval('public."TIPO_DISPOSITIVO_id_tipo_dispositivo_seq"'::regclass);


--
-- TOC entry 3435 (class 2604 OID 16460)
-- Name: UI id_ui; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."UI" ALTER COLUMN id_ui SET DEFAULT nextval('public."UI_id_ui_seq"'::regclass);


--
-- TOC entry 3440 (class 2604 OID 16510)
-- Name: USUARIO id_usuario; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."USUARIO" ALTER COLUMN id_usuario SET DEFAULT nextval('public."USUARIO_id_usuario_seq"'::regclass);


--
-- TOC entry 3430 (class 2604 OID 16394)
-- Name: UserN id_userN; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."UserN" ALTER COLUMN "id_userN" SET DEFAULT nextval('public."UserN_id_userN_seq"'::regclass);


--
-- TOC entry 3448 (class 2604 OID 16652)
-- Name: VERSION_ARCHIVO id_version; Type: DEFAULT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."VERSION_ARCHIVO" ALTER COLUMN id_version SET DEFAULT nextval('public."VERSION_ARCHIVO_id_version_seq"'::regclass);


--
-- TOC entry 3700 (class 0 OID 16565)
-- Dependencies: 244
-- Data for Name: ARCHIVO; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."ARCHIVO" (id_archivo, id_repositorio, id_tipo, id_usuario, id_dispositivo, id_estado, id_codec, nombre, formato, tamano_bytes, contenido_binario, hash_md5, fecha_subida, fecha_modif) FROM stdin;
\.


--
-- TOC entry 3708 (class 0 OID 16679)
-- Dependencies: 252
-- Data for Name: ARCHIVO_ETIQUETA; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."ARCHIVO_ETIQUETA" (id_archivo, id_etiqueta) FROM stdin;
\.


--
-- TOC entry 3685 (class 0 OID 16479)
-- Dependencies: 229
-- Data for Name: CODEC; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."CODEC" (id_codec, nombre, categoria, descripcion) FROM stdin;
\.


--
-- TOC entry 3702 (class 0 OID 16618)
-- Dependencies: 246
-- Data for Name: CONFIGURACION_APP; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."CONFIGURACION_APP" (id_archivo, nombre_app, version_app, datos_config, es_restaurado) FROM stdin;
\.


--
-- TOC entry 3695 (class 0 OID 16517)
-- Dependencies: 239
-- Data for Name: DISPOSITIVO; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."DISPOSITIVO" (id_dispositivo, id_usuario, id_tipo_dispositivo, nombre_dispositivo, modelo, version_so, fecha_registro, activo) FROM stdin;
\.


--
-- TOC entry 3691 (class 0 OID 16500)
-- Dependencies: 235
-- Data for Name: ESTADO_ARCHIVO; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."ESTADO_ARCHIVO" (id_estado, nombre, descripcion) FROM stdin;
\.


--
-- TOC entry 3707 (class 0 OID 16668)
-- Dependencies: 251
-- Data for Name: ETIQUETA; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."ETIQUETA" (id_etiqueta, id_usuario, nombre, color_hex) FROM stdin;
\.


--
-- TOC entry 3678 (class 0 OID 16420)
-- Dependencies: 222
-- Data for Name: Funcion; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."Funcion" (id_funcion, nombre) FROM stdin;
\.


--
-- TOC entry 3683 (class 0 OID 16463)
-- Dependencies: 227
-- Data for Name: Funcion_UI; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."Funcion_UI" (id_funcion, id_ui) FROM stdin;
\.


--
-- TOC entry 3701 (class 0 OID 16603)
-- Dependencies: 245
-- Data for Name: MULTIMEDIA; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."MULTIMEDIA" (id_archivo, tipo_medio, id_codec, duracion_segundos, resolucion, ubicacion_gps, camara) FROM stdin;
\.


--
-- TOC entry 3697 (class 0 OID 16535)
-- Dependencies: 241
-- Data for Name: REPOSITORIO; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."REPOSITORIO" (id_repositorio, id_usuario, nombre, descripcion, es_publico, fecha_creacion) FROM stdin;
\.


--
-- TOC entry 3698 (class 0 OID 16549)
-- Dependencies: 242
-- Data for Name: REPOSITORIO_COMPARTIDO; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."REPOSITORIO_COMPARTIDO" (id_repositorio, id_usuario_dest, permiso, fecha_compartido) FROM stdin;
\.


--
-- TOC entry 3676 (class 0 OID 16413)
-- Dependencies: 220
-- Data for Name: Rol; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."Rol" (id_rol, nombre) FROM stdin;
1	Admin
2	Usuario
3	Supervisor
\.


--
-- TOC entry 3679 (class 0 OID 16426)
-- Dependencies: 223
-- Data for Name: Rol_Funcion; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."Rol_Funcion" (id_rol, id_funcion) FROM stdin;
\.


--
-- TOC entry 3674 (class 0 OID 16400)
-- Dependencies: 218
-- Data for Name: Sesion; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."Sesion" (id_sesion, "id_userN", pid, inicio) FROM stdin;
1	2	85434	2026-04-01 19:29:27.227273
2	1	144211	2026-04-02 01:26:03.518502
3	1	144213	2026-04-02 01:26:04.268248
4	1	144233	2026-04-02 01:26:08.63997
5	1	144399	2026-04-02 01:26:27.31673
6	1	144879	2026-04-02 01:27:42.643303
7	2	145000	2026-04-02 01:28:08.810352
8	3	145070	2026-04-02 01:28:26.035697
9	1	146162	2026-04-02 01:32:42.851428
10	1	146248	2026-04-02 01:33:02.255781
11	2	146365	2026-04-02 01:33:21.616679
12	3	146466	2026-04-02 01:33:45.546374
13	2	9523	2026-04-02 08:25:34.186063
14	1	9672	2026-04-02 08:26:09.063382
\.


--
-- TOC entry 3703 (class 0 OID 16631)
-- Dependencies: 247
-- Data for Name: TEXTO; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."TEXTO" (id_archivo, id_codec, cantidad_lineas, lenguaje, resumen) FROM stdin;
\.


--
-- TOC entry 3687 (class 0 OID 16486)
-- Dependencies: 231
-- Data for Name: TIPO_ARCHIVO; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."TIPO_ARCHIVO" (id_tipo, nombre, descripcion) FROM stdin;
\.


--
-- TOC entry 3689 (class 0 OID 16493)
-- Dependencies: 233
-- Data for Name: TIPO_DISPOSITIVO; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."TIPO_DISPOSITIVO" (id_tipo_dispositivo, nombre, descripcion) FROM stdin;
\.


--
-- TOC entry 3682 (class 0 OID 16457)
-- Dependencies: 226
-- Data for Name: UI; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."UI" (id_ui, nombre) FROM stdin;
\.


--
-- TOC entry 3693 (class 0 OID 16507)
-- Dependencies: 237
-- Data for Name: USUARIO; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."USUARIO" (id_usuario, nombre, email, contrasena, fecha_registro, activo) FROM stdin;
\.


--
-- TOC entry 3672 (class 0 OID 16391)
-- Dependencies: 216
-- Data for Name: UserN; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."UserN" ("id_userN", "nombreN", "passwordN") FROM stdin;
1	admin	1234
2	candy	candy12345
3	karen	karen12345
\.


--
-- TOC entry 3680 (class 0 OID 16441)
-- Dependencies: 224
-- Data for Name: User_Rol; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."User_Rol" ("id_userN", id_rol, fecha_desde, fecha_hasta) FROM stdin;
1	1	2026-04-02 01:18:16.126437	\N
2	2	2026-04-02 01:18:16.126437	\N
3	3	2026-04-02 01:18:16.126437	\N
\.


--
-- TOC entry 3705 (class 0 OID 16649)
-- Dependencies: 249
-- Data for Name: VERSION_ARCHIVO; Type: TABLE DATA; Schema: public; Owner: candy
--

COPY public."VERSION_ARCHIVO" (id_version, id_archivo, id_usuario, numero_version, tamano_bytes, contenido_binario, comentario, fecha_version) FROM stdin;
\.


--
-- TOC entry 3729 (class 0 OID 0)
-- Dependencies: 243
-- Name: ARCHIVO_id_archivo_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."ARCHIVO_id_archivo_seq"', 1, false);


--
-- TOC entry 3730 (class 0 OID 0)
-- Dependencies: 228
-- Name: CODEC_id_codec_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."CODEC_id_codec_seq"', 1, false);


--
-- TOC entry 3731 (class 0 OID 0)
-- Dependencies: 238
-- Name: DISPOSITIVO_id_dispositivo_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."DISPOSITIVO_id_dispositivo_seq"', 1, false);


--
-- TOC entry 3732 (class 0 OID 0)
-- Dependencies: 234
-- Name: ESTADO_ARCHIVO_id_estado_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."ESTADO_ARCHIVO_id_estado_seq"', 1, false);


--
-- TOC entry 3733 (class 0 OID 0)
-- Dependencies: 250
-- Name: ETIQUETA_id_etiqueta_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."ETIQUETA_id_etiqueta_seq"', 1, false);


--
-- TOC entry 3734 (class 0 OID 0)
-- Dependencies: 221
-- Name: Funcion_id_funcion_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."Funcion_id_funcion_seq"', 1, false);


--
-- TOC entry 3735 (class 0 OID 0)
-- Dependencies: 240
-- Name: REPOSITORIO_id_repositorio_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."REPOSITORIO_id_repositorio_seq"', 1, false);


--
-- TOC entry 3736 (class 0 OID 0)
-- Dependencies: 219
-- Name: Rol_id_rol_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."Rol_id_rol_seq"', 1, false);


--
-- TOC entry 3737 (class 0 OID 0)
-- Dependencies: 217
-- Name: Sesion_id_sesion_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."Sesion_id_sesion_seq"', 14, true);


--
-- TOC entry 3738 (class 0 OID 0)
-- Dependencies: 230
-- Name: TIPO_ARCHIVO_id_tipo_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."TIPO_ARCHIVO_id_tipo_seq"', 1, false);


--
-- TOC entry 3739 (class 0 OID 0)
-- Dependencies: 232
-- Name: TIPO_DISPOSITIVO_id_tipo_dispositivo_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."TIPO_DISPOSITIVO_id_tipo_dispositivo_seq"', 1, false);


--
-- TOC entry 3740 (class 0 OID 0)
-- Dependencies: 225
-- Name: UI_id_ui_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."UI_id_ui_seq"', 1, false);


--
-- TOC entry 3741 (class 0 OID 0)
-- Dependencies: 236
-- Name: USUARIO_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."USUARIO_id_usuario_seq"', 1, false);


--
-- TOC entry 3742 (class 0 OID 0)
-- Dependencies: 215
-- Name: UserN_id_userN_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."UserN_id_userN_seq"', 3, true);


--
-- TOC entry 3743 (class 0 OID 0)
-- Dependencies: 248
-- Name: VERSION_ARCHIVO_id_version_seq; Type: SEQUENCE SET; Schema: public; Owner: candy
--

SELECT pg_catalog.setval('public."VERSION_ARCHIVO_id_version_seq"', 1, false);


--
-- TOC entry 3499 (class 2606 OID 16683)
-- Name: ARCHIVO_ETIQUETA ARCHIVO_ETIQUETA_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ARCHIVO_ETIQUETA"
    ADD CONSTRAINT "ARCHIVO_ETIQUETA_pkey" PRIMARY KEY (id_archivo, id_etiqueta);


--
-- TOC entry 3487 (class 2606 OID 16572)
-- Name: ARCHIVO ARCHIVO_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ARCHIVO"
    ADD CONSTRAINT "ARCHIVO_pkey" PRIMARY KEY (id_archivo);


--
-- TOC entry 3469 (class 2606 OID 16484)
-- Name: CODEC CODEC_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."CODEC"
    ADD CONSTRAINT "CODEC_pkey" PRIMARY KEY (id_codec);


--
-- TOC entry 3491 (class 2606 OID 16625)
-- Name: CONFIGURACION_APP CONFIGURACION_APP_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."CONFIGURACION_APP"
    ADD CONSTRAINT "CONFIGURACION_APP_pkey" PRIMARY KEY (id_archivo);


--
-- TOC entry 3481 (class 2606 OID 16523)
-- Name: DISPOSITIVO DISPOSITIVO_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."DISPOSITIVO"
    ADD CONSTRAINT "DISPOSITIVO_pkey" PRIMARY KEY (id_dispositivo);


--
-- TOC entry 3475 (class 2606 OID 16505)
-- Name: ESTADO_ARCHIVO ESTADO_ARCHIVO_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ESTADO_ARCHIVO"
    ADD CONSTRAINT "ESTADO_ARCHIVO_pkey" PRIMARY KEY (id_estado);


--
-- TOC entry 3497 (class 2606 OID 16673)
-- Name: ETIQUETA ETIQUETA_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ETIQUETA"
    ADD CONSTRAINT "ETIQUETA_pkey" PRIMARY KEY (id_etiqueta);


--
-- TOC entry 3467 (class 2606 OID 16467)
-- Name: Funcion_UI Funcion_UI_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."Funcion_UI"
    ADD CONSTRAINT "Funcion_UI_pkey" PRIMARY KEY (id_funcion, id_ui);


--
-- TOC entry 3459 (class 2606 OID 16425)
-- Name: Funcion Funcion_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."Funcion"
    ADD CONSTRAINT "Funcion_pkey" PRIMARY KEY (id_funcion);


--
-- TOC entry 3489 (class 2606 OID 16607)
-- Name: MULTIMEDIA MULTIMEDIA_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."MULTIMEDIA"
    ADD CONSTRAINT "MULTIMEDIA_pkey" PRIMARY KEY (id_archivo);


--
-- TOC entry 3485 (class 2606 OID 16553)
-- Name: REPOSITORIO_COMPARTIDO REPOSITORIO_COMPARTIDO_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."REPOSITORIO_COMPARTIDO"
    ADD CONSTRAINT "REPOSITORIO_COMPARTIDO_pkey" PRIMARY KEY (id_repositorio, id_usuario_dest);


--
-- TOC entry 3483 (class 2606 OID 16543)
-- Name: REPOSITORIO REPOSITORIO_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."REPOSITORIO"
    ADD CONSTRAINT "REPOSITORIO_pkey" PRIMARY KEY (id_repositorio);


--
-- TOC entry 3461 (class 2606 OID 16430)
-- Name: Rol_Funcion Rol_Funcion_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."Rol_Funcion"
    ADD CONSTRAINT "Rol_Funcion_pkey" PRIMARY KEY (id_rol, id_funcion);


--
-- TOC entry 3457 (class 2606 OID 16418)
-- Name: Rol Rol_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."Rol"
    ADD CONSTRAINT "Rol_pkey" PRIMARY KEY (id_rol);


--
-- TOC entry 3455 (class 2606 OID 16406)
-- Name: Sesion Sesion_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."Sesion"
    ADD CONSTRAINT "Sesion_pkey" PRIMARY KEY (id_sesion);


--
-- TOC entry 3493 (class 2606 OID 16637)
-- Name: TEXTO TEXTO_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."TEXTO"
    ADD CONSTRAINT "TEXTO_pkey" PRIMARY KEY (id_archivo);


--
-- TOC entry 3471 (class 2606 OID 16491)
-- Name: TIPO_ARCHIVO TIPO_ARCHIVO_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."TIPO_ARCHIVO"
    ADD CONSTRAINT "TIPO_ARCHIVO_pkey" PRIMARY KEY (id_tipo);


--
-- TOC entry 3473 (class 2606 OID 16498)
-- Name: TIPO_DISPOSITIVO TIPO_DISPOSITIVO_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."TIPO_DISPOSITIVO"
    ADD CONSTRAINT "TIPO_DISPOSITIVO_pkey" PRIMARY KEY (id_tipo_dispositivo);


--
-- TOC entry 3465 (class 2606 OID 16462)
-- Name: UI UI_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."UI"
    ADD CONSTRAINT "UI_pkey" PRIMARY KEY (id_ui);


--
-- TOC entry 3477 (class 2606 OID 16515)
-- Name: USUARIO USUARIO_email_key; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."USUARIO"
    ADD CONSTRAINT "USUARIO_email_key" UNIQUE (email);


--
-- TOC entry 3479 (class 2606 OID 16513)
-- Name: USUARIO USUARIO_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."USUARIO"
    ADD CONSTRAINT "USUARIO_pkey" PRIMARY KEY (id_usuario);


--
-- TOC entry 3451 (class 2606 OID 16398)
-- Name: UserN UserN_nombreN_key; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."UserN"
    ADD CONSTRAINT "UserN_nombreN_key" UNIQUE ("nombreN");


--
-- TOC entry 3453 (class 2606 OID 16396)
-- Name: UserN UserN_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."UserN"
    ADD CONSTRAINT "UserN_pkey" PRIMARY KEY ("id_userN");


--
-- TOC entry 3463 (class 2606 OID 16445)
-- Name: User_Rol User_Rol_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."User_Rol"
    ADD CONSTRAINT "User_Rol_pkey" PRIMARY KEY ("id_userN", id_rol);


--
-- TOC entry 3495 (class 2606 OID 16656)
-- Name: VERSION_ARCHIVO VERSION_ARCHIVO_pkey; Type: CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."VERSION_ARCHIVO"
    ADD CONSTRAINT "VERSION_ARCHIVO_pkey" PRIMARY KEY (id_version);


--
-- TOC entry 3526 (class 2606 OID 16684)
-- Name: ARCHIVO_ETIQUETA ARCHIVO_ETIQUETA_id_archivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ARCHIVO_ETIQUETA"
    ADD CONSTRAINT "ARCHIVO_ETIQUETA_id_archivo_fkey" FOREIGN KEY (id_archivo) REFERENCES public."ARCHIVO"(id_archivo);


--
-- TOC entry 3527 (class 2606 OID 16689)
-- Name: ARCHIVO_ETIQUETA ARCHIVO_ETIQUETA_id_etiqueta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ARCHIVO_ETIQUETA"
    ADD CONSTRAINT "ARCHIVO_ETIQUETA_id_etiqueta_fkey" FOREIGN KEY (id_etiqueta) REFERENCES public."ETIQUETA"(id_etiqueta);


--
-- TOC entry 3512 (class 2606 OID 16598)
-- Name: ARCHIVO ARCHIVO_id_codec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ARCHIVO"
    ADD CONSTRAINT "ARCHIVO_id_codec_fkey" FOREIGN KEY (id_codec) REFERENCES public."CODEC"(id_codec);


--
-- TOC entry 3513 (class 2606 OID 16588)
-- Name: ARCHIVO ARCHIVO_id_dispositivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ARCHIVO"
    ADD CONSTRAINT "ARCHIVO_id_dispositivo_fkey" FOREIGN KEY (id_dispositivo) REFERENCES public."DISPOSITIVO"(id_dispositivo);


--
-- TOC entry 3514 (class 2606 OID 16593)
-- Name: ARCHIVO ARCHIVO_id_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ARCHIVO"
    ADD CONSTRAINT "ARCHIVO_id_estado_fkey" FOREIGN KEY (id_estado) REFERENCES public."ESTADO_ARCHIVO"(id_estado);


--
-- TOC entry 3515 (class 2606 OID 16573)
-- Name: ARCHIVO ARCHIVO_id_repositorio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ARCHIVO"
    ADD CONSTRAINT "ARCHIVO_id_repositorio_fkey" FOREIGN KEY (id_repositorio) REFERENCES public."REPOSITORIO"(id_repositorio);


--
-- TOC entry 3516 (class 2606 OID 16578)
-- Name: ARCHIVO ARCHIVO_id_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ARCHIVO"
    ADD CONSTRAINT "ARCHIVO_id_tipo_fkey" FOREIGN KEY (id_tipo) REFERENCES public."TIPO_ARCHIVO"(id_tipo);


--
-- TOC entry 3517 (class 2606 OID 16583)
-- Name: ARCHIVO ARCHIVO_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ARCHIVO"
    ADD CONSTRAINT "ARCHIVO_id_usuario_fkey" FOREIGN KEY (id_usuario) REFERENCES public."USUARIO"(id_usuario);


--
-- TOC entry 3520 (class 2606 OID 16626)
-- Name: CONFIGURACION_APP CONFIGURACION_APP_id_archivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."CONFIGURACION_APP"
    ADD CONSTRAINT "CONFIGURACION_APP_id_archivo_fkey" FOREIGN KEY (id_archivo) REFERENCES public."ARCHIVO"(id_archivo);


--
-- TOC entry 3507 (class 2606 OID 16529)
-- Name: DISPOSITIVO DISPOSITIVO_id_tipo_dispositivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."DISPOSITIVO"
    ADD CONSTRAINT "DISPOSITIVO_id_tipo_dispositivo_fkey" FOREIGN KEY (id_tipo_dispositivo) REFERENCES public."TIPO_DISPOSITIVO"(id_tipo_dispositivo);


--
-- TOC entry 3508 (class 2606 OID 16524)
-- Name: DISPOSITIVO DISPOSITIVO_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."DISPOSITIVO"
    ADD CONSTRAINT "DISPOSITIVO_id_usuario_fkey" FOREIGN KEY (id_usuario) REFERENCES public."USUARIO"(id_usuario);


--
-- TOC entry 3525 (class 2606 OID 16674)
-- Name: ETIQUETA ETIQUETA_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."ETIQUETA"
    ADD CONSTRAINT "ETIQUETA_id_usuario_fkey" FOREIGN KEY (id_usuario) REFERENCES public."USUARIO"(id_usuario);


--
-- TOC entry 3505 (class 2606 OID 16468)
-- Name: Funcion_UI Funcion_UI_id_funcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."Funcion_UI"
    ADD CONSTRAINT "Funcion_UI_id_funcion_fkey" FOREIGN KEY (id_funcion) REFERENCES public."Funcion"(id_funcion);


--
-- TOC entry 3506 (class 2606 OID 16473)
-- Name: Funcion_UI Funcion_UI_id_ui_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."Funcion_UI"
    ADD CONSTRAINT "Funcion_UI_id_ui_fkey" FOREIGN KEY (id_ui) REFERENCES public."UI"(id_ui);


--
-- TOC entry 3518 (class 2606 OID 16608)
-- Name: MULTIMEDIA MULTIMEDIA_id_archivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."MULTIMEDIA"
    ADD CONSTRAINT "MULTIMEDIA_id_archivo_fkey" FOREIGN KEY (id_archivo) REFERENCES public."ARCHIVO"(id_archivo);


--
-- TOC entry 3519 (class 2606 OID 16613)
-- Name: MULTIMEDIA MULTIMEDIA_id_codec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."MULTIMEDIA"
    ADD CONSTRAINT "MULTIMEDIA_id_codec_fkey" FOREIGN KEY (id_codec) REFERENCES public."CODEC"(id_codec);


--
-- TOC entry 3510 (class 2606 OID 16554)
-- Name: REPOSITORIO_COMPARTIDO REPOSITORIO_COMPARTIDO_id_repositorio_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."REPOSITORIO_COMPARTIDO"
    ADD CONSTRAINT "REPOSITORIO_COMPARTIDO_id_repositorio_fkey" FOREIGN KEY (id_repositorio) REFERENCES public."REPOSITORIO"(id_repositorio);


--
-- TOC entry 3511 (class 2606 OID 16559)
-- Name: REPOSITORIO_COMPARTIDO REPOSITORIO_COMPARTIDO_id_usuario_dest_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."REPOSITORIO_COMPARTIDO"
    ADD CONSTRAINT "REPOSITORIO_COMPARTIDO_id_usuario_dest_fkey" FOREIGN KEY (id_usuario_dest) REFERENCES public."USUARIO"(id_usuario);


--
-- TOC entry 3509 (class 2606 OID 16544)
-- Name: REPOSITORIO REPOSITORIO_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."REPOSITORIO"
    ADD CONSTRAINT "REPOSITORIO_id_usuario_fkey" FOREIGN KEY (id_usuario) REFERENCES public."USUARIO"(id_usuario);


--
-- TOC entry 3501 (class 2606 OID 16436)
-- Name: Rol_Funcion Rol_Funcion_id_funcion_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."Rol_Funcion"
    ADD CONSTRAINT "Rol_Funcion_id_funcion_fkey" FOREIGN KEY (id_funcion) REFERENCES public."Funcion"(id_funcion);


--
-- TOC entry 3502 (class 2606 OID 16431)
-- Name: Rol_Funcion Rol_Funcion_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."Rol_Funcion"
    ADD CONSTRAINT "Rol_Funcion_id_rol_fkey" FOREIGN KEY (id_rol) REFERENCES public."Rol"(id_rol);


--
-- TOC entry 3500 (class 2606 OID 16407)
-- Name: Sesion Sesion_id_userN_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."Sesion"
    ADD CONSTRAINT "Sesion_id_userN_fkey" FOREIGN KEY ("id_userN") REFERENCES public."UserN"("id_userN");


--
-- TOC entry 3521 (class 2606 OID 16638)
-- Name: TEXTO TEXTO_id_archivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."TEXTO"
    ADD CONSTRAINT "TEXTO_id_archivo_fkey" FOREIGN KEY (id_archivo) REFERENCES public."ARCHIVO"(id_archivo);


--
-- TOC entry 3522 (class 2606 OID 16643)
-- Name: TEXTO TEXTO_id_codec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."TEXTO"
    ADD CONSTRAINT "TEXTO_id_codec_fkey" FOREIGN KEY (id_codec) REFERENCES public."CODEC"(id_codec);


--
-- TOC entry 3503 (class 2606 OID 16451)
-- Name: User_Rol User_Rol_id_rol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."User_Rol"
    ADD CONSTRAINT "User_Rol_id_rol_fkey" FOREIGN KEY (id_rol) REFERENCES public."Rol"(id_rol);


--
-- TOC entry 3504 (class 2606 OID 16446)
-- Name: User_Rol User_Rol_id_userN_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."User_Rol"
    ADD CONSTRAINT "User_Rol_id_userN_fkey" FOREIGN KEY ("id_userN") REFERENCES public."UserN"("id_userN");


--
-- TOC entry 3523 (class 2606 OID 16657)
-- Name: VERSION_ARCHIVO VERSION_ARCHIVO_id_archivo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."VERSION_ARCHIVO"
    ADD CONSTRAINT "VERSION_ARCHIVO_id_archivo_fkey" FOREIGN KEY (id_archivo) REFERENCES public."ARCHIVO"(id_archivo);


--
-- TOC entry 3524 (class 2606 OID 16662)
-- Name: VERSION_ARCHIVO VERSION_ARCHIVO_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: candy
--

ALTER TABLE ONLY public."VERSION_ARCHIVO"
    ADD CONSTRAINT "VERSION_ARCHIVO_id_usuario_fkey" FOREIGN KEY (id_usuario) REFERENCES public."USUARIO"(id_usuario);


-- Completed on 2026-04-04 19:21:38 -04

--
-- PostgreSQL database dump complete
--

\unrestrict BfMcPHbGSFR3BPRF4oQnkw1IFWTxxc01ER87XQlzZ6AsapZwj1fYzvYy9x5Es2N

