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
	err = global.GVA_DB.QueryRow("select name from sys_base_menus where name=$1;",menu.Name).Scan(&menutmp.Name)
	if errors.Is(err, sql.ErrNoRows) {
		_, err = global.GVA_DB.Exec("insert into sys_base_menus (created_at,updated_at,menu_level,parent_id,routerpath,routername,hidden,component,sort,keep_alive,default_menu,title,icon) values($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13);",time.Now(),time.Now(),menu.MenuLevel,menu.ParentId,menu.Path,menu.Name,menu.Hidden,menu.Component,menu.Sort,menu.KeepAlive,menu.DefaultMenu,menu.Title,menu.Icon)
		if err != nil {
			return err
		} else {
			return nil
		}
	}
	return errors.New("存在相同name")
}