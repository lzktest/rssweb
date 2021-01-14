package sevice

import (
	"errors"
	"server/global"
	"server/model"
	"server/model/request"
	"server/model/response"
	"server/utils"
)

// @author: [piexlmax]
// @function: CreateAuthority
// @description: 创建一个角色
// @return: err error, authority model.SysAuthority
func CreateAuthority(auth model.SysAuthority)(err error, authority model.SysAuthority){
	var authorityBox model.SysAuthority
	if err :=global.GVA_DB.QueryRow("select * from sys_authorities where authority_id = $1 limit 1;",auth.AuthorityId).Scan(&authorityBox.CreatedAt, &authorityBox.UpdatedAt, &authorityBox.DeletedAt, &authorityBox.AuthorityId, &authorityBox.AuthorityName, &authorityBox.ParentId); err !=nil{
		_, err := global.GVA_DB.Exec("insert into sys_authorities (Created_at,Updated_At,Deleted_At,Authority_Id,Authority_Name,Parent_Id) values($1,$2,$3,$4,$5,$6)",auth.CreatedAt,auth.UpdatedAt,auth.DeletedAt,auth.AuthorityId,auth.AuthorityName,auth.ParentId)
		return err, auth
	} else {
		return errors.New("存在相同角色id"), auth
	}
}

// @author: [piexlmax]
// @function: CopyAuthority
// @description: 复制一个角色
// @param: copyInfo response.SysAuthorityCopyResponse
// @return: err error, authority model.SysAuthority
func CopyAuthority(copyInfo response.SysAuthorityCopyResponse)(err error, authority model.SysAuthority){
	var authorityBox model.SysAuthority
	_, err = global.GVA_DB.QueryRow("select * from sys_authorities where authority_id= $1 limit 1;",copyInfo.Authority.AuthorityId).Scan(&authorityBox.CreatedAt, &authorityBox.UpdatedAt, &authorityBox.DeletedAt, &authorityBox.AuthorityId, &authorityBox.AuthorityName, &authorityBox.ParentId)
	if err != nil {
		_, err := global.GVA_DB.Exec("insert into sys_authorities (Created_at,Updated_At,Deleted_At,Authority_Id,Authority_Name,Parent_Id) values($1,$2,$3,$4,$5,$6)")
		return err,authority
	}else {
		return errors.New("存在相同角色id"), copyInfo.Authority
	}
}

// @author: [piexlmax]
// @function: GetAuthorityInfoList
// @description: 分页获取角色列表
// @param: auth model.SysAuthority
// @return: err error, sa model.SysAuthority
func GetAuthorityInfoList(info request.PageInfo) (err error, list interface{}, total int64){
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	var authority []model.SysAuthority
	var authtmp model.SysAuthority
	rows, err :=  global.GVA_DB.Query("select * from sys_authorities where parent_id='0' limit $1 offset $2",  limit, offset)
	if err != nil {
		return errors.New("获取失败，请稍后重试"), list, total
	}
	for rows.Next(){
		err = rows.Scan(&authtmp.CreatedAt,&authtmp.UpdatedAt,&authtmp.DeletedAt,&authtmp.AuthorityId,&authtmp.AuthorityName,&authtmp.ParentId)
		if err != nil {
			return err, authority, total
		}
		authority = append(authority, authtmp)
	}
	if len(authority)>0 {
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
func UpdateAuthority(auth model.SysAuthority)(err error, authority model.SysAuthority){
	if _, err := global.GVA_DB.Exec("update sys_authorities set updated_at=$1,authority_name=$2,parent_id=$3 where authority_id = $4",auth.UpdatedAt,auth.AuthorityName,auth.ParentId,auth.AuthorityId);err != nil{
		return err, authority
	} else {
		return nil, authority
	}
}

// @author: [piexlmax]
// @function: findChildrenAuthority
// @description: 查询子角色
// @param: authority *model.SysAuthority
// @return: err error
func findChildrenAuthority(authority *model.SysAuthority)(err error){
	var authtmp model.SysAuthority
	rows, err := global.GVA_DB.Query("select * from sys_authorities where parent_id =$1 ;",authority.AuthorityId)
	if err != nil {
		return err
	}
	for rows.Next(){
		err = rows.Scan(&authtmp.CreatedAt,&authtmp.UpdatedAt,&authtmp.DeletedAt,&authtmp.AuthorityId,&authtmp.AuthorityName,&authtmp.ParentId)
		if err != nil {
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
