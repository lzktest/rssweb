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
                                       id bigserial NOT NULL,
                                       created_at timestamptz(0) NULL,
                                       updated_at timestamptz(0) NULL,
                                       deleted_at timestamptz(0) NULL,
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
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(1,'2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '0', 'dashboard', 'dashboard', false, 'view/dashboard/index.vue', 1, false, false, '仪表盘', 'setting');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(2, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '0', 'about', 'about', false, 'view/about/index.vue', 7, false, false, '关于我们', 'info');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(3, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '0', 'admin', 'superAdmin', false, 'view/superAdmin/index.vue', 3, false, false, '超级管理员', 'user-solid');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id,routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(4, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '3', 'authority', 'authority', false, 'view/superAdmin/authority/authority.vue', 1, false, false, '角色管理', 's-custom');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(5, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '3', 'menu', 'menu', false, 'view/superAdmin/menu/menu.vue', 2, true, false, '菜单管理', 's-order');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(6, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '3', 'api', 'api', false, 'view/superAdmin/api/api.vue', 3, true, false, 'api管理', 's-platform');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(7, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '3', 'user', 'user', false, 'view/superAdmin/user/user.vue', 4, false, false, '用户管理', 'coordinate');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(8, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '0', 'person', 'person', true, 'view/person/person.vue', 4, false, false, '个人信息', 'message-solid');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(9, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '0', 'example', 'example', false, 'view/example/index.vue', 6, false, false, '示例文件', 's-management');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(10, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '9', 'excel', 'excel', false, 'view/example/excel/excel.vue', 4, false, false, 'excel导入导出', 's-marketing');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(11, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '9', 'upload', 'upload', false, 'view/example/upload/upload.vue', 5, false, false, '上传下载', 'upload');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(12, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '9', 'breakpoint', 'breakpoint', false, 'view/example/breakpoint/breakpoint.vue', 6, false, false, '断点续传', 'upload');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(13, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '9', 'customer', 'customer', false, 'view/example/customer/customer.vue', 7, false, false, '客户列表（资源示例）', 's-custom');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(14, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '0', 'systemTools', 'systemTools', false, 'view/systemTools/index.vue', 5, false, false, '系统工具', 's-cooperation');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(15, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '14', 'autoCode', 'autoCode', false, 'view/systemTools/autoCode/index.vue', 1, true, false, '代码生成器', 'cpu');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(16, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '14', 'formCreate', 'formCreate', false, 'view/systemTools/formCreate/index.vue', 2, true, false, '表单生成器', 'magic-stick');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(17, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '14', 'system', 'system', false, 'view/systemTools/system/system.vue', 3, false, false, '系统配置', 's-operation');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(18, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '3', 'dictionary', 'dictionary', false, 'view/superAdmin/dictionary/sysDictionary.vue', 5, false, false, '字典管理', 'notebook-2');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(19, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '3', 'dictionaryDetail/:id', 'dictionaryDetail', true, 'view/superAdmin/dictionary/sysDictionaryDetail.vue', 1, false, false, '字典详情', 's-order');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(20, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '3', 'operation', 'operation', false, 'view/superAdmin/operation/sysOperationRecord.vue', 6, false, false, '操作历史', 'time');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(21, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '9', 'simpleUploader', 'simpleUploader', false, 'view/example/simpleUploader/simpleUploader', 6, false, false, '断点续传（插件版）', 'upload');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(22, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '0', 'https://www.gin-vue-admin.com', 'https://www.gin-vue-admin.com', false, '/',0, false, false, '官方网站', 's-home');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(23, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '0', 'state', 'state', false, 'view/system/state.vue', 6, false, false, '服务器状态', 'cloudy');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(24, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '0', 'workflow', 'workflow', false, 'view/workflow/index.vue', 5, false, false, '工作流功能', 'phone');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(25, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '24', 'workflowCreate', 'workflowCreate', false, 'view/workflow/workflowCreate/workflowCreate.vue', 0, false, false, '工作流绘制', 'circle-plus');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(26, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '24', 'workflowProcess', 'workflowProcess', false, 'view/workflow/workflowProcess/workflowProcess.vue', 0, false, false, '工作流列表', 's-cooperation');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(27, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '24', 'workflowUse', 'workflowUse', true, 'view/workflow/workflowUse/workflowUse.vue', 0, false, false, '使用工作流', 'video-play');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(28, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '24', 'started', 'started', false, 'view/workflow/userList/started.vue', 0, false, false, '我发起的', 's-order');
INSERT INTO sys_base_menus
(id, created_at, updated_at, deleted_at, menu_level, parent_id, routerpath, routername, hidden, component, sort, keep_alive, default_menu, title, icon)
VALUES(29, '2021-01-14 10:32:18', '2021-01-14 10:32:18', NULL, 0, '24', 'need', 'need', false, 'view/workflow/userList/need.vue', 0, false, false, '我的待办', 's-platform');


CREATE TABLE public.sys_base_menu_parameters (
                                                 id bigserial NOT NULL,
                                                 createed timestamptz(0) NULL,
                                                 updateed timestamptz(0) NULL,
                                                 deleteed timestamptz(0) NULL,
                                                 sys_base_menu_id int8 NULL,
                                                 "type" varchar(191) NULL, -- 地址栏携带参数为params还是query
                                                 "key" varchar(191) NULL, -- 地址栏携带参数的key
                                                 value varchar(191) NULL, -- 地址栏携带参数的值
                                                 CONSTRAINT sys_base_menu_parameters_pk PRIMARY KEY (id)
);

-- Column comments

COMMENT ON COLUMN public.sys_base_menu_parameters."type" IS '地址栏携带参数为params还是query';
COMMENT ON COLUMN public.sys_base_menu_parameters."key" IS '地址栏携带参数的key';
COMMENT ON COLUMN public.sys_base_menu_parameters.value IS '地址栏携带参数的值';
