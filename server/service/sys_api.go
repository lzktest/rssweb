package sevice

import (
	"database/sql"
	"errors"
	"server/global"
	"server/model"
	"time"

	"go.uber.org/zap"
)

//@author: [piexlmax]
//@function: CreateApi
//@description: 新增基础api
//param: api model.SysApi
//return: err error
func CreateApi(api model.SysApi) (err error){
	//global.GVA_LOG.Info("info",zap.Any("api",api))
	_,err = global.GVA_DB.Exec("INSERT INTO sys_apis (created_at,updated_at,paths,descriptions,apigroup,methods) VALUES($1,$2,$3,$4,$5,$6);",time.Now(),time.Now(),api.Path,api.Description,api.ApiGroup,api.Method)
	return  err
}

//@author: [piexlmax]
//@function: DeleteApi
//@description: 删除基础api
//@param: api model.SysApi
//@return: err error
func DeleteApi(api model.SysApi)(err error){
	if _,err = global.GVA_DB.Exec("delete from sys_apis where id=$1;",api.ID); errors.Is(err, errors.Is(err, sql.ErrNoRows)){

	}
	return  err
}