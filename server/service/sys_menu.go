package sevice

import (
	"database/sql"
	"errors"
	"go.uber.org/zap"
	"strconv"

	//"github.com/google/uuid"
	"server/global"
	"server/model"
	"server/model/request"
	"time"
)

// @author: [piexlmax]
// @function: AddBaseMenu
// @description: menu model.SysBaseMenu
// @param: menu model.SysBaseMenu
// @return: err error
func AddBaseMenu(menu model.SysBaseMenu)(err error){
	var menutmp model.SysBaseMenu
	//global.GVA_LOG.Error("添加数据", zap.Any("err", menu))
	err = global.GVA_DB.QueryRow("select routername from sys_base_menus where routername=$1;", menu.Name).Scan(&menutmp.Name)
	if errors.Is(err, sql.ErrNoRows) {
		transaction, err :=global.GVA_DB.Begin()
		if err != nil {
			return err
		}
		//global.GVA_LOG.Error("添加数据", zap.Any("err", menu))
		var id int64
		err = global.GVA_DB.QueryRow("insert into sys_base_menus (createed_at,updateed_at,menu_level,parent_id,routerpath,routername,hidden,component,sort,keep_alive,default_menu,title,icon) values($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13) returning sys_base_menu_id;", time.Now(), time.Now(), menu.MenuLevel, menu.ParentId, menu.Path, menu.Name, menu.Hidden, menu.Component, menu.Sort, menu.KeepAlive, menu.DefaultMenu, menu.Title, menu.Icon).Scan(&id)
		//global.GVA_LOG.Error("添加数据", zap.Any("err", id))
		if err != nil {
			transaction.Rollback()
			return err
		}

		if len(menu.Parameters) > 0 {
			for _ , value := range menu.Parameters{
				//global.GVA_LOG.Error("添加参数数据", zap.Any("err", id))
				_, err = transaction.Exec("insert into sys_base_menu_parameters (createed_at,updateed_at,sys_base_menu_id,addtype,addkey,addvalue) values($1,$2,$3,$4,$5,$6);",time.Now(),time.Now(),id,value.Type,value.Key,value.Value)
				if err != nil {
					transaction.Rollback()
					return err
				}
			}
		}
		if err = transaction.Commit(); err != nil {
			return err
		}
		return nil
	}
	return errors.New("存在相同name")
}

//@author: [piexlmax]
//@function: AddMenuAuthority
//@description: 为角色增加menu树
//@param:menus []model.SysBaseMenu, authorityId string
//@return: err error
func AddMenuAuthority(menus []model.SysBaseMenu, authorityId string)(err error){
	var auth model.SysAuthority
	auth.AuthorityId = authorityId
	auth.SysBaseMenus = menus
	//global.GVA_LOG.Info("info",zap.Any("aaaaa",auth))
	err =SetMenuAuthority(&auth)
    return err
}

// @author: [piexlmax]
// @function: getBaseMenuTreeMap
// @description: 获取路由总树map
// @return: err error, treeMap map[string][]model.SysBaseMenu
func getBaseMenuTreeMap(qsstr string)(err error, treeMap map[string][]model.SysBaseMenu){
	//var allMenus []model.SysBaseMenu
	treeMap = make(map[string][]model.SysBaseMenu)
	var qstr string
	i := 0
	//rows,err := global.GVA_DB.Query("select * from sys_base_menus sbm inner join sys_base_menu_parameters sbmp on sbm.sys_base_menu_id = sbmp.sys_base_menu_id order by sbm.sort;")
	rows,err := global.GVA_DB.Query(qsstr)
	if err != nil {
		global.GVA_LOG.Error("获取路由总树失败:",zap.Any("err",err))
		return err,treeMap
	}
	for rows.Next(){
		var menutmp model.SysBaseMenu
		//var allmenutmp []model.SysBaseMenu
		//err = rows.Scan(&menutmp.ID,&menutmp.CreateedAt,&menutmp.UpdateedAt,&menutmp.DeteteedAt,&menutmp.MenuLevel,&menutmp.ParentId,&menutmp.Path,&menutmp.Name,&menutmp.Hidden,&menutmp.Component,&menutmp.Sort,&menutmp.Meta.KeepAlive,&menutmp.Meta.DefaultMenu,&menutmp.Meta.Title,&menutmp.Parameters[0].ID,&menutmp.Parameters[0].CreateedAt,&menutmp.Parameters[0].UpdateedAt,&menutmp.Parameters[0].DeteteedAt,&menutmp.Parameters[0].SysBaseMenuID,&menutmp.Parameters[0].Type,&menutmp.Parameters[0].Key,&menutmp.Parameters[0].Value)
		err = rows.Scan(&menutmp.ID,&menutmp.CreatedAt,&menutmp.UpdatedAt,&menutmp.DeletedAt,&menutmp.MenuLevel,&menutmp.ParentId,&menutmp.Path,&menutmp.Name,&menutmp.Hidden,&menutmp.Component,&menutmp.Sort,&menutmp.Meta.KeepAlive,&menutmp.Meta.DefaultMenu,&menutmp.Meta.Title,&menutmp.Meta.Icon)
		if err == nil {
			//allmenutmp = append(allmenutmp,menutmp)
			if i !=0 {
				qstr += ","
			}
			i++
			qstr += strconv.Itoa(int(menutmp.ID))
			treeMap[menutmp.ParentId] = append(treeMap[menutmp.ParentId],menutmp)
		} else {
			return err,treeMap
		}
	}

	rows, err = global.GVA_DB.Query("select * from sys_base_menu_parameters where sys_base_menu_id in ("+qstr+");")
	if err != nil {
		global.GVA_LOG.Error("获取路由子树失败:",zap.Any("err",err))
		return err,treeMap
	}
	for rows.Next(){
		var menutmp model.SysBaseMenuParameter
		err = rows.Scan(&menutmp.ID,&menutmp.CreatedAt,&menutmp.UpdatedAt,&menutmp.DeletedAt,&menutmp.SysBaseMenuID,&menutmp.Type,&menutmp.Key,&menutmp.Value)
		if err == nil {
			for key, value := range treeMap{
				for keyc,valuec :=range value {
					if valuec.ID == menutmp.SysBaseMenuID{
						treeMap[key][keyc].Parameters = append(treeMap[key][keyc].Parameters,menutmp)
					}
				}
			}
		} else {
			return err, treeMap
		}
	}
	return nil, treeMap
}

//@author: [piexlmax](https://github.com/piexlmax)
//@function: GetBaseMenuTree
//@description: 获取基础路由树
//@return: err error, menus []model.SysBaseMenu

func GetBaseMenuTree() (err error, menus []model.SysBaseMenu) {
	err, treeMap := getBaseMenuTreeMap("select * from sys_base_menus order by sort;")
	menus = treeMap["0"]
	for i := 0; i < len(menus); i++ {
		err = getBaseChildrenList(&menus[i], treeMap)
	}
	return err, menus
}

//@author: [piexlmax](https://github.com/piexlmax)
//@function: getBaseChildrenList
//@description: 获取菜单的子菜单
//@param: menu *model.SysBaseMenu, treeMap map[string][]model.SysBaseMenu
//@return: err error
func getBaseChildrenList(menu *model.SysBaseMenu, treeMap map[string][]model.SysBaseMenu) (err error) {
	menu.Children = treeMap[strconv.Itoa(int(menu.ID))]
	for i := 0; i < len(menu.Children); i++ {
		err = getBaseChildrenList(&menu.Children[i], treeMap)
	}
	return err
}
//@author: [piexlmax]
//@function: GetInfoList
//@description: 获取路由分页
//@return: err error, list interface{}， total int64

func GetInfoList(pageInfo request.PageInfo) (err error, list interface{}, total int64){
	var menuList []model.SysBaseMenu
	err, treeMap := getBaseMenuTreeMap("select * from sys_base_menus order by sort limit "+strconv.Itoa(int(pageInfo.PageSize))+" offset "+strconv.Itoa(int((pageInfo.Page-1)*pageInfo.PageSize))+" ;")
	menuList = treeMap["0"]
	for i := 0; i< len(menuList); i++ {
		err = getBaseChildrenList(&menuList[i], treeMap)
	}
	return err, menuList, total
}

//@author: [piexlmax](https://github.com/piexlmax)
//@function: GetBaseMenuById
//@description: 返回当前选中menu
//@param: id float64
//@return: err error, menu model.SysBaseMenu

func GetBaseMenuById(id float64)(err error,menus []model.SysBaseMenu){
	var menuList []model.SysBaseMenu
	err, treeMap := getBaseMenuTreeMap("select * from sys_base_menus where sys_base_menu_id = "+strconv.FormatFloat(id,'f',-1,64)+" limit 1;")
	global.GVA_LOG.Error("根据id返回menu",zap.Any("info",strconv.FormatFloat(id,'f',-1,64)))
	global.GVA_LOG.Error("根据id返回menu",zap.Any("info",treeMap))
	for _, v := range treeMap{
		menuList = v
	}
	for i := 0; i< len(menuList); i++ {
		err = getBaseChildrenList(&menuList[i], treeMap)
	}
	return err, menuList
}

//@author: [piexlmax]
//@function: GetMenuAuthority
//@description: 查看当前角色树
//@param: info *request.GetAuthorityId
//@return: err error, menus []model.SysMenu

func GetMenuAuthority(info *request.GetAuthorityId) (err error, menus []model.SysMenu) {
	var qstr string
	i := 0
	//err, treeMap := getBaseMenuTreeMap("select sbm.sys_base_menu_id, sbm.createed_at, sbm.updateed_at, sbm.deleteed_at, \nsbm.menu_level, sbm.parent_id, sbm.routerpath, sbm.routername, sbm.hidden, sbm.component, sbm.sort, sbm.keep_alive, sbm.default_menu, sbm.title, sbm.icon \nfrom sys_authority_menus sam \ninner join sys_base_menus sbm \non sam.sys_base_menu_id = sbm.sys_base_menu_id where sam.sys_authority_authority_id='"+info.AuthorityId+"';")
	global.GVA_LOG.Debug("输出authorityid:",zap.Any("debug",info.AuthorityId))
	rows, err := global.GVA_DB.Query("select * from sys_authority_menus sam \ninner join sys_base_menus sbm \non sam.sys_base_menu_id = sbm.sys_base_menu_id where sam.sys_authority_authority_id='"+info.AuthorityId+"' order by sbm.sort;")
	if err != nil || err == errors.New("sql: no rows in result set") {
		return err ,menus
	}
	for rows.Next(){
		var menuline model.SysMenu
		err = rows.Scan(&menuline.AuthorityId,&menuline.MenuId,&menuline.ID,&menuline.CreatedAt,&menuline.UpdatedAt,&menuline.DeletedAt,&menuline.MenuLevel,&menuline.ParentId,&menuline.Path,&menuline.Name,&menuline.Hidden,&menuline.Component,&menuline.Sort,&menuline.Meta.KeepAlive,&menuline.Meta.DefaultMenu,&menuline.Meta.Title,&menuline.Meta.Icon)
		if err != nil {
			return nil, menus
		}
		if i !=0 {
			qstr += ","
		}
		i++
		qstr += strconv.Itoa(int(menuline.ID))
		menus = append(menus,menuline)
	}
	if len(qstr)<1 {
		return nil ,menus
	}
	global.GVA_LOG.Debug("输出GetMenuAuthority sql:",zap.Any("info",qstr))
	rows, err = global.GVA_DB.Query("select * from sys_base_menu_parameters where sys_base_menu_id in ("+qstr+");")
	if err != nil {
		global.GVA_LOG.Error("获取路由参数失败:",zap.Any("err",err))
		return err,menus
	}
	for rows.Next(){
		var menutmp model.SysBaseMenuParameter
		err = rows.Scan(&menutmp.ID,&menutmp.CreatedAt,&menutmp.UpdatedAt,&menutmp.DeletedAt,&menutmp.SysBaseMenuID,&menutmp.Type,&menutmp.Key,&menutmp.Value)
		if err == nil {
			for key, value := range menus{
				if value.ID == menutmp.SysBaseMenuID{
					menus[key].Parameters = append(menus[key].Parameters,menutmp)
				}
			}
		} else {
			return err, menus
		}
	}
	return err, menus
}

//@author: [piexlmax](https://github.com/piexlmax)
//@function: getMenuTreeMap
//@description: 获取路由总树map
//@param: authorityId string
//@return: err error, treeMap map[string][]model.SysMenu

func getMenuTreeMap(querstr string) (err error, treeMap map[string][]model.SysMenu) {
	treeMap = make(map[string][]model.SysMenu)
	var qstr string
	i := 0
	rows,err := global.GVA_DB.Query(querstr)
	if err != nil {
		global.GVA_LOG.Error("获取路由总树失败:",zap.Any("err",err))
		return err,treeMap
	}
	for rows.Next(){
		var menutmp model.SysMenu
		//var allmenutmp []model.SysBaseMenu
		//err = rows.Scan(&menutmp.ID,&menutmp.CreateedAt,&menutmp.UpdateedAt,&menutmp.DeteteedAt,&menutmp.MenuLevel,&menutmp.ParentId,&menutmp.Path,&menutmp.Name,&menutmp.Hidden,&menutmp.Component,&menutmp.Sort,&menutmp.Meta.KeepAlive,&menutmp.Meta.DefaultMenu,&menutmp.Meta.Title,&menutmp.Parameters[0].ID,&menutmp.Parameters[0].CreateedAt,&menutmp.Parameters[0].UpdateedAt,&menutmp.Parameters[0].DeteteedAt,&menutmp.Parameters[0].SysBaseMenuID,&menutmp.Parameters[0].Type,&menutmp.Parameters[0].Key,&menutmp.Parameters[0].Value)
		err = rows.Scan(&menutmp.AuthorityId,&menutmp.MenuId,&menutmp.ID,&menutmp.CreatedAt,&menutmp.UpdatedAt,&menutmp.DeletedAt,&menutmp.MenuLevel,&menutmp.ParentId,&menutmp.Path,&menutmp.Name,&menutmp.Hidden,&menutmp.Component,&menutmp.Sort,&menutmp.Meta.KeepAlive,&menutmp.Meta.DefaultMenu,&menutmp.Meta.Title,&menutmp.Meta.Icon)
		if err == nil {
			if i !=0 {
				qstr += ","
			}
			i++
			qstr += strconv.Itoa(int(menutmp.ID))
			treeMap[menutmp.ParentId] = append(treeMap[menutmp.ParentId],menutmp)
		} else {
			return err,treeMap
		}
	}
	rows, err = global.GVA_DB.Query("select * from sys_base_menu_parameters where sys_base_menu_id in ("+qstr+");")
	if err != nil {
		global.GVA_LOG.Error("获取路由子树失败:",zap.Any("err",err))
		return err,treeMap
	}
	for rows.Next(){
		var menutmp model.SysBaseMenuParameter
		err = rows.Scan(&menutmp.ID,&menutmp.CreatedAt,&menutmp.UpdatedAt,&menutmp.DeletedAt,&menutmp.SysBaseMenuID,&menutmp.Type,&menutmp.Key,&menutmp.Value)
		if err == nil {
			for key, value := range treeMap{
				for keyc,valuec :=range value {
					if valuec.ID == menutmp.SysBaseMenuID{
						treeMap[key][keyc].Parameters = append(treeMap[key][keyc].Parameters,menutmp)
					}
				}
			}
		} else {
			return err, treeMap
		}
	}
	return nil, treeMap
}

//@author: [piexlmax](https://github.com/piexlmax)
//@function: GetMenuTree
//@description: 获取动态菜单树
//@param: authorityId string
//@return: err error, menus []model.SysMenu

func GetMenuTree(authorityId string) (err error, menus []model.SysMenu) {
	err, menuTree := getMenuTreeMap("select * from sys_authority_menus sam \ninner join sys_base_menus sbm \non sam.sys_base_menu_id = sbm.sys_base_menu_id where sam.sys_authority_authority_id='"+authorityId+"' order by sbm.sort;")
	if err != nil {
		return err, menus
	}
	menus = menuTree["0"]
	for i := 0; i < len(menus); i++ {
		err = getChildrenList(&menus[i], menuTree)
	}
	return err, menus
}

//@author: [piexlmax](https://github.com/piexlmax)
//@function: getChildrenList
//@description: 获取子菜单
//@param: menu *model.SysMenu, treeMap map[string][]model.SysMenu
//@return: err error

func getChildrenList(menu *model.SysMenu, treeMap map[string][]model.SysMenu) (err error) {
	menu.Children = treeMap[menu.MenuId]
	for i := 0; i < len(menu.Children); i++ {
		err = getChildrenList(&menu.Children[i], treeMap)
	}
	return err
}

//@author: [piexlmax]
//@function: UpdateBaseMenu
//@description: 更新路由
//@param: menu model.SysBaseMenu
//@return: err error
func UpdateBaseMenu(menu model.SysBaseMenu) (err error) {
	//var oldMenu model.SysBaseMenu
	tx,_:= global.GVA_DB.Begin()
	_, err =tx.Exec("update sys_base_menus set updateed_at=$1,menu_level=$2,parent_id=$3,routerpath=$4,routername=$5,hidden=$6,component=$7,sort=$8,keep_alive=$9,default_menu=$10,title=$11,icon=$12 where sys_base_menu_id=$13 ;",
		menu.UpdatedAt,menu.MenuLevel,menu.ParentId,menu.Path,menu.Name,menu.Hidden,menu.Component,menu.Sort,menu.Meta.KeepAlive,menu.Meta.DefaultMenu,menu.Meta.Title,menu.Meta.Icon,menu.ID)
	if err != nil {
		txerr :=tx.Rollback()
		if txerr != nil {
			global.GVA_LOG.Error("更新sys_base_menus失败,且回滚出现问题:",zap.Any("err",txerr))
		}
		global.GVA_LOG.Error("更新sys_base_menus失败:",zap.Any("err",err))
		return err
	}
	if len(menu.Parameters) >0 {
		_,err = tx.Exec("delete from sys_base_menu_parameters where sys_base_menu_id=$1;",menu.ID)
		if err != nil {
			txerr :=tx.Rollback()
			if txerr != nil {
				global.GVA_LOG.Error("更新sys_base_menu_parameters失败delete失败,且回滚出现问题:",zap.Any("err",txerr))
			}
			global.GVA_LOG.Error("更新sys_base_menu_parameters失败:",zap.Any("err",err))
			return err
		} else {
			for _,value := range menu.Parameters {
				_,err =tx.Exec("insert into sys_base_menu_parameters(createed_at,updateed_at,sys_base_menu_id,addtype,addkey,addvalue) values($1,$2,$3,$4,$5,$6);",menu.CreatedAt,time.Now(),menu.ID,value.Type,value.Key,value.Value)
				if err != nil {
					txerr :=tx.Rollback()
					if txerr != nil {
						global.GVA_LOG.Error("更新sys_base_menu_parameters失败insert失败,且回滚出现问题:",zap.Any("err",txerr))
					}
					global.GVA_LOG.Error("更新sys_base_menus失败:",zap.Any("err",err))
					return err
				}
			}
		}
	}
	err =tx.Commit()
	return err
}
