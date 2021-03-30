--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1 (Debian 13.1-1.pgdg100+1)
-- Dumped by pg_dump version 13.1 (Debian 13.1-1.pgdg100+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: casbin_rule; Type: TABLE; Schema: public; Owner: db
--

CREATE TABLE public.casbin_rule (
    id bigint NOT NULL,
    p_type character varying(40),
    v0 character varying(40),
    v1 character varying(40),
    v2 character varying(40),
    v3 character varying(40),
    v4 character varying(40),
    v5 character varying(40)
);


ALTER TABLE public.casbin_rule OWNER TO db;

--
-- Name: casbin_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: db
--

CREATE SEQUENCE public.casbin_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.casbin_rule_id_seq OWNER TO db;

--
-- Name: casbin_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db
--

ALTER SEQUENCE public.casbin_rule_id_seq OWNED BY public.casbin_rule.id;


--
-- Name: sys_authorities; Type: TABLE; Schema: public; Owner: db
--

CREATE TABLE public.sys_authorities (
    created_at timestamp with time zone,
    updated_at timestamp(0) with time zone,
    deleted_at timestamp(0) with time zone,
    authority_id character varying(90) NOT NULL,
    authority_name character varying(191),
    parent_id character varying(191)
);


ALTER TABLE public.sys_authorities OWNER TO db;

--
-- Name: COLUMN sys_authorities.authority_id; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_authorities.authority_id IS '角色ID';


--
-- Name: COLUMN sys_authorities.authority_name; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_authorities.authority_name IS '角色名';


--
-- Name: COLUMN sys_authorities.parent_id; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_authorities.parent_id IS '父角色ID';


--
-- Name: sys_authority_menus; Type: TABLE; Schema: public; Owner: db
--

CREATE TABLE public.sys_authority_menus (
    sys_authority_authority_id character varying(90),
    sys_base_menu_id numeric
);


ALTER TABLE public.sys_authority_menus OWNER TO db;

--
-- Name: COLUMN sys_authority_menus.sys_authority_authority_id; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_authority_menus.sys_authority_authority_id IS '角色id';


--
-- Name: sys_base_menu_parameters; Type: TABLE; Schema: public; Owner: db
--

CREATE TABLE public.sys_base_menu_parameters (
    id bigint NOT NULL,
    createed_at timestamp(0) with time zone,
    updateed_at timestamp(0) with time zone,
    deleteed_at timestamp(0) with time zone,
    sys_base_menu_id bigint,
    addtype character varying(191),
    addkey character varying(191),
    addvalue character varying(191)
);


ALTER TABLE public.sys_base_menu_parameters OWNER TO db;

--
-- Name: COLUMN sys_base_menu_parameters.addtype; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_base_menu_parameters.addtype IS '地址栏携带参数为params还是query';


--
-- Name: COLUMN sys_base_menu_parameters.addkey; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_base_menu_parameters.addkey IS '地址栏携带参数的key';


--
-- Name: COLUMN sys_base_menu_parameters.addvalue; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_base_menu_parameters.addvalue IS '地址栏携带参数的值';


--
-- Name: sys_base_menu_parameters_id_seq; Type: SEQUENCE; Schema: public; Owner: db
--

CREATE SEQUENCE public.sys_base_menu_parameters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_base_menu_parameters_id_seq OWNER TO db;

--
-- Name: sys_base_menu_parameters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db
--

ALTER SEQUENCE public.sys_base_menu_parameters_id_seq OWNED BY public.sys_base_menu_parameters.id;


--
-- Name: sys_base_menus; Type: TABLE; Schema: public; Owner: db
--

CREATE TABLE public.sys_base_menus (
    sys_base_menu_id bigint NOT NULL,
    createed_at timestamp(0) with time zone,
    updateed_at timestamp(0) with time zone,
    deleteed_at timestamp(0) with time zone,
    menu_level numeric,
    parent_id character varying(191),
    routerpath character varying(191),
    routername character varying(191),
    hidden boolean,
    component character varying(191),
    sort numeric,
    keep_alive boolean,
    default_menu boolean,
    title character varying(191),
    icon character varying(191)
);


ALTER TABLE public.sys_base_menus OWNER TO db;

--
-- Name: COLUMN sys_base_menus.parent_id; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_base_menus.parent_id IS '父菜单id';


--
-- Name: COLUMN sys_base_menus.routerpath; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_base_menus.routerpath IS '路由path';


--
-- Name: COLUMN sys_base_menus.routername; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_base_menus.routername IS '路由name';


--
-- Name: COLUMN sys_base_menus.hidden; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_base_menus.hidden IS '是否在列表隐藏';


--
-- Name: COLUMN sys_base_menus.component; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_base_menus.component IS '对应前端文件路径';


--
-- Name: COLUMN sys_base_menus.sort; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_base_menus.sort IS '排序标记';


--
-- Name: COLUMN sys_base_menus.keep_alive; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_base_menus.keep_alive IS '附加属性';


--
-- Name: COLUMN sys_base_menus.default_menu; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_base_menus.default_menu IS '附加属性';


--
-- Name: COLUMN sys_base_menus.title; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_base_menus.title IS '附加属性';


--
-- Name: COLUMN sys_base_menus.icon; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_base_menus.icon IS '附加属性';


--
-- Name: sys_base_menus_id_seq; Type: SEQUENCE; Schema: public; Owner: db
--

CREATE SEQUENCE public.sys_base_menus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_base_menus_id_seq OWNER TO db;

--
-- Name: sys_base_menus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db
--

ALTER SEQUENCE public.sys_base_menus_id_seq OWNED BY public.sys_base_menus.sys_base_menu_id;


--
-- Name: sys_jwt_blacklist; Type: TABLE; Schema: public; Owner: db
--

CREATE TABLE public.sys_jwt_blacklist (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    jwt text
);


ALTER TABLE public.sys_jwt_blacklist OWNER TO db;

--
-- Name: sys_jwt_blacklist_id_seq; Type: SEQUENCE; Schema: public; Owner: db
--

CREATE SEQUENCE public.sys_jwt_blacklist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_jwt_blacklist_id_seq OWNER TO db;

--
-- Name: sys_jwt_blacklist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db
--

ALTER SEQUENCE public.sys_jwt_blacklist_id_seq OWNED BY public.sys_jwt_blacklist.id;


--
-- Name: sys_operation_records; Type: TABLE; Schema: public; Owner: db
--

CREATE TABLE public.sys_operation_records (
    id bigint NOT NULL,
    createed_at timestamp(0) with time zone,
    updateed_at timestamp(0) with time zone,
    deleteed_at timestamp(0) with time zone,
    ip inet,
    method character varying(191),
    path character varying(191),
    status bigint,
    latency bigint,
    agent character varying,
    error_message character varying,
    body text,
    resp text,
    userid bigint
);


ALTER TABLE public.sys_operation_records OWNER TO db;

--
-- Name: COLUMN sys_operation_records.ip; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_operation_records.ip IS '请求ip';


--
-- Name: COLUMN sys_operation_records.method; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_operation_records.method IS '请求方法';


--
-- Name: COLUMN sys_operation_records.path; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_operation_records.path IS '请求路径';


--
-- Name: COLUMN sys_operation_records.status; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_operation_records.status IS '请求状态';


--
-- Name: COLUMN sys_operation_records.latency; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_operation_records.latency IS '延迟';


--
-- Name: COLUMN sys_operation_records.agent; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_operation_records.agent IS '代理';


--
-- Name: COLUMN sys_operation_records.error_message; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_operation_records.error_message IS '错误信息';


--
-- Name: COLUMN sys_operation_records.body; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_operation_records.body IS '请求Body';


--
-- Name: COLUMN sys_operation_records.resp; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_operation_records.resp IS '响应Body';


--
-- Name: COLUMN sys_operation_records.userid; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_operation_records.userid IS '用户id';


--
-- Name: sys_operation_records_id_seq; Type: SEQUENCE; Schema: public; Owner: db
--

CREATE SEQUENCE public.sys_operation_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_operation_records_id_seq OWNER TO db;

--
-- Name: sys_operation_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db
--

ALTER SEQUENCE public.sys_operation_records_id_seq OWNED BY public.sys_operation_records.id;


--
-- Name: sys_users; Type: TABLE; Schema: public; Owner: db
--

CREATE TABLE public.sys_users (
    id bigint NOT NULL,
    createed_at timestamp(0) with time zone,
    updateed_at timestamp(0) with time zone,
    deleteed_at timestamp(0) with time zone,
    uuid uuid,
    username character varying(191),
    password character varying(191),
    nick_name character varying(191) DEFAULT 'sysuser'::character varying,
    header_img character varying(191),
    authority_id character varying(90) DEFAULT 888
);


ALTER TABLE public.sys_users OWNER TO db;

--
-- Name: COLUMN sys_users.uuid; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_users.uuid IS '用户UUID';


--
-- Name: COLUMN sys_users.username; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_users.username IS '用户登录名';


--
-- Name: COLUMN sys_users.password; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_users.password IS '用户登录密码';


--
-- Name: COLUMN sys_users.nick_name; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_users.nick_name IS '用户昵称';


--
-- Name: COLUMN sys_users.header_img; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_users.header_img IS '用户头像';


--
-- Name: COLUMN sys_users.authority_id; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_users.authority_id IS '用户角色ID';


--
-- Name: sys_users_id_seq; Type: SEQUENCE; Schema: public; Owner: db
--

CREATE SEQUENCE public.sys_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_users_id_seq OWNER TO db;

--
-- Name: sys_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db
--

ALTER SEQUENCE public.sys_users_id_seq OWNED BY public.sys_users.id;


--
-- Name: casbin_rule id; Type: DEFAULT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.casbin_rule ALTER COLUMN id SET DEFAULT nextval('public.casbin_rule_id_seq'::regclass);


--
-- Name: sys_base_menu_parameters id; Type: DEFAULT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.sys_base_menu_parameters ALTER COLUMN id SET DEFAULT nextval('public.sys_base_menu_parameters_id_seq'::regclass);


--
-- Name: sys_base_menus sys_base_menu_id; Type: DEFAULT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.sys_base_menus ALTER COLUMN sys_base_menu_id SET DEFAULT nextval('public.sys_base_menus_id_seq'::regclass);


--
-- Name: sys_jwt_blacklist id; Type: DEFAULT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.sys_jwt_blacklist ALTER COLUMN id SET DEFAULT nextval('public.sys_jwt_blacklist_id_seq'::regclass);


--
-- Name: sys_operation_records id; Type: DEFAULT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.sys_operation_records ALTER COLUMN id SET DEFAULT nextval('public.sys_operation_records_id_seq'::regclass);


--
-- Name: sys_users id; Type: DEFAULT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.sys_users ALTER COLUMN id SET DEFAULT nextval('public.sys_users_id_seq'::regclass);


--
-- Data for Name: casbin_rule; Type: TABLE DATA; Schema: public; Owner: db
--

COPY public.casbin_rule (id, p_type, v0, v1, v2, v3, v4, v5) FROM stdin;
\.


--
-- Data for Name: sys_authorities; Type: TABLE DATA; Schema: public; Owner: db
--

COPY public.sys_authorities (created_at, updated_at, deleted_at, authority_id, authority_name, parent_id) FROM stdin;
2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	888	普通用户	0
2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	8881	普通用户子角色	888
2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	9528	测试角色	0
\.


--
-- Data for Name: sys_authority_menus; Type: TABLE DATA; Schema: public; Owner: db
--

COPY public.sys_authority_menus (sys_authority_authority_id, sys_base_menu_id) FROM stdin;
888	1
888	2
888	3
888	4
888	5
888	6
888	7
888	8
888	9
888	10
888	11
888	12
888	13
888	14
888	15
888	16
888	17
888	18
888	19
888	20
888	21
888	22
888	23
888	24
888	25
888	26
888	27
888	28
888	29
8881	1
8881	2
8881	8
9528	1
9528	2
9528	3
9528	4
9528	5
9528	6
9528	7
9528	8
9528	9
9528	10
9528	11
9528	12
9528	14
9528	15
9528	16
9528	17
\.


--
-- Data for Name: sys_base_menu_parameters; Type: TABLE DATA; Schema: public; Owner: db
--

COPY public.sys_base_menu_parameters (id, createed_at, updateed_at, deleteed_at, sys_base_menu_id, addtype, addkey, addvalue) FROM stdin;
5	2021-01-21 05:33:02+00	2021-01-21 05:33:02+00	\N	8	test12	test11	test13
\.


--
-- Data for Name: sys_base_menus; Type: TABLE DATA; Schema: public; Owner: db
--

COPY public.sys_base_menus (sys_base_menu_id, createed_at, updateed_at, deleteed_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon) FROM stdin;
15	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	14	autoCode	autoCode	f	view/systemTools/autoCode/index.vue	1	t	f	代码生成器	cpu
1	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	0	dashboard	dashboard	f	view/dashboard/index.vue	1	f	f	仪表盘	setting
3	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	0	admin	superAdmin	f	view/superAdmin/index.vue	3	f	f	超级管理员	user-solid
4	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	3	authority	authority	f	view/superAdmin/authority/authority.vue	1	f	f	角色管理	s-custom
5	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	3	menu	menu	f	view/superAdmin/menu/menu.vue	2	t	f	菜单管理	s-order
6	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	3	api	api	f	view/superAdmin/api/api.vue	3	t	f	api管理	s-platform
7	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	3	user	user	f	view/superAdmin/user/user.vue	4	f	f	用户管理	coordinate
8	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	0	person	person	t	view/person/person.vue	4	f	f	个人信息	message-solid
9	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	0	example	example	f	view/example/index.vue	6	f	f	示例文件	s-management
10	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	9	excel	excel	f	view/example/excel/excel.vue	4	f	f	excel导入导出	s-marketing
11	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	9	upload	upload	f	view/example/upload/upload.vue	5	f	f	上传下载	upload
12	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	9	breakpoint	breakpoint	f	view/example/breakpoint/breakpoint.vue	6	f	f	断点续传	upload
13	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	9	customer	customer	f	view/example/customer/customer.vue	7	f	f	客户列表（资源示例）	s-custom
14	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	0	systemTools	systemTools	f	view/systemTools/index.vue	5	f	f	系统工具	s-cooperation
16	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	14	formCreate	formCreate	f	view/systemTools/formCreate/index.vue	2	t	f	表单生成器	magic-stick
17	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	14	system	system	f	view/systemTools/system/system.vue	3	f	f	系统配置	s-operation
18	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	3	dictionary	dictionary	f	view/superAdmin/dictionary/sysDictionary.vue	5	f	f	字典管理	notebook-2
19	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	3	dictionaryDetail/:id	dictionaryDetail	t	view/superAdmin/dictionary/sysDictionaryDetail.vue	1	f	f	字典详情	s-order
20	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	3	operation	operation	f	view/superAdmin/operation/sysOperationRecord.vue	6	f	f	操作历史	time
21	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	9	simpleUploader	simpleUploader	f	view/example/simpleUploader/simpleUploader	6	f	f	断点续传（插件版）	upload
23	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	0	state	state	f	view/system/state.vue	6	f	f	服务器状态	cloudy
24	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	0	workflow	workflow	f	view/workflow/index.vue	5	f	f	工作流功能	phone
25	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	24	workflowCreate	workflowCreate	f	view/workflow/workflowCreate/workflowCreate.vue	0	f	f	工作流绘制	circle-plus
26	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	24	workflowProcess	workflowProcess	f	view/workflow/workflowProcess/workflowProcess.vue	0	f	f	工作流列表	s-cooperation
27	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	24	workflowUse	workflowUse	t	view/workflow/workflowUse/workflowUse.vue	0	f	f	使用工作流	video-play
28	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	24	started	started	f	view/workflow/userList/started.vue	0	f	f	我发起的	s-order
29	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	24	need	need	f	view/workflow/userList/need.vue	0	f	f	我的待办	s-platform
2	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	0	about	about	f	view/about/index.vue	7	f	f	关于我们	info
22	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	0	master	master	f	/	0	f	f	官方网站	s-home
\.


--
-- Data for Name: sys_jwt_blacklist; Type: TABLE DATA; Schema: public; Owner: db
--

COPY public.sys_jwt_blacklist (id, created_at, updated_at, deleted_at, jwt) FROM stdin;
46	2021-02-03 08:31:32.957255+00	2021-02-03 08:31:32.957255+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEyOTQ1MzY1LCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyMzM5NTY1fQ.2B_WjdX10xf2jpBI5fKriHQpigroFXZXjB3eNJlMgow
47	2021-02-03 08:32:28.396726+00	2021-02-03 08:32:28.396726+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEyOTQ1ODkyLCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyMzQwMDkyfQ.NkYoTfvxdhYImSH_NdGsXAiGwyoczueE2lN6Xy_X7DQ
48	2021-02-03 08:32:44.902387+00	2021-02-03 08:32:44.902387+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEyOTQ1OTQ4LCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyMzQwMTQ4fQ.pLPQ83gIjOzKH05pLQigwMQ9k-GstO7Y2ReQvWF6TD8
49	2021-02-03 08:35:51.295649+00	2021-02-03 08:35:51.295649+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEyOTQ1OTY0LCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyMzQwMTY0fQ.1MzkVxhFs26VTjRPHEqOyTWWKhcyVGn3wWHveXzSp_o
50	2021-02-04 02:53:11.85999+00	2021-02-04 02:53:11.85999+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEyOTQ2MTUxLCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyMzQwMzUxfQ.NnQ105AVbRs4LPKbffUxEpjVjeZlrNQj16b7J2f1xyE
51	2021-02-04 02:53:19.104656+00	2021-02-04 02:53:19.104656+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEzMDExOTkxLCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyNDA2MTkxfQ.GfLfECZYYYw0RjoU26git1p4pM_exzMrjnEf_swCEaE
52	2021-02-04 03:35:57.55535+00	2021-02-04 03:35:57.55535+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEzMDExOTk5LCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyNDA2MTk5fQ.B9taU-5dvJFsCEX_grBxG4H8HCqcOIYc16FrcXROpe4
53	2021-02-04 03:51:22.92131+00	2021-02-04 03:51:22.92131+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEzMDE0NTU3LCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyNDA4NzU3fQ.8ZDNCyOk4KvWJz_MK3AIVPN0GvQIIwECD08RNSIdkkE
54	2021-02-04 03:57:08.407448+00	2021-02-04 03:57:08.407448+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEzMDE1NDgyLCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyNDA5NjgyfQ.lMjbgZVZYtQK3xkIZUws6rlcJNtaiKwWKrsdOTkDoX0
55	2021-02-04 06:16:19.412118+00	2021-02-04 06:16:19.412118+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEzMDE1ODI4LCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyNDEwMDI4fQ.SHf82FlmhXwMabCvSogGirnsxjP1m0lY5jGvYxDp7Yw
56	2021-02-04 06:19:06.573422+00	2021-02-04 06:19:06.573422+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEzMDI0MTc5LCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyNDE4Mzc5fQ.qljYkVt-yRMw6BMwbub-mEQXRDhlbjrD_fkf4ZlGQlo
57	2021-02-04 06:28:49.63013+00	2021-02-04 06:28:49.63013+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEzMDI0MzQ2LCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyNDE4NTQ2fQ.oPFm_u0ituezaJoXQpKROyfP4X9J_ZyP2soAicD8uYw
58	2021-02-04 06:56:00.463321+00	2021-02-04 06:56:00.463321+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEzMDI0OTI5LCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyNDE5MTI5fQ.upwq3trbhuym7a6OxYFVLimkZ8l2rzAiTNPDc4PPZRk
59	2021-02-04 07:10:18.29636+00	2021-02-04 07:10:18.29636+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEzMDI2NTYwLCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyNDIwNzYwfQ.JIgWyQ5tqOT4bN31EpIF1tEikQQ50SVYZ7ri3KCnEJ0
60	2021-02-04 07:12:57.632518+00	2021-02-04 07:12:57.632518+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEzMDI3NDE4LCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyNDIxNjE4fQ.e9UVQjEKCocI49Ei4cJPZQwarwdfIxy1KBxX3z3jAco
61	2021-02-04 07:14:38.467626+00	2021-02-04 07:14:38.467626+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoibHprIiwiTmlja05hbWUiOiJ0dHR0IiwiQXV0aG9yaXR5SWQiOiI4ODgiLCJCdWZmZXJUaW1lIjo4NjQwMCwiZXhwIjoxNjEzMDI3NTc3LCJpc3MiOiJ0b21lIiwibmJmIjoxNjEyNDIxNzc3fQ.R-zO8cDstvWnJ63rPn0rCqxbt9-ed77_yfdAIe7PrJc
62	2021-02-04 07:21:49.82127+00	2021-02-04 07:21:49.82127+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMjgwNDksImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjIyNDl9.7Q6XCsp2h2sRKTdvZkKwOsGTMOQy-1AVn_XjruizE9s
63	2021-02-04 07:34:08.211511+00	2021-02-04 07:34:08.211511+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMjgxMDksImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjIzMDl9.OYzZoXL9bJjeuRgWwR-gLaiYhJrifQbY_voiKslb2oE
64	2021-02-04 07:54:54.680844+00	2021-02-04 07:54:54.680844+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMjg4NDgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjMwNDh9.MnbuVryo0Mt6K77DQKIIhJttm_15sqniEOjL5mFkTyo
65	2021-02-04 08:00:41.182258+00	2021-02-04 08:00:41.182258+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzAwOTQsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjQyOTR9.ZfYQTCZp3H5go81Ynco9NYtp3jKvtIzP30riuYyF1CI
66	2021-02-04 08:01:13.741413+00	2021-02-04 08:01:13.741413+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzA0NDEsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjQ2NDF9.mywOgaHz38eSxepEfKiJj6V8XRVOSGWnPTEp-Hf-MS8
67	2021-02-04 08:01:34.241758+00	2021-02-04 08:01:34.241758+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzA0NzMsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjQ2NzN9.lvrTfckeeNIWJm-z3gEpBC8eqi_x1PAwBdqNP6eFZKM
68	2021-02-04 08:06:12.895811+00	2021-02-04 08:06:12.895811+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzA0OTQsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjQ2OTR9.QfRaOjaNI0ccFXTZwjqTM6IgWYOGWtfQ1oHcaRf1oDE
69	2021-02-04 08:25:39.676305+00	2021-02-04 08:25:39.676305+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzA3NzIsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjQ5NzJ9.h38-Xm8z6iIPedJO8R1gA99M6g31v1ORP9oBN1WTBG8
70	2021-02-04 08:26:21.414205+00	2021-02-04 08:26:21.414205+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzE5MzksImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjYxMzl9.DAQSkm8kwm5frxQEj189fEX8H9hCQcu80GzXgrUrPvs
71	2021-02-04 08:26:25.9481+00	2021-02-04 08:26:25.9481+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzE5ODEsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjYxODF9.8qwiGWT-rvAWX0ohvtlDfCN9mmbRoegHZ6SJYUCXFCU
72	2021-02-04 08:27:04.585239+00	2021-02-04 08:27:04.585239+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzE5ODUsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjYxODV9.Y4LsYb3T6m-drPYTGZ28gJ99vwJiedU9gw_EFX5hfzE
73	2021-02-04 08:27:26.506806+00	2021-02-04 08:27:26.506806+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzIwMjQsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjYyMjR9.0l_fjKxuKEeBEVSLV0PSwPV6YhrrZBxR6HabGzngdZg
74	2021-02-04 08:27:48.667203+00	2021-02-04 08:27:48.667203+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzIwNDYsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjYyNDZ9.qD2fgV6t0QPwCz5SZOiY5JiNsmcgjDqQ0o7ukefBcVM
75	2021-02-04 08:28:40.994348+00	2021-02-04 08:28:40.994348+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzIwNjgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjYyNjh9.vO-7lKBjZvL64rvM3yAITP2kVM3LjEYBh76uyVPSGyk
76	2021-02-04 08:37:29.171094+00	2021-02-04 08:37:29.171094+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzIxMjAsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjYzMjB9.iJK5PgPmEwxej6pdcnsTDXxWDFX-OM-GL6xsHxMeDuo
77	2021-02-04 08:38:13.581535+00	2021-02-04 08:38:13.581535+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzI2NDksImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjY4NDl9.9HhNWVex0EjhJhgrWcQwiBQfkRtYLEjiDzw4uK0_k6M
78	2021-02-04 08:41:42.545341+00	2021-02-04 08:41:42.545341+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzI2OTMsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjY4OTN9.30IwgTDxjXTG2L3LCSzGn8Z7vatwk0Angj7m-sUk4-Y
79	2021-02-04 09:07:58.440602+00	2021-02-04 09:07:58.440602+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzI5MDIsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjcxMDJ9.YV4X1hRh6FUdk9heXqW3qc8hHn66pxN3iOj6ILg-VP0
80	2021-02-04 09:08:46.618726+00	2021-02-04 09:08:46.618726+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzQ0NzgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0Mjg2Nzh9.aIP16jyycyBOD37ADJAKbvR9WDO3TMMnyvxkMQ6B9wM
81	2021-02-04 09:15:33.85847+00	2021-02-04 09:15:33.85847+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzQ1MjYsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0Mjg3MjZ9.cR3KjEHrbTpz7qxCugHZax2wLKgJhX9A1bfgJORVJXk
82	2021-02-04 09:17:29.301927+00	2021-02-04 09:17:29.301927+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzQ5MzMsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjkxMzN9.DvGhYWjuT8FkMGYJ_8Ze8ZWoE26Kuh0it8WeiOojd9c
83	2021-02-04 09:18:48.981463+00	2021-02-04 09:18:48.981463+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzUwNDksImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjkyNDl9.tcY85SnxWO-cqN8gL9bWeDMek_dg3_50lu62_VOn1uE
84	2021-02-04 09:19:32.198297+00	2021-02-04 09:19:32.198297+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzUxMjgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjkzMjh9.maLwxUwsEmx-ypd_elrYApNPW7puk4SvdOkGwpJIJdA
85	2021-02-04 09:23:21.971417+00	2021-02-04 09:23:21.971417+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzUxNzIsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MjkzNzJ9.meEoLfIF9E7eryryD2FJkJ4SwmVLQ5kqVH3SgLkou24
86	2021-02-04 09:25:28.972085+00	2021-02-04 09:25:28.972085+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzU0MDEsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0Mjk2MDF9.NHud4-pzLIEsOsqAJ0w4Pfx2WcX6qILsafgTrvwmLDU
87	2021-02-04 09:39:24.172684+00	2021-02-04 09:39:24.172684+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzU1MjgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0Mjk3Mjh9.2LA22BjVxSPKHbbBlq8ZIYPHvf44mLsMttnxZX2Gv6A
88	2021-02-04 09:41:09.271086+00	2021-02-04 09:41:09.271086+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzYzNjQsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MzA1NjR9.OGSuFLn2K-Rx5q9PmQWN4nWUJO-jQx2X_PbMsmhg-hM
89	2021-02-04 10:09:47.7098+00	2021-02-04 10:09:47.7098+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzY0NjksImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MzA2Njl9.mN-uZsk4HsV4fCzKWBRbKU96Lh_etW4Z5YBSfldRlEA
90	2021-02-04 10:16:16.543445+00	2021-02-04 10:16:16.543445+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzgxODcsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MzIzODd9.S1oVbsQWSBsRwscuiFwJmwb5KMuZIHvZ-sdUrHXBqcw
91	2021-02-04 10:22:49.514488+00	2021-02-04 10:22:49.514488+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzg1NzYsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MzI3NzZ9.QhTGb2FnxfBfPLZbWaLj8mEmj8ShspGf7kferIXk5e8
92	2021-02-05 02:04:23.38768+00	2021-02-05 02:04:23.38768+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwMzg5NjksImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0MzMxNjl9.zr1DWGnEGwCcO1SBKltIaw0ulJ6KCbpboRe7pzuuc4k
93	2021-02-05 02:05:32.718659+00	2021-02-05 02:05:32.718659+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwOTU0NjMsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0ODk2NjN9.gXdlIcqqHZ-tEhj9uZqpfoP2nlVo_J-PBNvYI-idLcE
94	2021-02-05 02:33:09.750307+00	2021-02-05 02:33:09.750307+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwOTU1MzIsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0ODk3MzJ9.dY-E1SraQm_UH9Xi2FrLdqjbExTDYoF-TMKnPOxZepQ
95	2021-02-05 02:37:55.59156+00	2021-02-05 02:37:55.59156+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwOTcxODksImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0OTEzODl9.Se-Kjjrd3l0tVSEIpDXrc02GUJzJ5ZA1TAmU5Pgo_A4
96	2021-02-08 03:25:56.492972+00	2021-02-08 03:25:56.492972+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMwOTc0NzUsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI0OTE2NzV9.3BqmDS46A0ZJTLs32m2nRB_uJ398t7AuG0YOWLCSHJA
97	2021-02-08 03:26:40.858218+00	2021-02-08 03:26:40.858218+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNTk1NTYsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NTM3NTZ9.RrQki-3aL2mgadqYwsPMIzFvT6eSSCI09o9uz5K_ojU
98	2021-02-08 03:27:47.302525+00	2021-02-08 03:27:47.302525+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNTk2MDAsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NTM4MDB9.pEqUOEeXoZscMfeP5T9mO7HW98yyA_hf3Il5OvU_vwI
99	2021-02-08 03:27:59.240547+00	2021-02-08 03:27:59.240547+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNTk2NjcsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NTM4Njd9.hXvguitcrHRO3ssdIxSERQ_GkAiNnF_PEcGP9SozPW8
100	2021-02-08 03:31:55.060418+00	2021-02-08 03:31:55.060418+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNTk2NzksImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NTM4Nzl9.ov4l21_NK5rzqxMKk4YXLMQj0OTcvP4wTnzr1dlFjd0
101	2021-02-08 03:34:14.826813+00	2021-02-08 03:34:14.826813+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNTk5MTUsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NTQxMTV9._Bd3uKn9jICo7ZTAnbsVavGHjk50hLJV8BAKAK9ZE_w
102	2021-02-08 03:38:28.32703+00	2021-02-08 03:38:28.32703+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNjAwNTQsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NTQyNTR9.VCmnvJucNooA0Qhkb9ySqn7zUCxYbPxmyZggL__Cx_E
103	2021-02-08 03:43:58.532874+00	2021-02-08 03:43:58.532874+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNjAzMDgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NTQ1MDh9.racsttZco9ZGWH_O7frgMRJr-hAkAZMAprWR2yIYHHU
104	2021-02-08 08:03:38.121335+00	2021-02-08 08:03:38.121335+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNjA2MzgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NTQ4Mzh9.cE72cGa4DPxhpkvPOFr-Rs_mvIm1mJ5Nd3MNK3W2wns
105	2021-02-08 08:03:48.439657+00	2021-02-08 08:03:48.439657+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNzYyMTgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NzA0MTh9.dhqhPCSU0t0Yqa6IRX7Pyrh2ir2aE0DpKSN6DzwKSMo
106	2021-02-08 08:04:40.798091+00	2021-02-08 08:04:40.798091+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNzYyMjgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NzA0Mjh9.JjBLAf5uITBUK0XyYUuG9XrysaWg8NZzKX4gCmKusfo
107	2021-02-08 08:21:21.898306+00	2021-02-08 08:21:21.898306+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNzYyODAsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NzA0ODB9.CyBg44bRx0l2THHD6DPeFTqP4dcFQXknlTHNY68k-X0
108	2021-02-08 08:27:11.341865+00	2021-02-08 08:27:11.341865+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNzcyODEsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NzE0ODF9.lNHAs4XcUAoa57lBW2T7bvRIQVGxssWMNfly93Sgbfs
109	2021-02-08 09:03:22.035905+00	2021-02-08 09:03:22.035905+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNzc2MzEsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NzE4MzF9.UXI3nDOzGGNKqd9SJ_zPkVtr14OzIIEUhpXR1CeSV7c
110	2021-02-08 09:05:53.059341+00	2021-02-08 09:05:53.059341+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNzk4MDIsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NzQwMDJ9.00CuH1A1Jo093Sz7_UI4XnrYAzVWrD_JgGfN2pZu--0
111	2021-02-08 09:17:47.855543+00	2021-02-08 09:17:47.855543+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzNzk5NTMsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NzQxNTN9.DerqRI-07LLS4CyuHwkfPkRHrumiwLLMK9x3jvJ0nrU
112	2021-02-08 09:18:19.942075+00	2021-02-08 09:18:19.942075+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTMzODA2NjcsImlzcyI6InRvbWUiLCJuYmYiOjE2MTI3NzQ4Njd9.0qTEVv8IczUyfuhLs6o0sUIFpN90rKUX937_KsrfCi0
113	2021-02-19 06:36:52.65362+00	2021-02-19 06:36:52.65362+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjEwODcsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MTUyODd9.oNqR7YM9YIiks4nZPARK5ljA-j6Q0jvqOHAYpxqdDYM
114	2021-02-19 06:56:49.415502+00	2021-02-19 06:56:49.415502+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjE0MTIsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MTU2MTJ9.Tb9qfAATBJDItfsDrVaBtwQ4z4F8g0B4z0UUksj91SU
115	2021-02-19 07:02:10.16838+00	2021-02-19 07:02:10.16838+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjI2MDksImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MTY4MDl9.ZYSq4CYavn9Qz5-0qZ6wyYDpPt4ar9jYZtpmERPMkQk
116	2021-02-19 07:03:05.75802+00	2021-02-19 07:03:05.75802+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjI5MzAsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MTcxMzB9.bepb7fJOphCmEudIlTFvbqVR4r5YlBrPRRpyj8Y3f-k
117	2021-02-19 07:03:49.116494+00	2021-02-19 07:03:49.116494+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjI5ODUsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MTcxODV9.UCWjKbE1FqdUHm-F07MAbtO5Xkhv8d7UYmWt2vqGrWc
118	2021-02-19 07:06:00.066943+00	2021-02-19 07:06:00.066943+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjMwMjksImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MTcyMjl9.oZcawEis0fTDv4WusRegLhhr3icIgLqFIhcLB0k32bI
119	2021-02-19 07:11:44.648968+00	2021-02-19 07:11:44.648968+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjMxNjAsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MTczNjB9.0GlJLicl0y2Rfbzfq2Udx1u7rcmq21XH2eZ_1SsDuQY
120	2021-02-19 07:12:53.775933+00	2021-02-19 07:12:53.775933+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjM1MDQsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MTc3MDR9._7vCUYurOF5ej8QxNnjToyXU221IKyaj-io5RC6M2ho
121	2021-02-19 07:24:19.105671+00	2021-02-19 07:24:19.105671+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjM1NzMsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MTc3NzN9.SN_7lWRygN1tEWjvMkSLYzuYkYEt93MpA20DFoQ78c8
122	2021-02-19 07:59:01.776399+00	2021-02-19 07:59:01.776399+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjQyNTksImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MTg0NTl9.Cqxp_d_sFVVFP4iK_mkL9uAID_Rpgv0e4wnnxGwuGgM
123	2021-02-19 08:03:24.572376+00	2021-02-19 08:03:24.572376+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjYzNDEsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MjA1NDF9.4bifthMybZdoQmQe2gbTNvdcODTSm7j-AQikBG9q70g
124	2021-02-19 08:05:41.366117+00	2021-02-19 08:05:41.366117+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjY2MDQsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MjA4MDR9.o-13TggGC9HGH5UDLGLTxphcHs7zvlmYf50tbsPGJqA
125	2021-02-19 08:25:25.630628+00	2021-02-19 08:25:25.630628+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjY3NDEsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MjA5NDF9.RfnrDzr4KYNShsrX_gfxoU7rQiS35g50Bkb947ksrHM
126	2021-02-19 08:41:36.688125+00	2021-02-19 08:41:36.688125+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjc5MjUsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MjIxMjV9.tuISEKknVvq8YVYsKvseGax6XUYhCwzXM20aLD3Iz08
127	2021-02-19 08:43:38.417064+00	2021-02-19 08:43:38.417064+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjg4OTYsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MjMwOTZ9.RNlaR38aalVLaFTpBLekWzacAc-LNTNI-mzxh1YOe5k
128	2021-02-19 08:44:26.826152+00	2021-02-19 08:44:26.826152+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjkwMTgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MjMyMTh9.P36w0JdvMK-eZwfl7ZaVCVJ_LhcABItj-IJA3q9XLTU
129	2021-02-19 09:03:14.69679+00	2021-02-19 09:03:14.69679+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMjkwNjYsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MjMyNjZ9.2UwZGng3mDEH7w7qH_sgaKnG9nuXVuof_ZpKi9WERpo
130	2021-02-19 09:05:02.13814+00	2021-02-19 09:05:02.13814+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMzAxOTQsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MjQzOTR9.eJvwwJgIideGhmStTYmw1r8OwtNh1uohq01Mgmk-_OU
131	2021-02-19 09:22:41.692952+00	2021-02-19 09:22:41.692952+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMzAzMDIsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MjQ1MDJ9.Wljrv05nzaRa1jVTCdC37BMTxp4Hh7k4XWe6LBoZd-E
132	2021-02-19 09:26:43.102726+00	2021-02-19 09:26:43.102726+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMzEzNjEsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MjU1NjF9.nYoSNBMGfEgP3xXi9QAUZXYFgQwSYxdJnOaZAY9XT_Y
133	2021-02-19 09:38:24.151851+00	2021-02-19 09:38:24.151851+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMzE2MDMsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MjU4MDN9.qJmjDPJ2Ckd9iC44dsLsjTtpFvMzHUJhzYDB8svY_7M
134	2021-02-19 10:11:43.846814+00	2021-02-19 10:11:43.846814+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMzIzMDQsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3MjY1MDR9.78tKPyh4PlbwKcYBs1f3FZ0Z3eJXtAWxCmrRSSmtx6U
135	2021-02-23 09:35:13.245345+00	2021-02-23 09:35:13.245345+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQzMzQzMDMsImlzcyI6InRvbWUiLCJuYmYiOjE2MTM3Mjg1MDN9.2qTl7pr37GPwb5-_Zy09RrVZryDLxdryhYjP9jmn0Zg
136	2021-02-24 02:48:48.003396+00	2021-02-24 02:48:48.003396+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ2Nzc3MTMsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQwNzE5MTN9._fqDFTb-aiPjXgXk9o9Ds3aHQ5iqRP2pFE0515EyjOQ
137	2021-02-24 03:41:11.270966+00	2021-02-24 03:41:11.270966+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3Mzk3MjgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxMzM5Mjh9.2m5eph6vvr3flAI99rG_mCLuKbGemvN5Sqb7mOMEU4I
138	2021-02-24 03:53:43.781927+00	2021-02-24 03:53:43.781927+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NDI4NzEsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxMzcwNzF9.x1csN0ZcFaBnKkUeK9eJ7HXX4Xw_VtJKjZ-P8Qq8ypU
139	2021-02-24 03:54:34.659278+00	2021-02-24 03:54:34.659278+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NDM2MjMsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxMzc4MjN9.3aXAEVwzOUBUvTI-fjVtI6dXAi5ubHIeyoUvfF79Vrc
140	2021-02-24 05:52:27.020076+00	2021-02-24 05:52:27.020076+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NDM2NzQsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxMzc4NzR9.KVD89PyEvrxg3ssFecEZ4g3RZRTAYaAiBe0f1v5VKBw
141	2021-02-24 06:45:19.081637+00	2021-02-24 06:45:19.081637+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTA3NDcsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNDQ5NDd9.1xHg4eh_tOLp33tdBp5g3kXQlRnEdmng1DfSXBtXLFA
142	2021-02-24 06:46:19.591921+00	2021-02-24 06:46:19.591921+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTM5MTksImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNDgxMTl9.jFva4Qd6h5Ul96THM4nkiMUXgDvwRTDK8TA91aViOpY
143	2021-02-24 06:47:13.233436+00	2021-02-24 06:47:13.233436+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTM5NzksImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNDgxNzl9.ZyuHOvNFhj_f6THT82U5USjYLNG5nWRVkV8bRkAUjYE
144	2021-02-24 06:49:03.029684+00	2021-02-24 06:49:03.029684+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTQwMzMsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNDgyMzN9.U7ACRjQPUdpiq4m6uNfJHUymcmdesLeTwE6a6AvkcSk
145	2021-02-24 07:29:12.153393+00	2021-02-24 07:29:12.153393+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTQxNDMsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNDgzNDN9.ToZ0q5VZ4RJIegDSrFx34e6r_hBVOGzVEBlc1Pn7pw0
146	2021-02-24 07:37:26.332362+00	2021-02-24 07:37:26.332362+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTY1NTIsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTA3NTJ9.Q_Z_8LuNqlZXSzb6Hd6L3YUeXSt7YRalC1wJwhaVfnE
147	2021-02-24 07:44:20.259939+00	2021-02-24 07:44:20.259939+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTcwNDYsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTEyNDZ9.GRP5UWYRhoztWXVk2ONie6Hb4sLobyvZsij1PmkIdk4
148	2021-02-24 07:56:05.384378+00	2021-02-24 07:56:05.384378+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTc0NjAsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTE2NjB9.03BM6X_HqF9uVBRjVs48btODSuEO91seW94qtadDYwU
149	2021-02-24 07:56:16.13795+00	2021-02-24 07:56:16.13795+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTgxNjUsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTIzNjV9.tB5wZRWdM-cD1fl-zvFxk7K2AnYbNU-RzoB5GQpm5-g
150	2021-02-24 08:04:08.190609+00	2021-02-24 08:04:08.190609+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTgxNzYsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTIzNzZ9.recc0lYNLrX44edTFD9PTm8QIYZpVx7ZUBM4jZBeNug
151	2021-02-24 08:08:17.396476+00	2021-02-24 08:08:17.396476+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTg2NDgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTI4NDh9.Wm15-38igGJBfrsUDGT13Deypv6IbDQBfQkVd-15qvQ
152	2021-02-24 08:11:11.785368+00	2021-02-24 08:11:11.785368+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTg4OTcsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTMwOTd9.PyN0DHSD8dVWmC4xdtad2M_hLL-72C8j0hz9iGD3vUA
153	2021-02-24 08:12:37.582659+00	2021-02-24 08:12:37.582659+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTkwNzEsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTMyNzF9.6JgfdEK9zRgs0GjKQrz-Wn7gyZORnlmMpn_yqY5FubI
154	2021-02-24 08:16:27.031955+00	2021-02-24 08:16:27.031955+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTkxNTcsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTMzNTd9.Ksyn20SS7GthRZE8VM23X_RWUfGQHWbOVtrvTFO4L6g
155	2021-02-24 08:23:08.619419+00	2021-02-24 08:23:08.619419+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTkzODcsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTM1ODd9.Sg6WPrlTygPS3nm8PRk5zFgxLiPc75yHDU74SINhfXg
156	2021-02-24 08:29:29.789234+00	2021-02-24 08:29:29.789234+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NTk3ODgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTM5ODh9.fhtiH3_YNDU6GQMV9_zQ6wo2Z5bc6Go3TpLb1CQztYo
157	2021-02-24 08:33:09.382151+00	2021-02-24 08:33:09.382151+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjAxNjksImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTQzNjl9.hjzzPiPMw6XaJ-g9u_FJlR_3rZQhABwLkgQqkElSchA
158	2021-02-24 08:34:12.915401+00	2021-02-24 08:34:12.915401+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjAzODksImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTQ1ODl9.PJfSnQMmE7GWN-CKtwG8M_dQ3Wl0j0cQ7j9400aRoQY
159	2021-02-24 08:34:21.613916+00	2021-02-24 08:34:21.613916+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjA0NTIsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTQ2NTJ9.BtlB7hJW-AXBztIajS-HAR3Rb77U9Ub72_7dsIU0Af4
160	2021-02-24 08:37:21.523133+00	2021-02-24 08:37:21.523133+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjA0NjEsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTQ2NjF9.RD__bKz_OaReQnLInmMHDY9wE7wUhWvqUpMlK_JzpKU
161	2021-02-24 08:56:32.217628+00	2021-02-24 08:56:32.217628+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjA2NDEsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTQ4NDF9.8jzj6c79qxozY10qn6FjTTvEptoKdzHwvYavXD41oO0
162	2021-02-24 09:02:47.823355+00	2021-02-24 09:02:47.823355+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjE3OTIsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTU5OTJ9.QzPFXgK7xuadwYse3qmazyYKXRgcOIi_E1dbfwskW_4
163	2021-02-24 09:04:52.651012+00	2021-02-24 09:04:52.651012+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjIxNjcsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTYzNjd9.UdWw3m3zb2Bgwi7m76D_k0G5W8S2j1p0I8qJE9QLhSw
164	2021-02-24 09:12:36.638384+00	2021-02-24 09:12:36.638384+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjIyOTIsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTY0OTJ9.Lp_mXtKuHIQ6bC3ysptwnd9PSAoljEsgHcKiq_SXu_s
165	2021-02-24 09:20:04.460974+00	2021-02-24 09:20:04.460974+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjI3NTYsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTY5NTZ9.FAjK5gD0ICjb1LU6k7E_CxZ7AXMjWToXXLUXUFTu5nU
166	2021-02-24 09:22:06.146774+00	2021-02-24 09:22:06.146774+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjMyMDQsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTc0MDR9.MbINQt2sjVkfOTUlOJ-QhX6rOYrOtTyh8kTtwqevQ8I
167	2021-02-24 09:25:06.728294+00	2021-02-24 09:25:06.728294+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjMzMjYsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTc1MjZ9.V_nkQkKei91wJlnwNyTUOeVMXyeBEnwcHzUCFef4-6A
168	2021-02-24 09:31:23.715684+00	2021-02-24 09:31:23.715684+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjM1MDYsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTc3MDZ9.3VDeSaTGSw7L0tj1JqVXvH9Ah-M3ipi_1jUhWP6u9aE
169	2021-02-24 09:38:00.896651+00	2021-02-24 09:38:00.896651+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjM4ODMsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTgwODN9.Ygx5Ilpm9kG2drf21sjJd3sh338lDab8p3CKmx9yfH8
170	2021-02-24 09:40:15.618583+00	2021-02-24 09:40:15.618583+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjQyODAsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTg0ODB9.VTgBWyIGR2lNgKY7jY2DWtJ_jPPIk74aItQEkEzA8q8
171	2021-02-24 10:05:04.27398+00	2021-02-24 10:05:04.27398+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjQ0MTUsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNTg2MTV9.pTjOhwoUIb8p2wXoOfFKyuR_6EDA4YXLXlCqm7TUa0M
172	2021-02-24 10:06:18.402104+00	2021-02-24 10:06:18.402104+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjU5MDQsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNjAxMDR9.CfLc6dt9jzSg8752KoYFAyavmfZEs6oa8QcI64oQD7w
173	2021-02-24 10:08:12.023995+00	2021-02-24 10:08:12.023995+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjU5NzgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNjAxNzh9.5D1oN2naqQ48hAaiNmiS5RDub8G804Cg8UMl04ZjON4
174	2021-02-24 10:09:28.320856+00	2021-02-24 10:09:28.320856+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjYwOTIsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNjAyOTJ9.Y1ZsQQaHS9m6kzLMd8bkgd23dB16LddjZPnHnDYCquQ
175	2021-02-24 10:13:11.476574+00	2021-02-24 10:13:11.476574+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjYxNjgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNjAzNjh9.shi-atg37wNSiW7DxSfZc2sH19_QdKGwu7GwU90O0Vw
176	2021-02-24 10:13:30.250933+00	2021-02-24 10:13:30.250933+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjYzOTEsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNjA1OTF9.InX73W3qiayxoU7RliowtRWMmp-6jdpYL_VTvUuHMzg
177	2021-02-24 10:15:28.731588+00	2021-02-24 10:15:28.731588+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjY0MTAsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNjA2MTB9._lg3x70S42FjEC3Ic-jm2RYzj7hGuUGPnqQMNaL1yY0
178	2021-02-24 10:17:03.974637+00	2021-02-24 10:17:03.974637+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6InR0dHQiLCJBdXRob3JpdHlJZCI6Ijg4OCIsIkJ1ZmZlclRpbWUiOjg2NDAwLCJleHAiOjE2MTQ3NjY1MjgsImlzcyI6InRvbWUiLCJuYmYiOjE2MTQxNjA3Mjh9.w_TN0dl3W3F5fmt3rITz9Yjljz0E5iFZghKALbBxVxA
\.


--
-- Data for Name: sys_operation_records; Type: TABLE DATA; Schema: public; Owner: db
--

COPY public.sys_operation_records (id, createed_at, updateed_at, deleteed_at, ip, method, path, status, latency, agent, error_message, body, resp, userid) FROM stdin;
\.


--
-- Data for Name: sys_users; Type: TABLE DATA; Schema: public; Owner: db
--

COPY public.sys_users (id, createed_at, updateed_at, deleteed_at, uuid, username, password, nick_name, header_img, authority_id) FROM stdin;
3	2021-01-26 07:59:22+00	2021-01-26 07:59:22+00	\N	10265233-a3ee-45d2-bb90-7a01256c5b7d	lk1	9df62e693988eb4e1e1444ece0578579	testa	http://www.test.com	888
0	0001-01-01 00:00:00+00	2021-01-26 08:33:37+00	\N	f6c11af5-20f0-40d5-9fda-dfc1d0582b39	admin	9df62e693988eb4e1e1444ece0578579	tttt	http://www.com	888
\.


--
-- Name: casbin_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db
--

SELECT pg_catalog.setval('public.casbin_rule_id_seq', 1, true);


--
-- Name: sys_base_menu_parameters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db
--

SELECT pg_catalog.setval('public.sys_base_menu_parameters_id_seq', 5, true);


--
-- Name: sys_base_menus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db
--

SELECT pg_catalog.setval('public.sys_base_menus_id_seq', 8, true);


--
-- Name: sys_jwt_blacklist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db
--

SELECT pg_catalog.setval('public.sys_jwt_blacklist_id_seq', 178, true);


--
-- Name: sys_operation_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db
--

SELECT pg_catalog.setval('public.sys_operation_records_id_seq', 1, false);


--
-- Name: sys_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db
--

SELECT pg_catalog.setval('public.sys_users_id_seq', 3, true);


--
-- Name: casbin_rule casbin_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.casbin_rule
    ADD CONSTRAINT casbin_rule_pkey PRIMARY KEY (id);


--
-- Name: sys_authorities sys_authorities_pk; Type: CONSTRAINT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.sys_authorities
    ADD CONSTRAINT sys_authorities_pk PRIMARY KEY (authority_id);


--
-- Name: sys_base_menu_parameters sys_base_menu_parameters_pk; Type: CONSTRAINT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.sys_base_menu_parameters
    ADD CONSTRAINT sys_base_menu_parameters_pk PRIMARY KEY (id);


--
-- Name: sys_base_menus sys_base_menus_pk; Type: CONSTRAINT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.sys_base_menus
    ADD CONSTRAINT sys_base_menus_pk PRIMARY KEY (sys_base_menu_id);


--
-- Name: sys_jwt_blacklist sys_jwt_blacklist_pk; Type: CONSTRAINT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.sys_jwt_blacklist
    ADD CONSTRAINT sys_jwt_blacklist_pk PRIMARY KEY (id);


--
-- Name: sys_jwt_blacklist sys_jwt_blacklist_un; Type: CONSTRAINT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.sys_jwt_blacklist
    ADD CONSTRAINT sys_jwt_blacklist_un UNIQUE (jwt);


--
-- Name: sys_users sys_users_pk; Type: CONSTRAINT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.sys_users
    ADD CONSTRAINT sys_users_pk PRIMARY KEY (id);


--
-- Name: sys_users sys_users_un; Type: CONSTRAINT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.sys_users
    ADD CONSTRAINT sys_users_un UNIQUE (uuid, username);


--
-- Name: unique_index; Type: INDEX; Schema: public; Owner: db
--

CREATE UNIQUE INDEX unique_index ON public.casbin_rule USING btree (p_type, v0, v1, v2, v3, v4, v5);


--
-- PostgreSQL database dump complete
--

