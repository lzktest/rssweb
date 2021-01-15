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

INSERT INTO sys_authorities
(created_at, updated_at, deleted_at, authority_id, authority_name, parent_id)
VALUES('2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, '888', '普通用户', '0');
INSERT INTO sys_authorities
(created_at, updated_at, deleted_at, authority_id, authority_name, parent_id)
VALUES('2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, '8881', '普通用户子角色', '888');
INSERT INTO sys_authorities
(created_at, updated_at, deleted_at, authority_id, authority_name, parent_id)
VALUES('2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, '9528', '测试角色', '0');
-- casbin
INSERT INTO public.casbin_rule
(id, p_type, v0, v1, v2, v3, v4, v5)
VALUES(1, 'p', 'alice', 'data1', 'read', NULL, NULL, NULL);
INSERT INTO public.casbin_rule
(id, p_type, v0, v1, v2, v3, v4, v5)
VALUES(2, 'p', 'bob', 'data2', 'write', NULL, NULL, NULL);
INSERT INTO public.casbin_rule
(id, p_type, v0, v1, v2, v3, v4, v5)
VALUES(3, 'p', 'data2_admin', 'data2', 'read', NULL, NULL, NULL);
INSERT INTO public.casbin_rule
(id, p_type, v0, v1, v2, v3, v4, v5)
VALUES(4, 'p', 'data2_admin', 'data2', 'write', NULL, NULL, NULL);
INSERT INTO public.casbin_rule
(id, p_type, v0, v1, v2, v3, v4, v5)
VALUES(5, 'g', 'alice', 'data2_admin', NULL, NULL, NULL, NULL);
INSERT INTO public.casbin_rule
(id, p_type, v0, v1, v2, v3, v4, v5)
VALUES(6, 'p', '1', '/base/test', 'POST', NULL, NULL, NULL);
INSERT INTO public.casbin_rule
(id, p_type, v0, v1, v2, v3, v4, v5)
VALUES(7, 'p', '2', '/base/route', 'POST', NULL, NULL, NULL);

CREATE TABLE public.sys_base_menus (
                                       id numeric NOT NULL,
                                       created_at timestamptz(0) NULL,
                                       updated_at timestamptz(0) NULL,
                                       deleted_at timestamptz(0) NULL,
                                       menulevel numeric NULL,
                                       parent_id varchar(191) NULL,
                                       "path" varchar(191) NULL,
                                       "name" varchar(191) NULL,
                                       hidden boolean NULL,
                                       component varchar(191) NULL,
                                       sort numeric NULL,
                                       keepalive boolean NULL,
                                       defautl_menu boolean NULL,
                                       title varchar(191) NULL,
                                       icon varchar(191) NULL,
                                       CONSTRAINT sys_base_menus_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.sys_base_menus.parent_id IS '父菜单id';
COMMENT ON COLUMN public.sys_base_menus."path" IS '路由path';
COMMENT ON COLUMN public.sys_base_menus."name" IS '路由name';
COMMENT ON COLUMN public.sys_base_menus.hidden IS '是否在列表隐藏';
COMMENT ON COLUMN public.sys_base_menus.component IS '对应前端文件路径';
COMMENT ON COLUMN public.sys_base_menus.sort IS '排序标记';
COMMENT ON COLUMN public.sys_base_menus.keepalive IS '附加属性';
COMMENT ON COLUMN public.sys_base_menus.defautl_menu IS '附加属性';
COMMENT ON COLUMN public.sys_base_menus.title IS '附加属性';
COMMENT ON COLUMN public.sys_base_menus.icon IS '附加属性';
