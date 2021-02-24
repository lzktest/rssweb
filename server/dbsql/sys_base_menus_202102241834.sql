INSERT INTO public.sys_base_menus (createed_at,updateed_at,deleteed_at,menu_level,parent_id,routerpath,routername,hidden,component,sort,keep_alive,default_menu,title,icon) VALUES
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'14','autoCode','autoCode',false,'view/systemTools/autoCode/index.vue',1,true,false,'代码生成器','cpu'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'0','dashboard','dashboard',false,'view/dashboard/index.vue',1,false,false,'仪表盘','setting'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'0','admin','superAdmin',false,'view/superAdmin/index.vue',3,false,false,'超级管理员','user-solid'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'3','authority','authority',false,'view/superAdmin/authority/authority.vue',1,false,false,'角色管理','s-custom'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'3','menu','menu',false,'view/superAdmin/menu/menu.vue',2,true,false,'菜单管理','s-order'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'3','api','api',false,'view/superAdmin/api/api.vue',3,true,false,'api管理','s-platform'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'3','user','user',false,'view/superAdmin/user/user.vue',4,false,false,'用户管理','coordinate'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'0','person','person',true,'view/person/person.vue',4,false,false,'个人信息','message-solid'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'0','example','example',false,'view/example/index.vue',6,false,false,'示例文件','s-management'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'9','excel','excel',false,'view/example/excel/excel.vue',4,false,false,'excel导入导出','s-marketing');
INSERT INTO public.sys_base_menus (createed_at,updateed_at,deleteed_at,menu_level,parent_id,routerpath,routername,hidden,component,sort,keep_alive,default_menu,title,icon) VALUES
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'9','upload','upload',false,'view/example/upload/upload.vue',5,false,false,'上传下载','upload'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'9','breakpoint','breakpoint',false,'view/example/breakpoint/breakpoint.vue',6,false,false,'断点续传','upload'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'9','customer','customer',false,'view/example/customer/customer.vue',7,false,false,'客户列表（资源示例）','s-custom'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'0','systemTools','systemTools',false,'view/systemTools/index.vue',5,false,false,'系统工具','s-cooperation'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'14','formCreate','formCreate',false,'view/systemTools/formCreate/index.vue',2,true,false,'表单生成器','magic-stick'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'14','system','system',false,'view/systemTools/system/system.vue',3,false,false,'系统配置','s-operation'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'3','dictionary','dictionary',false,'view/superAdmin/dictionary/sysDictionary.vue',5,false,false,'字典管理','notebook-2'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'3','dictionaryDetail/:id','dictionaryDetail',true,'view/superAdmin/dictionary/sysDictionaryDetail.vue',1,false,false,'字典详情','s-order'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'3','operation','operation',false,'view/superAdmin/operation/sysOperationRecord.vue',6,false,false,'操作历史','time'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'9','simpleUploader','simpleUploader',false,'view/example/simpleUploader/simpleUploader',6,false,false,'断点续传（插件版）','upload');
INSERT INTO public.sys_base_menus (createed_at,updateed_at,deleteed_at,menu_level,parent_id,routerpath,routername,hidden,component,sort,keep_alive,default_menu,title,icon) VALUES
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'0','state','state',false,'view/system/state.vue',6,false,false,'服务器状态','cloudy'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'0','workflow','workflow',false,'view/workflow/index.vue',5,false,false,'工作流功能','phone'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'24','workflowCreate','workflowCreate',false,'view/workflow/workflowCreate/workflowCreate.vue',0,false,false,'工作流绘制','circle-plus'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'24','workflowProcess','workflowProcess',false,'view/workflow/workflowProcess/workflowProcess.vue',0,false,false,'工作流列表','s-cooperation'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'24','workflowUse','workflowUse',true,'view/workflow/workflowUse/workflowUse.vue',0,false,false,'使用工作流','video-play'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'24','started','started',false,'view/workflow/userList/started.vue',0,false,false,'我发起的','s-order'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'24','need','need',false,'view/workflow/userList/need.vue',0,false,false,'我的待办','s-platform'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'0','about','about',false,'view/about/index.vue',7,false,false,'关于我们','info'),
	 ('2021-01-14 10:32:18+08','2021-01-14 10:32:18+08',NULL,0,'0','master','master',false,'/',0,false,false,'官方网站','s-home');