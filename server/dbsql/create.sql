-- public.casbin_rule definition

-- Drop table

-- DROP TABLE public.casbin_rule;

CREATE TABLE public.casbin_rule (
	id bigserial NOT NULL,
	p_type varchar(40) NULL,
	v0 varchar(40) NULL,
	v1 varchar(40) NULL,
	v2 varchar(40) NULL,
	v3 varchar(40) NULL,
	v4 varchar(40) NULL,
	v5 varchar(40) NULL,
	CONSTRAINT casbin_rule_pkey PRIMARY KEY (id)
);
CREATE UNIQUE INDEX unique_index ON public.casbin_rule USING btree (p_type, v0, v1, v2, v3, v4, v5);


-- public.sys_authorities definition

-- Drop table

-- DROP TABLE public.sys_authorities;

CREATE TABLE public.sys_authorities (
	created_at timestamptz NULL,
	updated_at timestamptz(0) NULL,
	deleted_at timestamptz(0) NULL,
	authority_id varchar(90) NOT NULL, -- 角色ID
	authority_name varchar(191) NULL, -- 角色名
	parent_id varchar(191) NULL, -- 父角色ID
	CONSTRAINT sys_authorities_pk PRIMARY KEY (authority_id)
);

-- Column comments

COMMENT ON COLUMN public.sys_authorities.authority_id IS '角色ID';
COMMENT ON COLUMN public.sys_authorities.authority_name IS '角色名';
COMMENT ON COLUMN public.sys_authorities.parent_id IS '父角色ID';


-- public.sys_authority_menus definition

-- Drop table

-- DROP TABLE public.sys_authority_menus;

CREATE TABLE public.sys_authority_menus (
	sys_authority_authority_id varchar(90) NULL, -- 角色id
	sys_base_menu_id numeric NULL
);

-- Column comments

COMMENT ON COLUMN public.sys_authority_menus.sys_authority_authority_id IS '角色id';


-- public.sys_base_menu_parameters definition

-- Drop table

-- DROP TABLE public.sys_base_menu_parameters;

CREATE TABLE public.sys_base_menu_parameters (
	id bigserial NOT NULL,
	createed_at timestamptz(0) NULL,
	updateed_at timestamptz(0) NULL,
	deleteed_at timestamptz(0) NULL,
	sys_base_menu_id int8 NULL,
	addtype varchar(191) NULL, -- 地址栏携带参数为params还是query
	addkey varchar(191) NULL, -- 地址栏携带参数的key
	addvalue varchar(191) NULL, -- 地址栏携带参数的值
	CONSTRAINT sys_base_menu_parameters_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.sys_base_menu_parameters.addtype IS '地址栏携带参数为params还是query';
COMMENT ON COLUMN public.sys_base_menu_parameters.addkey IS '地址栏携带参数的key';
COMMENT ON COLUMN public.sys_base_menu_parameters.addvalue IS '地址栏携带参数的值';


-- public.sys_base_menus definition

-- Drop table

-- DROP TABLE public.sys_base_menus;

CREATE TABLE public.sys_base_menus (
	sys_base_menu_id int8 NOT NULL DEFAULT nextval('sys_base_menus_id_seq'::regclass),
	createed_at timestamptz(0) NULL,
	updateed_at timestamptz(0) NULL,
	deleteed_at timestamptz(0) NULL,
	menu_level numeric NULL,
	parent_id varchar(191) NULL, -- 父菜单id
	routerpath varchar(191) NULL, -- 路由path
	routername varchar(191) NULL, -- 路由name
	hidden bool NULL, -- 是否在列表隐藏
	component varchar(191) NULL, -- 对应前端文件路径
	sort numeric NULL, -- 排序标记
	keep_alive bool NULL, -- 附加属性
	default_menu bool NULL, -- 附加属性
	title varchar(191) NULL, -- 附加属性
	icon varchar(191) NULL, -- 附加属性
	CONSTRAINT sys_base_menus_pk PRIMARY KEY (sys_base_menu_id)
);

-- Column comments

COMMENT ON COLUMN public.sys_base_menus.parent_id IS '父菜单id';
COMMENT ON COLUMN public.sys_base_menus.routerpath IS '路由path';
COMMENT ON COLUMN public.sys_base_menus.routername IS '路由name';
COMMENT ON COLUMN public.sys_base_menus.hidden IS '是否在列表隐藏';
COMMENT ON COLUMN public.sys_base_menus.component IS '对应前端文件路径';
COMMENT ON COLUMN public.sys_base_menus.sort IS '排序标记';
COMMENT ON COLUMN public.sys_base_menus.keep_alive IS '附加属性';
COMMENT ON COLUMN public.sys_base_menus.default_menu IS '附加属性';
COMMENT ON COLUMN public.sys_base_menus.title IS '附加属性';
COMMENT ON COLUMN public.sys_base_menus.icon IS '附加属性';


-- public.sys_jwt_blacklist definition

-- Drop table

-- DROP TABLE public.sys_jwt_blacklist;

CREATE TABLE public.sys_jwt_blacklist (
	id bigserial NOT NULL,
	created_at timestamptz NULL,
	updated_at timestamptz NULL,
	deleted_at timestamptz NULL,
	jwt text NULL,
	CONSTRAINT sys_jwt_blacklist_pk PRIMARY KEY (id),
	CONSTRAINT sys_jwt_blacklist_un UNIQUE (jwt)
);


-- public.sys_operation_records definition

-- Drop table

-- DROP TABLE public.sys_operation_records;

CREATE TABLE public.sys_operation_records (
	id bigserial NOT NULL,
	createed_at timestamptz(0) NULL,
	updateed_at timestamptz(0) NULL,
	deleteed_at timestamptz(0) NULL,
	ip inet NULL, -- 请求ip
	"method" varchar(191) NULL, -- 请求方法
	"path" varchar(191) NULL, -- 请求路径
	status int8 NULL, -- 请求状态
	latency int8 NULL, -- 延迟
	agent varchar NULL, -- 代理
	error_message varchar NULL, -- 错误信息
	body text NULL, -- 请求Body
	resp text NULL, -- 响应Body
	userid int8 NULL -- 用户id
);

-- Column comments

COMMENT ON COLUMN public.sys_operation_records.ip IS '请求ip';
COMMENT ON COLUMN public.sys_operation_records."method" IS '请求方法';
COMMENT ON COLUMN public.sys_operation_records."path" IS '请求路径';
COMMENT ON COLUMN public.sys_operation_records.status IS '请求状态';
COMMENT ON COLUMN public.sys_operation_records.latency IS '延迟';
COMMENT ON COLUMN public.sys_operation_records.agent IS '代理';
COMMENT ON COLUMN public.sys_operation_records.error_message IS '错误信息';
COMMENT ON COLUMN public.sys_operation_records.body IS '请求Body';
COMMENT ON COLUMN public.sys_operation_records.resp IS '响应Body';
COMMENT ON COLUMN public.sys_operation_records.userid IS '用户id';


-- public.sys_users definition

-- Drop table

-- DROP TABLE public.sys_users;

CREATE TABLE public.sys_users (
	id bigserial NOT NULL,
	createed_at timestamptz(0) NULL,
	updateed_at timestamptz(0) NULL,
	deleteed_at timestamptz(0) NULL,
	uuid uuid NULL, -- 用户UUID
	username varchar(191) NULL, -- 用户登录名
	"password" varchar(191) NULL, -- 用户登录密码
	nick_name varchar(191) NULL DEFAULT 'sysuser'::character varying, -- 用户昵称
	header_img varchar(191) NULL, -- 用户头像
	authority_id varchar(90) NULL DEFAULT 888, -- 用户角色ID
	CONSTRAINT sys_users_pk PRIMARY KEY (id),
	CONSTRAINT sys_users_un UNIQUE (uuid, username)
);

-- Column comments

COMMENT ON COLUMN public.sys_users.uuid IS '用户UUID';
COMMENT ON COLUMN public.sys_users.username IS '用户登录名';
COMMENT ON COLUMN public.sys_users."password" IS '用户登录密码';
COMMENT ON COLUMN public.sys_users.nick_name IS '用户昵称';
COMMENT ON COLUMN public.sys_users.header_img IS '用户头像';
COMMENT ON COLUMN public.sys_users.authority_id IS '用户角色ID';