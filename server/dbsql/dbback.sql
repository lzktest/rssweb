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
    v1 character varying(190),
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
-- Name: sys_apis; Type: TABLE; Schema: public; Owner: db
--

CREATE TABLE public.sys_apis (
    id bigint NOT NULL,
    created_at timestamp(0) with time zone,
    updated_at timestamp(0) with time zone,
    deleted_at timestamp(0) with time zone,
    paths character varying NOT NULL,
    descriptions character varying NOT NULL,
    apigroup character varying NOT NULL,
    methods character varying DEFAULT 'POST'::character varying NOT NULL
);


ALTER TABLE public.sys_apis OWNER TO db;

--
-- Name: COLUMN sys_apis.paths; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_apis.paths IS 'api路径';


--
-- Name: COLUMN sys_apis.descriptions; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_apis.descriptions IS 'api描述';


--
-- Name: COLUMN sys_apis.apigroup; Type: COMMENT; Schema: public; Owner: db
--

COMMENT ON COLUMN public.sys_apis.apigroup IS 'api组';


--
-- Name: sys_apis_id_seq; Type: SEQUENCE; Schema: public; Owner: db
--

CREATE SEQUENCE public.sys_apis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sys_apis_id_seq OWNER TO db;

--
-- Name: sys_apis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: db
--

ALTER SEQUENCE public.sys_apis_id_seq OWNED BY public.sys_apis.id;


--
-- Name: sys_authorities; Type: TABLE; Schema: public; Owner: db
--

CREATE TABLE public.sys_authorities (
    created_at timestamp with time zone,
    updated_at timestamp(0) with time zone,
    deleted_at timestamp(0) with time zone,
    authority_id character varying(90) NOT NULL,
    authority_name character varying(191),
    parent_id character varying(191),
    default_router character varying DEFAULT 'dashboard'::character varying
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
-- Name: sys_apis id; Type: DEFAULT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.sys_apis ALTER COLUMN id SET DEFAULT nextval('public.sys_apis_id_seq'::regclass);


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
3	p	888	/workflowProcess/getWorkflowMoveByID	GET			
4	p	888	/base/login	POST			
5	p	888	/user/register	POST			
6	p	888	/api/createApi	POST			
7	p	888	/api/getApiList	POST			
8	p	888	/api/getApiById	POST			
9	p	888	/api/deleteApi	POST			
10	p	888	/api/updateApi	POST			
11	p	888	/api/getAllApis	POST			
12	p	888	/authority/createAuthority	POST			
13	p	888	/authority/deleteAuthority	POST			
14	p	888	/authority/getAuthorityList	POST			
15	p	888	/authority/setDataAuthority	POST			
16	p	888	/authority/updateAuthority	PUT			
17	p	888	/authority/copyAuthority	POST			
18	p	888	/menu/getMenu	POST			
19	p	888	/menu/getMenuList	POST			
20	p	888	/menu/addBaseMenu	POST			
21	p	888	/menu/getBaseMenuTree	POST			
22	p	888	/menu/addMenuAuthority	POST			
23	p	888	/menu/getMenuAuthority	POST			
24	p	888	/menu/deleteBaseMenu	POST			
25	p	888	/menu/updateBaseMenu	POST			
26	p	888	/menu/getBaseMenuById	POST			
27	p	888	/user/changePassword	POST			
28	p	888	/user/getUserList	POST			
29	p	888	/user/setUserAuthority	POST			
30	p	888	/user/deleteUser	DELETE			
31	p	888	/fileUploadAndDownload/upload	POST			
32	p	888	/fileUploadAndDownload/getFileList	POST			
33	p	888	/fileUploadAndDownload/deleteFile	POST			
34	p	888	/casbin/updateCasbin	POST			
35	p	888	/casbin/getPolicyPathByAuthorityId	POST			
36	p	888	/casbin/casbinTest/:pathParam	GET			
37	p	888	/jwt/jsonInBlacklist	POST			
38	p	888	/system/getSystemConfig	POST			
39	p	888	/system/setSystemConfig	POST			
40	p	888	/system/getServerInfo	POST			
41	p	888	/customer/customer	POST			
42	p	888	/customer/customer	PUT			
43	p	888	/customer/customer	DELETE			
44	p	888	/customer/customer	GET			
45	p	888	/customer/customerList	GET			
46	p	888	/autoCode/createTemp	POST			
47	p	888	/autoCode/getTables	GET			
48	p	888	/autoCode/getDB	GET			
49	p	888	/autoCode/getColumn	GET			
50	p	888	/sysDictionary/createSysDictionary	POST			
51	p	888	/sysDictionary/deleteSysDictionary	DELETE			
52	p	888	/sysDictionary/updateSysDictionary	PUT			
53	p	888	/sysDictionary/findSysDictionary	GET			
54	p	888	/sysDictionary/getSysDictionaryList	GET			
55	p	888	/user/setUserInfo	PUT			
56	p	888	/email/emailTest	POST			
57	p	888	/simpleUploader/upload	POST			
58	p	888	/simpleUploader/checkFileMd5	GET			
59	p	888	/simpleUploader/mergeFileMd5	GET			
60	p	888	/workflowProcess/createWorkflowProcess	POST			
61	p	888	/workflowProcess/deleteWorkflowProcess	DELETE			
62	p	888	/workflowProcess/updateWorkflowProcess	PUT			
63	p	888	/workflowProcess/findWorkflowProcess	GET			
64	p	888	/workflowProcess/getWorkflowProcessList	GET			
65	p	888	/workflowProcess/findWorkflowStep	GET			
66	p	888	/workflowProcess/startWorkflow	POST			
67	p	888	/workflowProcess/completeWorkflowMove	POST			
68	p	888	/workflowProcess/getMyStated	GET			
69	p	888	/workflowProcess/getMyNeed	GET			
\.


--
-- Data for Name: sys_apis; Type: TABLE DATA; Schema: public; Owner: db
--

COPY public.sys_apis (id, created_at, updated_at, deleted_at, paths, descriptions, apigroup, methods) FROM stdin;
1	2021-01-22 02:30:41+00	2021-01-22 02:30:41+00	\N	/base/login	login	base	POST
1	2021-04-23 10:13:39+00	2021-04-23 10:13:39+00	\N	/api/createApi	test	api	POST
\.


--
-- Data for Name: sys_authorities; Type: TABLE DATA; Schema: public; Owner: db
--

COPY public.sys_authorities (created_at, updated_at, deleted_at, authority_id, authority_name, parent_id, default_router) FROM stdin;
2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	888	普通用户	0	dashboard
2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	8881	普通用户子角色	888	dashboard
2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	9528	测试角色	0	dashboard
2021-04-16 10:04:57.759929+00	2021-04-16 10:04:58+00	\N	3	3	1	dashboard
2021-04-22 04:06:49.872989+00	2021-04-22 04:06:50+00	\N	1	1	0	dashboard
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
1	8
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
15	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	14	autoCode	autoCode	f	view/systemTools/autoCode/index.vue	1	t	f	代码生成器	cpu
1	2021-01-14 02:32:18+00	2021-01-14 02:32:18+00	\N	0	0	dashboard	dashboard	f	view/dashboard/index.vue	1	t	f	仪表盘	setting
\.


--
-- Data for Name: sys_jwt_blacklist; Type: TABLE DATA; Schema: public; Owner: db
--

COPY public.sys_jwt_blacklist (id, created_at, updated_at, deleted_at, jwt) FROM stdin;
257	2021-04-20 08:27:10.518945+00	2021-04-20 08:27:10.518945+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6ImFkbSIsIkF1dGhvcml0eUlkIjoiODg4IiwiQnVmZmVyVGltZSI6ODY0MDAsImV4cCI6MTYxOTUxMTE5MSwiaXNzIjoidG9tZSIsIm5iZiI6MTYxODkwNTM5MX0.0C8y59WIZjqJQ8z6YzMSuavzlebqOIrCVAsiepdzoxM
259	2021-04-23 03:30:12.83161+00	2021-04-23 03:30:12.83161+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6ImFkbSIsIkF1dGhvcml0eUlkIjoiODg4IiwiQnVmZmVyVGltZSI6ODY0MDAsImV4cCI6MTYxOTUxNDEyMCwiaXNzIjoidG9tZSIsIm5iZiI6MTYxODkwODMyMH0._mcTx4KspAgYnPnD-vmQkdf7p7_7DP6v6wZSeE5WXQk
260	2021-04-23 04:00:45.172557+00	2021-04-23 04:00:45.172557+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiMTAyNjUyMzMtYTNlZS00NWQyLWJiOTAtN2EwMTI1NmM1YjdkIiwiSUQiOjMsIlVzZXJuYW1lIjoibGsxIiwiTmlja05hbWUiOiJ0ZXN0YSIsIkF1dGhvcml0eUlkIjoiODg4IiwiQnVmZmVyVGltZSI6ODY0MDAsImV4cCI6MTYxOTc1MDk4MywiaXNzIjoidG9tZSIsIm5iZiI6MTYxOTE0NTE4M30.8Qozergf8MZ93-5jJQC2oFpI5L-wq_UYRKYJtPusj2c
261	2021-04-23 04:01:10.199315+00	2021-04-23 04:01:10.199315+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6ImFkbSIsIkF1dGhvcml0eUlkIjoiODg4IiwiQnVmZmVyVGltZSI6ODY0MDAsImV4cCI6MTYxOTc1MzQxMiwiaXNzIjoidG9tZSIsIm5iZiI6MTYxOTE0NzYxMn0.wsYshmYJWKpaLpC1gQkutJsJkwxiK9XfOoUwxgUiaT4
258	2021-04-20 09:02:00.589595+00	2021-04-20 09:02:00.589595+00	\N	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVVUlEIjoiZjZjMTFhZjUtMjBmMC00MGQ1LTlmZGEtZGZjMWQwNTgyYjM5IiwiSUQiOjAsIlVzZXJuYW1lIjoiYWRtaW4iLCJOaWNrTmFtZSI6ImFkbSIsIkF1dGhvcml0eUlkIjoiODg4IiwiQnVmZmVyVGltZSI6ODY0MDAsImV4cCI6MTYxOTUxMjAzMCwiaXNzIjoidG9tZSIsIm5iZiI6MTYxODkwNjIzMH0.Y2zpIR2f0BvoviUaWXx9Uj3Yq7dtpu37VteMxt2NWh0
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
3	2021-01-26 07:59:22+00	2021-01-26 07:59:22+00	\N	10265233-a3ee-45d2-bb90-7a01256c5b7d	lk1	9df62e693988eb4e1e1444ece0578579	testa	http://localhost:8080/favicon.ico	1
0	0001-01-01 00:00:00+00	2021-01-26 08:33:37+00	\N	f6c11af5-20f0-40d5-9fda-dfc1d0582b39	admin	9df62e693988eb4e1e1444ece0578579	adm	http://localhost:8080/favicon.ico	888
\.


--
-- Name: casbin_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db
--

SELECT pg_catalog.setval('public.casbin_rule_id_seq', 70, true);


--
-- Name: sys_apis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: db
--

SELECT pg_catalog.setval('public.sys_apis_id_seq', 2, true);


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

SELECT pg_catalog.setval('public.sys_jwt_blacklist_id_seq', 261, true);


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
-- Name: sys_apis sys_apis_un; Type: CONSTRAINT; Schema: public; Owner: db
--

ALTER TABLE ONLY public.sys_apis
    ADD CONSTRAINT sys_apis_un UNIQUE (paths);


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

