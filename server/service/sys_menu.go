package sevice

import (
	"database/sql"
	"errors"
	//"github.com/google/uuid"
	"server/global"
	"server/model"
	"time"
)

// @author: [piexlmax]
// @function: AddBaseMenu
// @description: menu model.SysBaseMenu
// @param: menu model.SysBaseMenu
// @return: err error
func AddBaseMenu(menu model.SysBaseMenu)(err error){
	var menutmp model.SysBaseMenu
	err = global.GVA_DB.QueryRow("select routername from sys_base_menus where routername=$1;", menu.Name).Scan(&menutmp.Name)
	if errors.Is(err, sql.ErrNoRows) {
		transaction, err :=global.GVA_DB.Begin()
		if err != nil {
			return err
		}
		_, err = transaction.Exec("insert into sys_base_menus (created_at,updated_at,menu_level,parent_id,routerpath,routername,hidden,component,sort,keep_alive,default_menu,title,icon) values($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13);", time.Now(), time.Now(), menu.MenuLevel, menu.ParentId, menu.Path, menu.Name, menu.Hidden, menu.Component, menu.Sort, menu.KeepAlive, menu.DefaultMenu, menu.Title, menu.Icon)
		if err != nil {
			transaction.Rollback()
			return err
		}
		if len(menu.Parameters) > 0 {
			for _ , value := range menu.Parameters{
				_, err = transaction.Exec("insert into sys_base_menu_parameters (createed_at,updateed_at,sys_base_menu_id,addtype,addkey,addvalue) values($1,$2,$3,$4,$5,$6);",time.Now(),time.Now(),value.SysBaseMenuID,value.Type,value.Key,value.Value)
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

// @author: [piexlmax]
// @function: getBaseMenuTreeMap
// @description: 获取路由总树map
// @return: err error, treeMap map[string][]model.SysBaseMenu
func getBaseMenuTreeMap()(err error, treeMap map[string][]model.SysBaseMenu){
	var allMenus []model.SysBaseMenu
	treeMap = make(map[string][]model.SysBaseMenu)

	//rows,err := global.GVA_DB.Query("select * from sys_base_menus sbm inner join sys_base_menu_parameters sbmp on sbm.sys_base_menu_id = sbmp.sys_base_menu_id order by sbm.sort;")
	rows,err := global.GVA_DB.Query("select * from sys_base_menus;")
	if err != nil {
		global.VGA_LOG.Error("获取路由总树失败:",zap.Any("err",err))
		return err,treeMap
	}
	for rows.Next(){
		var menutmp model.SysBaseMenu
		//err = rows.Scan(&menutmp.ID,&menutmp.CreateedAt,&menutmp.UpdateedAt,&menutmp.DeteteedAt,&menutmp.MenuLevel,&menutmp.ParentId,&menutmp.Path,&menutmp.Name,&menutmp.Hidden,&menutmp.Component,&menutmp.Sort,&menutmp.Meta.KeepAlive,&menutmp.Meta.DefaultMenu,&menutmp.Meta.Title,&menutmp.Parameters[0].ID,&menutmp.Parameters[0].CreateedAt,&menutmp.Parameters[0].UpdateedAt,&menutmp.Parameters[0].DeteteedAt,&menutmp.Parameters[0].SysBaseMenuID,&menutmp.Parameters[0].Type,&menutmp.Parameters[0].Key,&menutmp.Parameters[0].Value)
		err = rows.Scan(&menutmp.ID,&menutmp.CreateedAt,&menutmp.UpdateedAt,&menutmp.DeteteedAt,&menutmp.MenuLevel,&menutmp.ParentId,&menutmp.Path,&menutmp.Name,&menutmp.Hidden,&menutmp.Component,&menutmp.Sort,&menutmp.Meta.KeepAlive,&menutmp.Meta.DefaultMenu,&menutmp.Meta.Title)
		if err == nil {
			allMenus = append(allMenus,menutmp)
			treeMap[menutmp.ParentId] = append(treeMap[menutmp.ParentId],menutmp)
		} else {
			return err,treeMap
		}
	}

}