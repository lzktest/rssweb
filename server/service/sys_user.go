package sevice

import (
	"database/sql"
	"errors"
	"server/global"
	"server/utils"
	"server/model"
)

// @author: [pexlmax]
// @function: Register
// @description: 用户注册
// @param: u model.SysUser
// @return: err error, userInfer model.SysUser
func Register(u model.SysUser)(err error, userInter model.SysUser){
	var user model.SysUser
	_, err = global.GVA_DB.QueryRow("select username from sys_user where username=$1", u.Username).Scan(&user.Username)
	if !errors.Is(err, sql.ErrNoRows){
		return errors.New("用户已注册"), userInter
	}
	u.Password = utils.MD5V([]byte(u.Password))
	u.UUID = uuid.NewV4()
	_, err = global.GVA_DB.Exec("insert into sys_user(id, createed_at,updateed_at,uuid,username,password,nick_name,hard_img,authority_id values($1,$2,$3,$4,$5,$6,$7,$8,$9);",u.ID,u.CreateedAt,u.UpdateedAt,u.UUID,u.Username,u.Password,u.NickName,u.HardImg,u.AuthorityId)
	return err, u
}

// @author: [piexlmax]
// @function: Login
// @description: 用户登录
// @param: u *model.SysUser
// @return: err error, userInter *model.SysUser
func Login(u *model.SysUser) (err error, userInter *model.SysUser){
	var user model.SysUser
	u.Password = utils.MD5V([]byte(u.Password))
	
}