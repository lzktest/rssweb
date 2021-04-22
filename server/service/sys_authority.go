package sevice

import (
	"database/sql"
	"errors"
	"server/global"
	"server/model"
	"server/model/request"
	"server/model/response"
	"time"

	"go.uber.org/zap"
	//"server/utils"
)

// @author: [piexlmax]
// @function: CreateAuthority
// @description: 创建一个角色
// @return: err error, authority model.SysAuthority
func CreateAuthority(auth model.SysAuthority) (err error, authority model.SysAuthority) {
	var authorityBox model.SysAuthority
	if err := global.GVA_DB.QueryRow("select * from sys_authorities where authority_id = $1 limit 1;", auth.AuthorityId).Scan(&authorityBox.CreatedAt, &authorityBox.UpdatedAt, &authorityBox.DeletedAt, &authorityBox.AuthorityId, &authorityBox.AuthorityName, &authorityBox.ParentId); errors.Is(err, sql.ErrNoRows) {
		_, err := global.GVA_DB.Exec("insert into sys_authorities (Created_at,Updated_At,Deleted_At,Authority_Id,Authority_Name,Parent_Id) values($1,$2,$3,$4,$5,$6)", time.Now(), time.Now(), auth.DeletedAt, auth.AuthorityId, auth.AuthorityName, auth.ParentId)
		return err, auth
	} else {
		return errors.New("存在相同角色id"), auth
	}
}

//@author: [piexlmax]
//@function: SetDataAuthority
//@description: 设置角色资源权限
//@param: auth model.SysAuthority
//@return: error
func SetMenuAuthority(auth *model.SysAuthority) error {
	tx, err := global.GVA_DB.Begin()
	if err != nil {
		return err
	}
	_, err = tx.Exec("delete from sys_authority_menus where sys_authority_authority_id=$1 ;", auth.AuthorityId)
	if err != nil {
		tx.Rollback()
		return err
	}
	//global.GVA_LOG.Info("info", zap.Any("aaaaa", auth))
	for _, value := range auth.SysBaseMenus {
		//global.GVA_LOG.Info("info",zap.Any("aaaaa",value))
		_, err = tx.Exec("insert into sys_authority_menus (sys_authority_authority_id,sys_base_menu_id) values($1,$2);", auth.AuthorityId, value.ID)
		if err != nil {
			tx.Rollback()
			return err
		}
	}
	err = tx.Commit()
	return err
}

// @author: [piexlmax]
// @function: CopyAuthority
// @description: 复制一个角色
// @param: copyInfo response.SysAuthorityCopyResponse
// @return: err error, authority model.SysAuthority
func CopyAuthority(copyInfo response.SysAuthorityCopyResponse) (err error, authority model.SysAuthority) {
	var authorityBox model.SysAuthority
	err = global.GVA_DB.QueryRow("select * from sys_authorities where authority_id= $1 limit 1;", copyInfo.OldAuthorityId).Scan(&authorityBox.CreatedAt, &authorityBox.UpdatedAt, &authorityBox.DeletedAt, &authorityBox.AuthorityId, &authorityBox.AuthorityName, &authorityBox.ParentId)
	if err == nil {
		_, err := global.GVA_DB.Exec("insert into sys_authorities (Created_at,Updated_At,Deleted_At,Authority_Id,Authority_Name,Parent_Id) values($1,$2,$3,$4,$5,$6)")
		return err, authority
	} else {
		return errors.New("存在相同角色id"), copyInfo.Authority
	}
}

// @author: [piexlmax]
// @function: GetAuthorityInfoList
// @description: 分页获取角色列表
// @param: auth model.SysAuthority
// @return: err error, sa model.SysAuthority
func GetAuthorityInfoList(info request.PageInfo) (err error, list interface{}, total int64) {
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	var authority []model.SysAuthority
	var authtmp model.SysAuthority
	rows, err := global.GVA_DB.Query("select * from sys_authorities where parent_id='0' limit $1 offset $2", limit, offset)
	if err != nil {
		return errors.New("获取失败，请稍后重试"), list, total
	}
	for rows.Next() {
		err = rows.Scan(&authtmp.CreatedAt, &authtmp.UpdatedAt, &authtmp.DeletedAt, &authtmp.AuthorityId, &authtmp.AuthorityName, &authtmp.ParentId, &authtmp.DefaultRouter)
		if err != nil {
			return err, authority, total
		}
		authority = append(authority, authtmp)
	}
	if len(authority) > 0 {
		for k := range authority {
			err = findChildrenAuthority(&authority[k])
		}
	}
	return err, authority, total
}

// @author: [piexlmax]
// @function: UpdateAuthority
// @description: 更改一个角色
// @param: auth model.SysAuthority
// @return: err error, authority model.SysAuthority
func UpdateAuthority(auth model.SysAuthority) (err error, authority model.SysAuthority) {
	if _, err := global.GVA_DB.Exec("update sys_authorities set updated_at=$1,authority_name=$2,parent_id=$3 where authority_id = $4", time.Now(), auth.AuthorityName, auth.ParentId, auth.AuthorityId); err != nil {
		return err, auth
	} else {
		return nil, auth
	}
}

// @author: [piexlmax]
// @function: findChildrenAuthority
// @description: 查询子角色
// @param: authority *model.SysAuthority
// @return: err error
func findChildrenAuthority(authority *model.SysAuthority) (err error) {
	var authtmp model.SysAuthority
	rows, err := global.GVA_DB.Query("select * from sys_authorities where parent_id =$1 ;", authority.AuthorityId)
	if err != nil {
		return err
	}
	for rows.Next() {
		err = rows.Scan(&authtmp.CreatedAt, &authtmp.UpdatedAt, &authtmp.DeletedAt, &authtmp.AuthorityId, &authtmp.AuthorityName, &authtmp.ParentId, &authtmp.DefaultRouter)
		if err != nil {
			global.GVA_LOG.Error("testssss", zap.Any("error", err))
			return err
		}
		authority.Children = append(authority.Children, authtmp)
	}
	if len(authority.Children) > 0 {
		for k := range authority.Children {
			err = findChildrenAuthority(&authority.Children[k])
		}
	}
	return nil
}

// @author: [piexlmax]
// @function: DeleteAuthority
// @description: 删除角色
// @param: auth *model.SysAuthority
// @return: err error
func DeleteAuthority(auth *model.SysAuthority) (err error) {
	var authtmp model.SysAuthority
	if err := global.GVA_DB.QueryRow("select sys_authority_authority_id from sys_authority_menus where sys_authority_authority_id=$1;", auth.AuthorityId).Scan(&authtmp.AuthorityId); errors.Is(err, sql.ErrNoRows) {
		_, err := global.GVA_DB.Exec("delete from sys_authorities where authority_id=$1;", auth.AuthorityId)
		return err
	} else {
		return errors.New("删除前请清空角色权限")
	}
}

// @author: [piexlmax]
// @function: SetMenuAuthority
// @description: 菜单与角色绑定
// @param: auth *model.SysAuthority
// @return: error
//func SetMenuAuthority(auth *model.SysAuthority) error {
//	var s model.SysAuthority
//	global.GVA_DB.Query("select * from Sys_BaseMenus")
//}
