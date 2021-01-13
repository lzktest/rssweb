package sevice

import (
	"errors"
	"server/global"
	"server/model"
)

// @author: [piexlmax]
// @function: CreateAuthority
// @description: 创建一个角色
// @return: err error, authority model.SysAuthority
func CreateAuthority(auth model.SysAuthority)(err error, authority model.SysAuthority){
	var authorityBox model.SysAuthority
	if err :=global.GVA_DB.QueryRow("select * from sys_authority where authority_id = ? limit 1;",auth.AuthorityId).Scan(&authorityBox.CreatedAt, &authorityBox.UpdatedAt, &authorityBox.DeletedAt, &authorityBox.AuthorityId, &authorityBox.AuthorityName, &authorityBox.ParentId); err !=nil{
		_, err := global.GVA_DB.Exec("insert into sys_authority ('CreatedAt','UpdatedAt','DeletedAt','AuthorityId','AuthorityName','ParentId') values(?,?,?,?,?,?)",auth.CreatedAt,auth.UpdatedAt,auth.DeletedAt,auth.AuthorityId,auth.AuthorityName,auth.ParentId)
		return err, auth
	} else {
		return errors.New("存在相同api"), auth
	}
}
