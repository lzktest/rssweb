package sevice

import (
	"server/global"
)

//@author: [piexlmax]
//@function: CreateApi
//@description: 新增基础api
//param: api model.SysApi
//return: err error
func CreateApi(api model.SysApi) (err error){
	var apitmp model.SysApi
	global.GVA_DB.Exec("insert into casbin_rule value")
}