package sevice

import (
	"database/sql"
	"errors"
	uuid "github.com/satori/go.uuid"
	"server/global"
	"server/model"
	"server/model/request"
	"server/utils"
	"time"
)

// @author: [pexlmax]
// @function: Register
// @description: 用户注册
// @param: u model.SysUser
// @return: err error, userInfer model.SysUser
func Register(u model.SysUser)(err error, userInter model.SysUser){
	var user model.SysUser
	err = global.GVA_DB.QueryRow("select username from sys_users where username=$1", u.Username).Scan(&user.Username)
	if !errors.Is(err, sql.ErrNoRows){
		return errors.New("用户已注册"), userInter
	}
	u.Password = utils.MD5V([]byte(u.Password))
	u.UUID = uuid.NewV4()
	_, err = global.GVA_DB.Exec("insert into sys_users(createed_at,updateed_at,uuid,username,password,nick_name,header_img,authority_id) values($1,$2,$3,$4,$5,$6,$7,$8);",time.Now(),time.Now(),u.UUID,u.Username,u.Password,u.NickName,u.HeaderImg,u.AuthorityId)
	return err, u
}

// @author: [piexlmax]
// @function: Login
// @description: 用户登录
// @param: u *model.SysUser
// @return: err error, userInter *model.SysUser
func Login(u *model.SysUser) (err error, userInter *model.SysUser){
	var user model.SysUser
	var authmodel model.SysAuthority
	u.Password = utils.MD5V([]byte(u.Password))
	err = global.GVA_DB.QueryRow("select * from sys_users su join sys_authorities sam on su.authority_id = sam.authority_id where su.username=$1 and su.password = $2;",u.Username,u.Password).Scan(
		&user.ID,&user.CreatedAt,&user.UpdatedAt,&user.DeletedAt,&user.UUID,&user.Username,&user.Password,&user.NickName,&user.HeaderImg,&user.AuthorityId,
		&authmodel.CreatedAt,&authmodel.UpdatedAt,&authmodel.DeletedAt,&authmodel.AuthorityId,&authmodel.AuthorityName,&authmodel.ParentId,&authmodel.DefaultRouter)
	//user.Children=append(user.Children,authmodel)
	user.Authority=authmodel
	return err, &user
}

//@author: [piexlmax](https://github.com/piexlmax)
//@function: GetUserInfoList
//@description: 分页获取数据
//@param: info request.PageInfo
//@return: err error, list interface{}, total int64
func GetUserInfoList(info request.PageInfo)(err error,list interface{}, total int64){
	var userList []model.SysUser
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	rows, err := global.GVA_DB.Query("select id,createed_at,updateed_at,deleteed_at,uuid,username,nick_name,header_img,authority_id from sys_users limit $1 offset $2;",limit,offset)
	if err != nil {
		return err, userList,total
	}
	for rows.Next(){
		var ur model.SysUser
		err = rows.Scan(&ur.ID,&ur.CreatedAt,&ur.UpdatedAt,&ur.DeletedAt,&ur.UUID,&ur.Username,&ur.NickName,&ur.HeaderImg,&ur.AuthorityId)
		if err != nil {
			return err, userList, total
		}
		userList = append(userList, ur)
		total++
	}
	return err, userList, total
}


// @author: [piexlmax]
// @function: ChangePassword
// @description: 修改用户密码
// @param: u *model.SysUser, newPassword string
// @return: err error, userInter *model.SysUser
func ChangePassword(u *model.SysUser, newPassword string)(err error, userInter *model.SysUser){
	//var user model.SysUser
	u.Password = utils.MD5V([]byte(u.Password))
	u.UpdatedAt = time.Now()
	var user model.SysUser
	err = global.GVA_DB.QueryRow("select username from sys_users where username=$1 and password = $2;",u.Username,u.Password).Scan(&user.Username)
	if errors.Is(err, sql.ErrNoRows){
		return err, userInter
	}
	_,err = global.GVA_DB.Exec("update sys_users set updateed_at=$1,password=$2 where username=$3 and password = $4;",u.UpdatedAt,utils.MD5V([]byte(newPassword)),u.Username,u.Password)
	return err, u
}

// @author: [piexlmax]
// @function: SetUserAuthority
// @description: 设置一个用户的权限
// @param: uuid uuid.UUID, authorityId string
// @return: err error
func SetUserAuthority(uuid uuid.UUID, authorityId string)(err error){
	_, err = global.GVA_DB.Exec("update sys_users set updateed_at=$1,authority_id=$2 where uuid=$3;",time.Now(),authorityId,uuid)
	return err
}
// @author: [piexlmax]
// @function: SetUserInfo
// @description: 设置用户信息
// @param: reqUser model.SysUser
// @return: err error, user model.SysUser
func SetUserInfo(reqUser model.SysUser)(err error, user model.SysUser){
	reqUser.UpdatedAt=time.Now()
	_,err = global.GVA_DB.Exec("update sys_users set updateed_at=$1,username=$2,nick_name=$3,header_img=$4 where id=$5",reqUser.UpdatedAt,reqUser.Username,reqUser.NickName,reqUser.HeaderImg,reqUser.ID)
	return  err,reqUser
}
func FindUserById(id int)(err error, user *model.SysUser){
	var u model.SysUser
	err = global.GVA_DB.QueryRow("select * from sys_users where id = $1 limit 1;",id).Scan(&u.ID,&u.CreatedAt,&u.UpdatedAt,&u.DeletedAt,&u.UUID,&u.Username,&u.Password,&u.NickName,&u.HeaderImg,&u.AuthorityId)
	return err, &u
}

// @author: [piexlamx]
// @function: FindUserByUuid
// @description: 通过uuid获取用户信息
// @param: uuid string
// @return: err error, user *model.SysUser
func FindUserByUuid(uuid string)(err error, user *model.SysUser){
	var u model.SysUser
	err = global.GVA_DB.QueryRow("select * from sys_users where uuid = $1 limit 1;",uuid).Scan(&u.ID,&u.CreatedAt,&u.UpdatedAt,&u.DeletedAt,&u.UUID,&u.Username,&u.Username,&u.NickName,&u.HeaderImg,&u.AuthorityId)
	return err, &u
}

//@author: [piexlmax](https://github.com/piexlmax)
//@function: DeleteUser
//@description: 删除用户
//@param: id float64
//@return: err error
func DeleteUser(id float64)(err error){
	_, err = global.GVA_DB.Exec("delete from sys_users where id= $1",id)
	return err
}