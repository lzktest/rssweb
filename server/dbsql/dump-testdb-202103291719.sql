PGDMP     0                    y            testdb    13.1 (Debian 13.1-1.pgdg100+1)    13.2 X    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16384    testdb    DATABASE     Z   CREATE DATABASE testdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE testdb;
                db    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                db    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   db    false    3            �            1259    16406    casbin_rule    TABLE       CREATE TABLE public.casbin_rule (
    id bigint NOT NULL,
    p_type character varying(40),
    v0 character varying(40),
    v1 character varying(40),
    v2 character varying(40),
    v3 character varying(40),
    v4 character varying(40),
    v5 character varying(40)
);
    DROP TABLE public.casbin_rule;
       public         heap    db    false    3            �            1259    16404    casbin_rule_id_seq    SEQUENCE     {   CREATE SEQUENCE public.casbin_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.casbin_rule_id_seq;
       public          db    false    201    3            �           0    0    casbin_rule_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.casbin_rule_id_seq OWNED BY public.casbin_rule.id;
          public          db    false    200            �            1259    16445    sys_authorities    TABLE     +  CREATE TABLE public.sys_authorities (
    created_at timestamp with time zone,
    updated_at timestamp(0) with time zone,
    deleted_at timestamp(0) with time zone,
    authority_id character varying(90) NOT NULL,
    authority_name character varying(191),
    parent_id character varying(191)
);
 #   DROP TABLE public.sys_authorities;
       public         heap    db    false    3            �           0    0 #   COLUMN sys_authorities.authority_id    COMMENT     E   COMMENT ON COLUMN public.sys_authorities.authority_id IS '角色ID';
          public          db    false    202            �           0    0 %   COLUMN sys_authorities.authority_name    COMMENT     H   COMMENT ON COLUMN public.sys_authorities.authority_name IS '角色名';
          public          db    false    202            �           0    0     COLUMN sys_authorities.parent_id    COMMENT     E   COMMENT ON COLUMN public.sys_authorities.parent_id IS '父角色ID';
          public          db    false    202            �            1259    16473    sys_authority_menus    TABLE     �   CREATE TABLE public.sys_authority_menus (
    sys_authority_authority_id character varying(90),
    sys_base_menu_id numeric
);
 '   DROP TABLE public.sys_authority_menus;
       public         heap    db    false    3            �           0    0 5   COLUMN sys_authority_menus.sys_authority_authority_id    COMMENT     W   COMMENT ON COLUMN public.sys_authority_menus.sys_authority_authority_id IS '角色id';
          public          db    false    207            �            1259    16463    sys_base_menu_parameters    TABLE     Y  CREATE TABLE public.sys_base_menu_parameters (
    id bigint NOT NULL,
    createed_at timestamp(0) with time zone,
    updateed_at timestamp(0) with time zone,
    deleteed_at timestamp(0) with time zone,
    sys_base_menu_id bigint,
    addtype character varying(191),
    addkey character varying(191),
    addvalue character varying(191)
);
 ,   DROP TABLE public.sys_base_menu_parameters;
       public         heap    db    false    3            �           0    0 '   COLUMN sys_base_menu_parameters.addtype    COMMENT     j   COMMENT ON COLUMN public.sys_base_menu_parameters.addtype IS '地址栏携带参数为params还是query';
          public          db    false    206            �           0    0 &   COLUMN sys_base_menu_parameters.addkey    COMMENT     [   COMMENT ON COLUMN public.sys_base_menu_parameters.addkey IS '地址栏携带参数的key';
          public          db    false    206            �           0    0 (   COLUMN sys_base_menu_parameters.addvalue    COMMENT     ]   COMMENT ON COLUMN public.sys_base_menu_parameters.addvalue IS '地址栏携带参数的值';
          public          db    false    206            �            1259    16461    sys_base_menu_parameters_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_base_menu_parameters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.sys_base_menu_parameters_id_seq;
       public          db    false    3    206            �           0    0    sys_base_menu_parameters_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.sys_base_menu_parameters_id_seq OWNED BY public.sys_base_menu_parameters.id;
          public          db    false    205            �            1259    16452    sys_base_menus    TABLE     !  CREATE TABLE public.sys_base_menus (
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
 "   DROP TABLE public.sys_base_menus;
       public         heap    db    false    3            �           0    0    COLUMN sys_base_menus.parent_id    COMMENT     D   COMMENT ON COLUMN public.sys_base_menus.parent_id IS '父菜单id';
          public          db    false    204            �           0    0     COLUMN sys_base_menus.routerpath    COMMENT     D   COMMENT ON COLUMN public.sys_base_menus.routerpath IS '路由path';
          public          db    false    204            �           0    0     COLUMN sys_base_menus.routername    COMMENT     D   COMMENT ON COLUMN public.sys_base_menus.routername IS '路由name';
          public          db    false    204            �           0    0    COLUMN sys_base_menus.hidden    COMMENT     K   COMMENT ON COLUMN public.sys_base_menus.hidden IS '是否在列表隐藏';
          public          db    false    204            �           0    0    COLUMN sys_base_menus.component    COMMENT     Q   COMMENT ON COLUMN public.sys_base_menus.component IS '对应前端文件路径';
          public          db    false    204            �           0    0    COLUMN sys_base_menus.sort    COMMENT     @   COMMENT ON COLUMN public.sys_base_menus.sort IS '排序标记';
          public          db    false    204            �           0    0     COLUMN sys_base_menus.keep_alive    COMMENT     F   COMMENT ON COLUMN public.sys_base_menus.keep_alive IS '附加属性';
          public          db    false    204            �           0    0 "   COLUMN sys_base_menus.default_menu    COMMENT     H   COMMENT ON COLUMN public.sys_base_menus.default_menu IS '附加属性';
          public          db    false    204            �           0    0    COLUMN sys_base_menus.title    COMMENT     A   COMMENT ON COLUMN public.sys_base_menus.title IS '附加属性';
          public          db    false    204            �           0    0    COLUMN sys_base_menus.icon    COMMENT     @   COMMENT ON COLUMN public.sys_base_menus.icon IS '附加属性';
          public          db    false    204            �            1259    16450    sys_base_menus_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.sys_base_menus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.sys_base_menus_id_seq;
       public          db    false    3    204            �           0    0    sys_base_menus_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.sys_base_menus_id_seq OWNED BY public.sys_base_menus.sys_base_menu_id;
          public          db    false    203            �            1259    16481    sys_jwt_blacklist    TABLE     �   CREATE TABLE public.sys_jwt_blacklist (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    jwt text
);
 %   DROP TABLE public.sys_jwt_blacklist;
       public         heap    db    false    3            �            1259    16479    sys_jwt_blacklist_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_jwt_blacklist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.sys_jwt_blacklist_id_seq;
       public          db    false    3    209            �           0    0    sys_jwt_blacklist_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.sys_jwt_blacklist_id_seq OWNED BY public.sys_jwt_blacklist.id;
          public          db    false    208            �            1259    16516    sys_operation_records    TABLE     �  CREATE TABLE public.sys_operation_records (
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
 )   DROP TABLE public.sys_operation_records;
       public         heap    db    false    3            �           0    0    COLUMN sys_operation_records.ip    COMMENT     A   COMMENT ON COLUMN public.sys_operation_records.ip IS '请求ip';
          public          db    false    213            �           0    0 #   COLUMN sys_operation_records.method    COMMENT     I   COMMENT ON COLUMN public.sys_operation_records.method IS '请求方法';
          public          db    false    213            �           0    0 !   COLUMN sys_operation_records.path    COMMENT     G   COMMENT ON COLUMN public.sys_operation_records.path IS '请求路径';
          public          db    false    213            �           0    0 #   COLUMN sys_operation_records.status    COMMENT     I   COMMENT ON COLUMN public.sys_operation_records.status IS '请求状态';
          public          db    false    213            �           0    0 $   COLUMN sys_operation_records.latency    COMMENT     D   COMMENT ON COLUMN public.sys_operation_records.latency IS '延迟';
          public          db    false    213            �           0    0 "   COLUMN sys_operation_records.agent    COMMENT     B   COMMENT ON COLUMN public.sys_operation_records.agent IS '代理';
          public          db    false    213            �           0    0 *   COLUMN sys_operation_records.error_message    COMMENT     P   COMMENT ON COLUMN public.sys_operation_records.error_message IS '错误信息';
          public          db    false    213            �           0    0 !   COLUMN sys_operation_records.body    COMMENT     E   COMMENT ON COLUMN public.sys_operation_records.body IS '请求Body';
          public          db    false    213            �           0    0 !   COLUMN sys_operation_records.resp    COMMENT     E   COMMENT ON COLUMN public.sys_operation_records.resp IS '响应Body';
          public          db    false    213            �           0    0 #   COLUMN sys_operation_records.userid    COMMENT     E   COMMENT ON COLUMN public.sys_operation_records.userid IS '用户id';
          public          db    false    213            �            1259    16514    sys_operation_records_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_operation_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.sys_operation_records_id_seq;
       public          db    false    3    213            �           0    0    sys_operation_records_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.sys_operation_records_id_seq OWNED BY public.sys_operation_records.id;
          public          db    false    212            �            1259    16492 	   sys_users    TABLE     �  CREATE TABLE public.sys_users (
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
    DROP TABLE public.sys_users;
       public         heap    db    false    3            �           0    0    COLUMN sys_users.uuid    COMMENT     9   COMMENT ON COLUMN public.sys_users.uuid IS '用户UUID';
          public          db    false    211            �           0    0    COLUMN sys_users.username    COMMENT     B   COMMENT ON COLUMN public.sys_users.username IS '用户登录名';
          public          db    false    211            �           0    0    COLUMN sys_users.password    COMMENT     E   COMMENT ON COLUMN public.sys_users.password IS '用户登录密码';
          public          db    false    211            �           0    0    COLUMN sys_users.nick_name    COMMENT     @   COMMENT ON COLUMN public.sys_users.nick_name IS '用户昵称';
          public          db    false    211            �           0    0    COLUMN sys_users.header_img    COMMENT     A   COMMENT ON COLUMN public.sys_users.header_img IS '用户头像';
          public          db    false    211            �           0    0    COLUMN sys_users.authority_id    COMMENT     E   COMMENT ON COLUMN public.sys_users.authority_id IS '用户角色ID';
          public          db    false    211            �            1259    16490    sys_users_id_seq    SEQUENCE     y   CREATE SEQUENCE public.sys_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.sys_users_id_seq;
       public          db    false    3    211            �           0    0    sys_users_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.sys_users_id_seq OWNED BY public.sys_users.id;
          public          db    false    210                       2604    16409    casbin_rule id    DEFAULT     p   ALTER TABLE ONLY public.casbin_rule ALTER COLUMN id SET DEFAULT nextval('public.casbin_rule_id_seq'::regclass);
 =   ALTER TABLE public.casbin_rule ALTER COLUMN id DROP DEFAULT;
       public          db    false    201    200    201            !           2604    16466    sys_base_menu_parameters id    DEFAULT     �   ALTER TABLE ONLY public.sys_base_menu_parameters ALTER COLUMN id SET DEFAULT nextval('public.sys_base_menu_parameters_id_seq'::regclass);
 J   ALTER TABLE public.sys_base_menu_parameters ALTER COLUMN id DROP DEFAULT;
       public          db    false    205    206    206                        2604    16455    sys_base_menus sys_base_menu_id    DEFAULT     �   ALTER TABLE ONLY public.sys_base_menus ALTER COLUMN sys_base_menu_id SET DEFAULT nextval('public.sys_base_menus_id_seq'::regclass);
 N   ALTER TABLE public.sys_base_menus ALTER COLUMN sys_base_menu_id DROP DEFAULT;
       public          db    false    203    204    204            "           2604    16484    sys_jwt_blacklist id    DEFAULT     |   ALTER TABLE ONLY public.sys_jwt_blacklist ALTER COLUMN id SET DEFAULT nextval('public.sys_jwt_blacklist_id_seq'::regclass);
 C   ALTER TABLE public.sys_jwt_blacklist ALTER COLUMN id DROP DEFAULT;
       public          db    false    209    208    209            &           2604    16519    sys_operation_records id    DEFAULT     �   ALTER TABLE ONLY public.sys_operation_records ALTER COLUMN id SET DEFAULT nextval('public.sys_operation_records_id_seq'::regclass);
 G   ALTER TABLE public.sys_operation_records ALTER COLUMN id DROP DEFAULT;
       public          db    false    213    212    213            #           2604    16495    sys_users id    DEFAULT     l   ALTER TABLE ONLY public.sys_users ALTER COLUMN id SET DEFAULT nextval('public.sys_users_id_seq'::regclass);
 ;   ALTER TABLE public.sys_users ALTER COLUMN id DROP DEFAULT;
       public          db    false    211    210    211            �          0    16406    casbin_rule 
   TABLE DATA                 public          db    false    201            �          0    16445    sys_authorities 
   TABLE DATA                 public          db    false    202            �          0    16473    sys_authority_menus 
   TABLE DATA                 public          db    false    207            �          0    16463    sys_base_menu_parameters 
   TABLE DATA                 public          db    false    206            �          0    16452    sys_base_menus 
   TABLE DATA                 public          db    false    204            �          0    16481    sys_jwt_blacklist 
   TABLE DATA                 public          db    false    209            �          0    16516    sys_operation_records 
   TABLE DATA                 public          db    false    213            �          0    16492 	   sys_users 
   TABLE DATA                 public          db    false    211            �           0    0    casbin_rule_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.casbin_rule_id_seq', 1, true);
          public          db    false    200            �           0    0    sys_base_menu_parameters_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.sys_base_menu_parameters_id_seq', 5, true);
          public          db    false    205            �           0    0    sys_base_menus_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.sys_base_menus_id_seq', 8, true);
          public          db    false    203            �           0    0    sys_jwt_blacklist_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.sys_jwt_blacklist_id_seq', 178, true);
          public          db    false    208            �           0    0    sys_operation_records_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.sys_operation_records_id_seq', 1, false);
          public          db    false    212            �           0    0    sys_users_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.sys_users_id_seq', 3, true);
          public          db    false    210            (           2606    16411    casbin_rule casbin_rule_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.casbin_rule
    ADD CONSTRAINT casbin_rule_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.casbin_rule DROP CONSTRAINT casbin_rule_pkey;
       public            db    false    201            +           2606    16449 "   sys_authorities sys_authorities_pk 
   CONSTRAINT     j   ALTER TABLE ONLY public.sys_authorities
    ADD CONSTRAINT sys_authorities_pk PRIMARY KEY (authority_id);
 L   ALTER TABLE ONLY public.sys_authorities DROP CONSTRAINT sys_authorities_pk;
       public            db    false    202            /           2606    16471 4   sys_base_menu_parameters sys_base_menu_parameters_pk 
   CONSTRAINT     r   ALTER TABLE ONLY public.sys_base_menu_parameters
    ADD CONSTRAINT sys_base_menu_parameters_pk PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.sys_base_menu_parameters DROP CONSTRAINT sys_base_menu_parameters_pk;
       public            db    false    206            -           2606    16460     sys_base_menus sys_base_menus_pk 
   CONSTRAINT     l   ALTER TABLE ONLY public.sys_base_menus
    ADD CONSTRAINT sys_base_menus_pk PRIMARY KEY (sys_base_menu_id);
 J   ALTER TABLE ONLY public.sys_base_menus DROP CONSTRAINT sys_base_menus_pk;
       public            db    false    204            1           2606    16489 &   sys_jwt_blacklist sys_jwt_blacklist_pk 
   CONSTRAINT     d   ALTER TABLE ONLY public.sys_jwt_blacklist
    ADD CONSTRAINT sys_jwt_blacklist_pk PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.sys_jwt_blacklist DROP CONSTRAINT sys_jwt_blacklist_pk;
       public            db    false    209            3           2606    16504 &   sys_jwt_blacklist sys_jwt_blacklist_un 
   CONSTRAINT     `   ALTER TABLE ONLY public.sys_jwt_blacklist
    ADD CONSTRAINT sys_jwt_blacklist_un UNIQUE (jwt);
 P   ALTER TABLE ONLY public.sys_jwt_blacklist DROP CONSTRAINT sys_jwt_blacklist_un;
       public            db    false    209            5           2606    16500    sys_users sys_users_pk 
   CONSTRAINT     T   ALTER TABLE ONLY public.sys_users
    ADD CONSTRAINT sys_users_pk PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sys_users DROP CONSTRAINT sys_users_pk;
       public            db    false    211            7           2606    16513    sys_users sys_users_un 
   CONSTRAINT     [   ALTER TABLE ONLY public.sys_users
    ADD CONSTRAINT sys_users_un UNIQUE (uuid, username);
 @   ALTER TABLE ONLY public.sys_users DROP CONSTRAINT sys_users_un;
       public            db    false    211    211            )           1259    16412    unique_index    INDEX     e   CREATE UNIQUE INDEX unique_index ON public.casbin_rule USING btree (p_type, v0, v1, v2, v3, v4, v5);
     DROP INDEX public.unique_index;
       public            db    false    201    201    201    201    201    201    201            �   
   x���          �   �   x���v
Q���W((M��L�+�,�O,-��/�,�L-Vs�	uV�P7202�50�54Q00�26�2��60P�Q�-������� ){6s�ˆYϧ�xֱ�7P״��ѝ�t��'��ܤu"�\cij	���/�OE8 \\ |�v�      �   �   x����
�@��W1;":���V-\a��V2���H]x�A���;���<�//��X����34��:�Ʈ����m��~�^Cgλ�)+�$���3#�m��Rq���
�	.׸����2ť,x�	g$ܑpH�%	�$ܒpL�5)פ7�kR�I�&嚔kR�I�&���ϔ�x��D鮺�<إİK�a��.%�]J�4�_�aO��D�xB�� h)} 㿕Q�0�vB      �   t   x���v
Q���W((M��L�+�,�OJ,N��M�+�/H,J�M-I-*Vs�	uV�0�QP7202�50�52T00�26�20�60P�'��㣣`TR�Z\bh�c�Y���\\\ w�&�      �      x���[S�F���~��Ʊ-ȍ>e�<0ÐNy���;�Z�.!��&N����)�m&-0���8�3��O�݋l]"�h��=���sV��woݙȍ�O��UͲ����~�,��~����w}l����7�Kr�BQ(勥|i8WF���������V�'��.�ؤ4LE�@7�"�� O=�`��� �	��б)@U/>0�u�B��L���j��^p׷����j��\����~?0���Y��,�3e$jrT	v�X����������I�À�t:���P�r���*Ю{Z�iݕ�P��}Tso��w���F�Lhy)PN7�n���Ac>����6���`����{FK70/���*�@3�|��30���2�xPB�mk�l�˿��&-�����
���*$~D�q�R������Rz�J_pȋy@d�^<��Xع�N��ǒvTE�úڗ�\GjHb.`dl��H��;�Ѱ>�8,�u]���k}��JUa1�2o:�/�}�W�����xj5�XVD��g6R��bV�k�FJPH������]�N��r}���i� }-+e.�Ϭ*H�CR" [��RBX.Y����g�V+p�t`B_��g�Ⰹj���E@䆩������m�aܞA3�#��P�*r"dg�+x�Wb���8g������rZo>v����r��{�.enS�]�+����9�z���~h��m���];� �yX4 ���(3tv@ ���F�4.�o�7.;��q	*�4���ٔ��+>�e!���do�6�̩�Ֆ�־מ����՟652�������kp|#{��q��{i�N�~GE(#4�R"gn"�7�!B�0��H#�;�~�=n�}h��<��ܚ���	~�E�׻6�vG�$��/K?/[�-��{�=�G���q���:$�f�VEV�b3�*lU����J����w��bݫR�f�?�	t���!!��ߟ[������ґ��-�
2���@�)�sH��R�\Dau�ϩ����@u���#�+Vg��6X3
��0~���$C��"�_�û�M�N�9�$�㶩�܂̝Fx~А�ϒ�Sgo�g����efl���-Hx#&uW��)ƏM�2��j}v�w���2@�cK�;sS q� ��do�/-cP7
�!ө��+k��c��ǽW��-T���sЈ�Y\���T��~g\�}$�|�e���4�B�N�Rq�I���j<�TV�_r#�N��$�A���"j!������l|t[k�?��'f�w��{�      �      x��[�����y�|���۝nIm(�f�������QT�n@>}����y���{�Κ\�5g~�b���%�c�0�#�����u��z��~��e��ͽp�=_�3i-i���������/l � �?@���#���>��p��V��f���ڶ/[�խ|����2'�G{��S&M&�N�����@1;7�.JЊ�6 JW�Cs�]��v��S=QM��
���vl�[-h���$s��ՙ�]�Y��1.���.��YL��˞����̻�>�2�柱�YM���v����Q�Y���g�j�'J;ٺ�&�����t�L*�s�����(�矽�����S2����:�Z�i��!H�(8�d��۞~���c�v��+��S�C��������e.�	���jp%A]�ibx.��\��SC�`�o�r��Ѹ7S�ݳ��v���ˮ+	�Tξ�l^Կ'TqaY����'Am��:��\��;G��}9вA��P����Ӱ�=_4�A�J�M;�)
߃�e.�@Q±�\IPp��rp��N�M猸���t���t:�x�Iw��iﶲ��qv����������%n��k�)��~�-��b�����da���h�X��T:�`��bU ���hӻ�=6X��2�)��^j .SD)���-8Ul��\w=\Km�q���B����#{Tf�4S�`/�g�-� �����>�3�\
)����ɱ��en5����ے=��V�e{B�}�4�� ׉=�Ў+�{l����?�G�bX����&؀jZ�l��Y8�&��ھk!;�M��L�<��{�e9��"u,/����Ɩ��@`X���Pͭ$�	8����D G��/��,|w�:}��Pv����;��^��A2��e��Ń�G��p�+^_,DV����&�oU��N.�qo-��.�؉2_�o�����s�`v	�7'���}�M�2�8��E�\IPp2PL�7��*�W��N��	'���P��$��I�m���"���:\��~H�$����0���[�ym�e:���'9�èͮ`{���y�`�ǁ���#֦��{���D���zJX� �r��ȤJPp�)�ވ��rp�crx���#~�i�ә�Q�
;gͭ��D��\#�}���A�QW%p�k������&'j�$9���O�:��4�]�JG�/�6�u����-��R����{�Kr,���8�He`R%�	8\l��+�_&+jM�@���Ri�z���'�8Y����������7��1ɹ�8��9�+�	����}����2���F�	�x�ܦ�>�����S����j���zٔW�(�{߃{vL�?��C@�������35.�)[`��S56������������[K�8,p�����n�C>���2��������Gy&Vl��U���]B��$J�'���h�y��g�
}��:��ߺ<�	�ߎ2�����m���˛��5M�7`s���A|�f=��3��0[��y�F`UhR%��T�]�Bst���{H�`u5�ib4��|�l��v�/�����wt��7�}����' �e+ѕ5BǪ��:%_��(��u�@�p���,o��K4��|�o%-�����s�Ή��,d���
P��A�5��?@��5Ӡ��vt��q��:{�@U�r���v������;�-���;���?���le^%�:�Ǘ��˿�C��h���aa5NWGi=��n"��Dw���)�uC��=�'2�e�W��$��L�]�Rfw�͵�V�<�G��ұ�V��,��f�Z�����{t�JN��s6F�D�S�uB�ᆉ��6�Z0We�y�t��d*\��;ZwzY�������gE�C�S&��0�:M��V3�tD��_v���	��G�e_�7)U8�Ԍ=�T85[��7L��G��py���o2�
]IPtQ�O�'U�<9��8��0��:Nu)�]K�У���]��l?�������vR��!e�����q��i�(N�!�pJ�ݩوoͩ��e'��*���qX�=���mw���؞}���X��R�*A��Y��P�a�gg�M.j,�cv]$�}JoI�ZZ�OfR�&�u��{�vRd����U�e��>��<%�$Dq�J��(`7[��:�V-i2N�h��&���c��\o��f{��ߣ{vRdX��8�Ꜯ,�:Ut>B��.eN"Z���Q����ն�o�s���x������u˛|��e'�8��,�,��
]��	��6��i~7h�mȱ�M���l�P8Q�0��ֆ���hܽ�ʗ���<�ʿ��]���{tY��Pf���?��$]�q��Ϧh�S�c74��r鹗*+���ɗ�,W�kWW�V	j�}v�㰏�ۨ��*R��o�x��ɶ��C���`+f	{�Y���a�����!,�lujP�	�f~b�9�f���@N|SL��!��Yw/��m~IB���5�V�6���=;)��8���*۫�Q�O�/U���u&�7Ɔ�XːnV�i�O����98�N��������I����c8(T4;�����0%��,S��r����[�����o7�NE������PѹM��0�g'��A�1#��*m�x^#p0�
?�� O<�/�cƟ�����%Á��ش	k�����}|)<{)9�G����E)U��#�G�=a��=⭻q���:��u�3�]	�� !np݀�E����!X��ˉ�g/%'#�6 �U%�U����>,(
�]<G �}:��I�!]LW��
gK��]94�h{x����Z�`�@* �bՕ5B�gu����<���t�|��Vr���q?.g�]�4��h��!;�-����r��ݳ�B�.Ns(YX��,���N���qR���p-w�į�{|Q���qM�:	O����pE߷>
�^
-�PQ��U	y��F��ёO����G�]�l�e鬝O�>H��:ES��N��<_�f|K���������a�e`�U6X��F���&~l�h�D�L��h�[,Z����Ψw[�l4<+��>umԽq?l��^
-����<BuVW������dM�G>Zw|��h�0Rr��H���~j��F��Ȟ��9����Yݓ��_�gx@+N*�P��ˬ�� �.#�qu�!�;O�u;L[�b`Qn���.S�%Nk��-�������ĥ�(��b��x�U
��O5�� ��i�2cx�,��t�:�ٻn;I?Jd�\]�ws�������	����YV�^seA��A5��I�d�f.e��]��>]�֣���·�IQ �7�cw͇�U,�!Y}_F�7'�sj ���x�D��y���϶K%}l�Y�iw/u����qk����\w}n�^c����c���(.�!E��C�#�r�����L+ӽ��41��t*e|{���ө�6.�&�W�t\Fh��f�ƨ����]��}ʖ�`\��<��������x�+E2�t�s=�Y=joQ'.O�BJM�9t�2؏��]��HI��GC(,���~^p^���.5S�C�|��� ��x.��$E;� �Z��O�&4��EF�a���E����"���#�RD���A��5{_}��Cj6�n�"q�rM����������T���k8�t���?$|�W�y	D@������T3���6�Ī����҈�p���!�����$�"g��ɭ���^32���0*���E��"��ӽ�Rķu`:V[�9J'K�V��={�z5"&�4�7���ޜm�X��f�n��͐�V�!�A, ����:�S��������ƾ���ŋ{���祜�l�Y7ln�}g6���h�}N(����B �;fYP+v�{��+�{7v��L�8;�� d{��A�:�n#61�y��u����D�2����8�܄�BP#vD1�*9;=U�<P����:��@nx�l������!�a"���怺��{TF#<��#��kP��6�f���=2(��բ�u    Ҏ����S�&�7��ǧ=�Y��Y������p6k���3rp����J����N�^j�.S��(�A��Ͻ���z�v���Ưc_1�qc����<�S�e���>Ƅ�}B#�=�����C��̂����#�;g�Q�9���։�y��F}�.���%��[Y! UhX�a1�HU�Y%��̹+��&P̜�rsڌ�c\�s�s�a�{�A��% c��d0V�o���R���<�� h�����V��W7�cWT7�ְ�&W�lY`��ڥv|?ϧ�����f�v4��׿�{�T�bh��@\�h}!�;�ļ�Q$��{�gم��2{=�G��y�K����~g�T�����!x6U�2�-Nv�ٕ�a��?�����c�N�5Ϭ�Y�Ü�����f������SE]��������ݳ�B��B����n�Ԉ]�|�.�Urv�-㽨eݮ:8-�?�F��CV�dY�6Gۀ��x�_�ᳫB�U�@hE{�A}؅�=Z9��f����}��&�@��2~fɬ���f6����w�*:��F�=>�*�~�gB[��W	jĎ��[#v�Z�F���d���c�}���p=
�^|���p�h��[���;��<B e(� _�g�ua��)�9љ�ω'S���ˬ�����8[r�R,�b~68�����u�?}H�����#���O]_<�9=S)y_ҧ`Ŵ��z2xG������5���F�� ���^�9����|_D!["C��d����:�_	j�.ϸ߽����翬���u�i���|Y��x2o]��؎����
���_vL���r~>�y�>�d�~�sA�as�]g|b�����zF��r����;�iทc$#%Կ/ꃐ+��y��D�\t�kD�(ٻ�� �J�g��q����qӎ��Rޙ���41ؘ8�V<2��=�n�B��"�o�9S�4�敠N�ޏw���1��jO��B�����E�����;�܄%o9��n�n<�%��hw� �������>슑���])ʠ�7O���M��N�gc�7�o=��:���@����2i	�ō�+�R�+A�إ��QSv�Z���]��v����"[���Lᕏ�脠�C+w�g�?�"PFSܓ��<��zݕ5b�݉��VD�23�ֶ�k�u�*�T}���m!��}4�b�9m~8A@����.8&�솽ԉ������=&�����w_�iܔp<t��:҅b��D@�t^�~�C����? �e��ҭ��aWT�|��j���)=Ζ�sg2���`�Czm���8�7�b��>�&׮�C^���ǁ8b�#�?�ܽԇ�����"g4��
v�]_6�}�.z����0����Ds�A��o�V��x��,Z��=�8 `!�9��p�Ԉ��}4����Ѐ���n���=b����L��w��.r�\�Q���	�gO�q�"�����3�5b�?\w���>��8�xs�홿N��1&>�pAY><ǽ_��gW�1�s'�Ԇ�JPvQ�r�[��旫<��~r;	��9n�Uw�r��l�If+̇"�3�K���E�eq-$�W�T	��.׿��)�M^E����X��w��c[�U8��^�kUS�Q�n�����z�Ur4l1_@$Uvf��>���}u߃��Q�7�\�˛2h��d�����=�φ�ْ/AC�7��C�3��<
Q �p��R���u"�������Z��DV�v�>�D��'��7;����K�W{r=�g�q��S�8����gW�Q�� �6̊�!�5���i���q�֪K��/o���&_L'J`,h�E���asP�1�~Xs��S��1)0_S�V�U����W=��G��t�7@��ܘ�`b��m̷�<G`{>d�����C	~�T�	3���W����25�$?������9�Ֆ�]K�����M˵���'c']����m:�6g?����S���,��
��ˬԈ]���eV����9��@�Q;\�m�e���90/��M�zV�9bK8ߜ�Cn��<�b*,���r���JA}��W�s��S��`t߰��"xN�׸�����9M�Ql���%�~y��OO�ǲ"�U"����9/%����G�·�u�N�?Ƙi��;�F<q�8L��}�#D{�ýZ�OO�Ť�1� ����&쐚yXy[Q����E�EE�l};�1ߎ۷Cz���{:ٞ�:v$@ ����#��'4��� d(WŮJPvXɊy���r=U2���K��q��n1^�2�qw�������n*�|�)���PR�"�;u���ua��2��� )�y�����zg�^g��Bk5��>߳m�Nf�K���������-�a�K�9��y>Cx%�;)og�=رJ1����4I2�jY7Sn���E�vsK������ۺ��I�C��А?��� @�����N���]������q�`"
tt�nq����$����fә7��X��Z?��`��<�&E)
 ����*Amؙ͜߻>=UE��EL{>���.����e�:���3��2��P\����v~8weQW�!4�=���a�� okU
v~��*A�6g�%�!֎rfOa��V�l_�%�)�I�|�Վ?�*,.����,��3�ub�~�?v�9T����njg��9:S@�Ɓ3T�d?5&�DXa�
��L�-�)�x��-�]�JPvz�������-�o��@Y����F�U]�{�=���<\���͹�-��?����	Mq��D$y��\W�JP#v9���ej᫘���e�����q�I1���٦5Ѻ�Dj�<8���䇎I��W�7#sƨ�2�JPvT���]�yLS���3w&��i���l����;��_xǘ��0�'��d��e�|�U�G9`�?��ԇ���e�;��e�]cD��cl�ejOB����[���aq���m GQ(/���CC��W�vV@,��27�Ԉx�G�`�������ٳީC���Lά��h��*i�WSʞ.��$?�*쳯�@9b�����ׇ\=���+�ə���k��5�K��p�kd�N���;�j١E��1"�Nȳ��R����JP+voo��ov��1�����Q��Ͳ����Ȍ]v��$�]�����Z��_�=�*Bq�5�L9���Ԉ]����9;V-ffN#HX���~k�-�kB,���'/D����ɲ����	yvU��PB�.uM�Ԉ��8b�����U �Ƣ��L�6�.�WRf������MF�]߬1��ES$�"���?��a&�� ��� �ﯗҀf��`��Yc������]�����!��/����U�;�C)�
U�5b�s�h�ej�������^6�+	a{fL�uW�M���̎��_�wϮ�P\���"�,�^weA��e�=����t�̻?�}$���d?nGO�=��ٱ�n��/�]�0�PQ�D�r3�5b���b�hE���\�=<sT�⺺2��L�r���l��ֳ��C=;yvU�����3_	j�.h��/),�����M�e��HI8{�o��:��w�Ǯ�i��a��Pڍ��/�ʳ�"<.�@�_�����F��7�=��Ǎi��z�וH�S��\���̖:��@ <�(��8�2��<�*4�3Lau~WԈ�̉��Én]v-~ӟ6�v+���`��5l,xޢւG3~y�-�\��fre_�8$�A�&��Ԋ��n��fWt#�l�d3mn���P�GJOth"񉵙�N�Q�f��8����ʾ
ኋ[�˝�5b��w�?ر�Ns!����)=d�=�	L�&/��2�%7g~�E�N�g_���1�����JPv�>�3-�=N�Q��|z�/�§h�ݝ�m��&og\.��9��~�3�}ZX͏Y�����*A}����9�;'{����G8[���l����Y�d*�Q �@N}������
?��W�ˋc8,��j�*A���?[wx���qٗ��'�ܢ����%�/ �  �h�<��������ll_g?܉�=�*y��Ű����^	j�������<�w�4��E ��Z\�K�v��M[	������mu�+���<�*��d�1���W�J���S���
vxt�)Y�/�LµfZ;���76kN�]��F�KrZ�t�/�{�Uh1�(G�#�&־Ԉ]1��vP)f<Lf�P�-�I�OԻii��b�W-i�x��jwVk����pϾ
-.pE��!��άԈT>�4*&g���D\��fw��Cp	`�4�o=��4�=ng0�Ӽw���ĸg_��L #P���3�5b�j�Tg�~�ՙ��yw�h�E�x��9�/�y�����ۃ(��u�iT���B�X�	�A�U�J��>���M{��wo���[ӻ�5�N�8H�^��`4�C���]
��)�~a��@�{�2�Ǵ�V�z^#r����r�q����Mr��|���>h���~5f�$6���]��5?�x�Q���Ϳ*�v������GQf�LQf{=�����x��Ӽ�o�ڕ��a.�̱]���y\FSԣ0 aZU�Y)�;�����ة���D���'�6��V��cb�ׅ� ��K��4�G�g�h��ʁ@*N�*�a�$�*A��pU�u}�ӈ�����Dxق�p��Ѿ�����C�OJh .
�X�#U�y��F�r.��L-f<�7����c>Q��)/���sҙ�t�+�M,
40�e����M��Ex%��L3?8
�P3;���6�����ߋ��n{H.�T��.X��lbެkO�~�4��2Rl�<�D�3˂����2���z3�f;�<��Hm,{� B����{����IW��ޝN�x�������<[9'�RP#v�89;�����L,w���ut��lf�	vA$����f�.Z�$}8b��_�/���W      �   
   x���          �   �   x���KK�P���wEo:��p墋@�`[�r�Xl����77��H���9��f��Em�}B��?�C3|��!}��ۭ7�ݣ�%����XJ� ���~�u�O�JAÎ����{o +�
�W��9��2L̒&i��:y�H"����2%3�ateyǓ]��ij�ք�c�����C�^s  �.����Y�.���,0��C���ṕD�z�|��q�q5�\��.���0�o�      X    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16384    testdb    DATABASE     Z   CREATE DATABASE testdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';
    DROP DATABASE testdb;
                db    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                db    false            �           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   db    false    3            �            1259    16406    casbin_rule    TABLE       CREATE TABLE public.casbin_rule (
    id bigint NOT NULL,
    p_type character varying(40),
    v0 character varying(40),
    v1 character varying(40),
    v2 character varying(40),
    v3 character varying(40),
    v4 character varying(40),
    v5 character varying(40)
);
    DROP TABLE public.casbin_rule;
       public         heap    db    false    3            �            1259    16404    casbin_rule_id_seq    SEQUENCE     {   CREATE SEQUENCE public.casbin_rule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.casbin_rule_id_seq;
       public          db    false    201    3            �           0    0    casbin_rule_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.casbin_rule_id_seq OWNED BY public.casbin_rule.id;
          public          db    false    200            �            1259    16445    sys_authorities    TABLE     +  CREATE TABLE public.sys_authorities (
    created_at timestamp with time zone,
    updated_at timestamp(0) with time zone,
    deleted_at timestamp(0) with time zone,
    authority_id character varying(90) NOT NULL,
    authority_name character varying(191),
    parent_id character varying(191)
);
 #   DROP TABLE public.sys_authorities;
       public         heap    db    false    3            �           0    0 #   COLUMN sys_authorities.authority_id    COMMENT     E   COMMENT ON COLUMN public.sys_authorities.authority_id IS '角色ID';
          public          db    false    202            �           0    0 %   COLUMN sys_authorities.authority_name    COMMENT     H   COMMENT ON COLUMN public.sys_authorities.authority_name IS '角色名';
          public          db    false    202            �           0    0     COLUMN sys_authorities.parent_id    COMMENT     E   COMMENT ON COLUMN public.sys_authorities.parent_id IS '父角色ID';
          public          db    false    202            �            1259    16473    sys_authority_menus    TABLE     �   CREATE TABLE public.sys_authority_menus (
    sys_authority_authority_id character varying(90),
    sys_base_menu_id numeric
);
 '   DROP TABLE public.sys_authority_menus;
       public         heap    db    false    3            �           0    0 5   COLUMN sys_authority_menus.sys_authority_authority_id    COMMENT     W   COMMENT ON COLUMN public.sys_authority_menus.sys_authority_authority_id IS '角色id';
          public          db    false    207            �            1259    16463    sys_base_menu_parameters    TABLE     Y  CREATE TABLE public.sys_base_menu_parameters (
    id bigint NOT NULL,
    createed_at timestamp(0) with time zone,
    updateed_at timestamp(0) with time zone,
    deleteed_at timestamp(0) with time zone,
    sys_base_menu_id bigint,
    addtype character varying(191),
    addkey character varying(191),
    addvalue character varying(191)
);
 ,   DROP TABLE public.sys_base_menu_parameters;
       public         heap    db    false    3            �           0    0 '   COLUMN sys_base_menu_parameters.addtype    COMMENT     j   COMMENT ON COLUMN public.sys_base_menu_parameters.addtype IS '地址栏携带参数为params还是query';
          public          db    false    206            �           0    0 &   COLUMN sys_base_menu_parameters.addkey    COMMENT     [   COMMENT ON COLUMN public.sys_base_menu_parameters.addkey IS '地址栏携带参数的key';
          public          db    false    206            �           0    0 (   COLUMN sys_base_menu_parameters.addvalue    COMMENT     ]   COMMENT ON COLUMN public.sys_base_menu_parameters.addvalue IS '地址栏携带参数的值';
          public          db    false    206            �            1259    16461    sys_base_menu_parameters_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_base_menu_parameters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.sys_base_menu_parameters_id_seq;
       public          db    false    3    206            �           0    0    sys_base_menu_parameters_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.sys_base_menu_parameters_id_seq OWNED BY public.sys_base_menu_parameters.id;
          public          db    false    205            �            1259    16452    sys_base_menus    TABLE     !  CREATE TABLE public.sys_base_menus (
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
 "   DROP TABLE public.sys_base_menus;
       public         heap    db    false    3            �           0    0    COLUMN sys_base_menus.parent_id    COMMENT     D   COMMENT ON COLUMN public.sys_base_menus.parent_id IS '父菜单id';
          public          db    false    204            �           0    0     COLUMN sys_base_menus.routerpath    COMMENT     D   COMMENT ON COLUMN public.sys_base_menus.routerpath IS '路由path';
          public          db    false    204            �           0    0     COLUMN sys_base_menus.routername    COMMENT     D   COMMENT ON COLUMN public.sys_base_menus.routername IS '路由name';
          public          db    false    204            �           0    0    COLUMN sys_base_menus.hidden    COMMENT     K   COMMENT ON COLUMN public.sys_base_menus.hidden IS '是否在列表隐藏';
          public          db    false    204            �           0    0    COLUMN sys_base_menus.component    COMMENT     Q   COMMENT ON COLUMN public.sys_base_menus.component IS '对应前端文件路径';
          public          db    false    204            �           0    0    COLUMN sys_base_menus.sort    COMMENT     @   COMMENT ON COLUMN public.sys_base_menus.sort IS '排序标记';
          public          db    false    204            �           0    0     COLUMN sys_base_menus.keep_alive    COMMENT     F   COMMENT ON COLUMN public.sys_base_menus.keep_alive IS '附加属性';
          public          db    false    204            �           0    0 "   COLUMN sys_base_menus.default_menu    COMMENT     H   COMMENT ON COLUMN public.sys_base_menus.default_menu IS '附加属性';
          public          db    false    204            �           0    0    COLUMN sys_base_menus.title    COMMENT     A   COMMENT ON COLUMN public.sys_base_menus.title IS '附加属性';
          public          db    false    204            �           0    0    COLUMN sys_base_menus.icon    COMMENT     @   COMMENT ON COLUMN public.sys_base_menus.icon IS '附加属性';
          public          db    false    204            �            1259    16450    sys_base_menus_id_seq    SEQUENCE     ~   CREATE SEQUENCE public.sys_base_menus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.sys_base_menus_id_seq;
       public          db    false    3    204            �           0    0    sys_base_menus_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.sys_base_menus_id_seq OWNED BY public.sys_base_menus.sys_base_menu_id;
          public          db    false    203            �            1259    16481    sys_jwt_blacklist    TABLE     �   CREATE TABLE public.sys_jwt_blacklist (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    deleted_at timestamp with time zone,
    jwt text
);
 %   DROP TABLE public.sys_jwt_blacklist;
       public         heap    db    false    3            �            1259    16479    sys_jwt_blacklist_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_jwt_blacklist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.sys_jwt_blacklist_id_seq;
       public          db    false    3    209            �           0    0    sys_jwt_blacklist_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.sys_jwt_blacklist_id_seq OWNED BY public.sys_jwt_blacklist.id;
          public          db    false    208            �            1259    16516    sys_operation_records    TABLE     �  CREATE TABLE public.sys_operation_records (
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
 )   DROP TABLE public.sys_operation_records;
       public         heap    db    false    3            �           0    0    COLUMN sys_operation_records.ip    COMMENT     A   COMMENT ON COLUMN public.sys_operation_records.ip IS '请求ip';
          public          db    false    213            �           0    0 #   COLUMN sys_operation_records.method    COMMENT     I   COMMENT ON COLUMN public.sys_operation_records.method IS '请求方法';
          public          db    false    213            �           0    0 !   COLUMN sys_operation_records.path    COMMENT     G   COMMENT ON COLUMN public.sys_operation_records.path IS '请求路径';
          public          db    false    213            �           0    0 #   COLUMN sys_operation_records.status    COMMENT     I   COMMENT ON COLUMN public.sys_operation_records.status IS '请求状态';
          public          db    false    213            �           0    0 $   COLUMN sys_operation_records.latency    COMMENT     D   COMMENT ON COLUMN public.sys_operation_records.latency IS '延迟';
          public          db    false    213            �           0    0 "   COLUMN sys_operation_records.agent    COMMENT     B   COMMENT ON COLUMN public.sys_operation_records.agent IS '代理';
          public          db    false    213            �           0    0 *   COLUMN sys_operation_records.error_message    COMMENT     P   COMMENT ON COLUMN public.sys_operation_records.error_message IS '错误信息';
          public          db    false    213            �           0    0 !   COLUMN sys_operation_records.body    COMMENT     E   COMMENT ON COLUMN public.sys_operation_records.body IS '请求Body';
          public          db    false    213            �           0    0 !   COLUMN sys_operation_records.resp    COMMENT     E   COMMENT ON COLUMN public.sys_operation_records.resp IS '响应Body';
          public          db    false    213            �           0    0 #   COLUMN sys_operation_records.userid    COMMENT     E   COMMENT ON COLUMN public.sys_operation_records.userid IS '用户id';
          public          db    false    213            �            1259    16514    sys_operation_records_id_seq    SEQUENCE     �   CREATE SEQUENCE public.sys_operation_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.sys_operation_records_id_seq;
       public          db    false    3    213            �           0    0    sys_operation_records_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.sys_operation_records_id_seq OWNED BY public.sys_operation_records.id;
          public          db    false    212            �            1259    16492 	   sys_users    TABLE     �  CREATE TABLE public.sys_users (
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
    DROP TABLE public.sys_users;
       public         heap    db    false    3            �           0    0    COLUMN sys_users.uuid    COMMENT     9   COMMENT ON COLUMN public.sys_users.uuid IS '用户UUID';
          public          db    false    211            �           0    0    COLUMN sys_users.username    COMMENT     B   COMMENT ON COLUMN public.sys_users.username IS '用户登录名';
          public          db    false    211            �           0    0    COLUMN sys_users.password    COMMENT     E   COMMENT ON COLUMN public.sys_users.password IS '用户登录密码';
          public          db    false    211            �           0    0    COLUMN sys_users.nick_name    COMMENT     @   COMMENT ON COLUMN public.sys_users.nick_name IS '用户昵称';
          public          db    false    211            �           0    0    COLUMN sys_users.header_img    COMMENT     A   COMMENT ON COLUMN public.sys_users.header_img IS '用户头像';
          public          db    false    211            �           0    0    COLUMN sys_users.authority_id    COMMENT     E   COMMENT ON COLUMN public.sys_users.authority_id IS '用户角色ID';
          public          db    false    211            �            1259    16490    sys_users_id_seq    SEQUENCE     y   CREATE SEQUENCE public.sys_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.sys_users_id_seq;
       public          db    false    3    211            �           0    0    sys_users_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.sys_users_id_seq OWNED BY public.sys_users.id;
          public          db    false    210                       2604    16409    casbin_rule id    DEFAULT     p   ALTER TABLE ONLY public.casbin_rule ALTER COLUMN id SET DEFAULT nextval('public.casbin_rule_id_seq'::regclass);
 =   ALTER TABLE public.casbin_rule ALTER COLUMN id DROP DEFAULT;
       public          db    false    201    200    201            !           2604    16466    sys_base_menu_parameters id    DEFAULT     �   ALTER TABLE ONLY public.sys_base_menu_parameters ALTER COLUMN id SET DEFAULT nextval('public.sys_base_menu_parameters_id_seq'::regclass);
 J   ALTER TABLE public.sys_base_menu_parameters ALTER COLUMN id DROP DEFAULT;
       public          db    false    205    206    206                        2604    16455    sys_base_menus sys_base_menu_id    DEFAULT     �   ALTER TABLE ONLY public.sys_base_menus ALTER COLUMN sys_base_menu_id SET DEFAULT nextval('public.sys_base_menus_id_seq'::regclass);
 N   ALTER TABLE public.sys_base_menus ALTER COLUMN sys_base_menu_id DROP DEFAULT;
       public          db    false    203    204    204            "           2604    16484    sys_jwt_blacklist id    DEFAULT     |   ALTER TABLE ONLY public.sys_jwt_blacklist ALTER COLUMN id SET DEFAULT nextval('public.sys_jwt_blacklist_id_seq'::regclass);
 C   ALTER TABLE public.sys_jwt_blacklist ALTER COLUMN id DROP DEFAULT;
       public          db    false    209    208    209            &           2604    16519    sys_operation_records id    DEFAULT     �   ALTER TABLE ONLY public.sys_operation_records ALTER COLUMN id SET DEFAULT nextval('public.sys_operation_records_id_seq'::regclass);
 G   ALTER TABLE public.sys_operation_records ALTER COLUMN id DROP DEFAULT;
       public          db    false    213    212    213            #           2604    16495    sys_users id    DEFAULT     l   ALTER TABLE ONLY public.sys_users ALTER COLUMN id SET DEFAULT nextval('public.sys_users_id_seq'::regclass);
 ;   ALTER TABLE public.sys_users ALTER COLUMN id DROP DEFAULT;
       public          db    false    211    210    211            �          0    16406    casbin_rule 
   TABLE DATA                 public          db    false    201   H       �          0    16445    sys_authorities 
   TABLE DATA                 public          db    false    202   b       �          0    16473    sys_authority_menus 
   TABLE DATA                 public          db    false    207          �          0    16463    sys_base_menu_parameters 
   TABLE DATA                 public          db    false    206   �       �          0    16452    sys_base_menus 
   TABLE DATA                 public          db    false    204   {       �          0    16481    sys_jwt_blacklist 
   TABLE DATA                 public          db    false    209   �       �          0    16516    sys_operation_records 
   TABLE DATA                 public          db    false    213   D       �          0    16492 	   sys_users 
   TABLE DATA                 public          db    false    211   ^       �           0    0    casbin_rule_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.casbin_rule_id_seq', 1, true);
          public          db    false    200            �           0    0    sys_base_menu_parameters_id_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.sys_base_menu_parameters_id_seq', 5, true);
          public          db    false    205            �           0    0    sys_base_menus_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.sys_base_menus_id_seq', 8, true);
          public          db    false    203            �           0    0    sys_jwt_blacklist_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.sys_jwt_blacklist_id_seq', 178, true);
          public          db    false    208            �           0    0    sys_operation_records_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.sys_operation_records_id_seq', 1, false);
          public          db    false    212            �           0    0    sys_users_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.sys_users_id_seq', 3, true);
          public          db    false    210            (           2606    16411    casbin_rule casbin_rule_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.casbin_rule
    ADD CONSTRAINT casbin_rule_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.casbin_rule DROP CONSTRAINT casbin_rule_pkey;
       public            db    false    201            +           2606    16449 "   sys_authorities sys_authorities_pk 
   CONSTRAINT     j   ALTER TABLE ONLY public.sys_authorities
    ADD CONSTRAINT sys_authorities_pk PRIMARY KEY (authority_id);
 L   ALTER TABLE ONLY public.sys_authorities DROP CONSTRAINT sys_authorities_pk;
       public            db    false    202            /           2606    16471 4   sys_base_menu_parameters sys_base_menu_parameters_pk 
   CONSTRAINT     r   ALTER TABLE ONLY public.sys_base_menu_parameters
    ADD CONSTRAINT sys_base_menu_parameters_pk PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.sys_base_menu_parameters DROP CONSTRAINT sys_base_menu_parameters_pk;
       public            db    false    206            -           2606    16460     sys_base_menus sys_base_menus_pk 
   CONSTRAINT     l   ALTER TABLE ONLY public.sys_base_menus
    ADD CONSTRAINT sys_base_menus_pk PRIMARY KEY (sys_base_menu_id);
 J   ALTER TABLE ONLY public.sys_base_menus DROP CONSTRAINT sys_base_menus_pk;
       public            db    false    204            1           2606    16489 &   sys_jwt_blacklist sys_jwt_blacklist_pk 
   CONSTRAINT     d   ALTER TABLE ONLY public.sys_jwt_blacklist
    ADD CONSTRAINT sys_jwt_blacklist_pk PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.sys_jwt_blacklist DROP CONSTRAINT sys_jwt_blacklist_pk;
       public            db    false    209            3           2606    16504 &   sys_jwt_blacklist sys_jwt_blacklist_un 
   CONSTRAINT     `   ALTER TABLE ONLY public.sys_jwt_blacklist
    ADD CONSTRAINT sys_jwt_blacklist_un UNIQUE (jwt);
 P   ALTER TABLE ONLY public.sys_jwt_blacklist DROP CONSTRAINT sys_jwt_blacklist_un;
       public            db    false    209            5           2606    16500    sys_users sys_users_pk 
   CONSTRAINT     T   ALTER TABLE ONLY public.sys_users
    ADD CONSTRAINT sys_users_pk PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sys_users DROP CONSTRAINT sys_users_pk;
       public            db    false    211            7           2606    16513    sys_users sys_users_un 
   CONSTRAINT     [   ALTER TABLE ONLY public.sys_users
    ADD CONSTRAINT sys_users_un UNIQUE (uuid, username);
 @   ALTER TABLE ONLY public.sys_users DROP CONSTRAINT sys_users_un;
       public            db    false    211    211            )           1259    16412    unique_index    INDEX     e   CREATE UNIQUE INDEX unique_index ON public.casbin_rule USING btree (p_type, v0, v1, v2, v3, v4, v5);
     DROP INDEX public.unique_index;
       public            db    false    201    201    201    201    201    201    201           