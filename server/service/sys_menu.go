package sevice

import (
	"errors"
	"server/global"
	"server/model"
)

// @author: [piexlmax]
// @function: AddBaseMenu
// @description: menu model.SysBaseMenu
// @param: menu model.SysBaseMenu
// @return: err error
func AddBaseMenu(menu model.SysBaseMenu)(err error){
	err = global.GVA_DB.QueryRow("select name from sys_base_menus where name=?;",menu.Name).Scan(&model.SysBaseMenu.Name)
	if err != nil {
		err = global.GVA_DB.Exec("insert into sys_base_menus (created_at,update_at,menu_level,parent_id,path,name,hidden,component,sort,keep_alive,default_menu,title,icon) values($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13);",menu.CreatedAt,menu.UpdatedAt,menu.MenuLevel,menu.ParentId,menu.Path,menu.Name,menu.Hidden,menu.Component,menu.Sort,menu.KeepAlive,menu.DefaultMenu,menu.Title,menu.icon)
		if err != nil {
			return err
		}
	} else {
		return errors.New("存在相同name")
	}
}