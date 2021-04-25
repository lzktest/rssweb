package sevice

import (
	"database/sql"
	"errors"
	"server/global"
	"server/model"
	"server/model/request"
	"strconv"
	"time"

	//"go.uber.org/zap"
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
	if _,err = global.GVA_DB.Exec("delete from sys_apis where id=$1;",api.ID); errors.Is(err, sql.ErrNoRows){
		return err
	}
	return  err
}

//@author: [piexlmax]
//@function: GetApiPageList
//@description: 分页获取基础api列表
//@param: api request.SearchApiParams
//@return: err error
func GetAPIInfoList( api model.SysApi, info request.PageInfo, order string, desc bool)(err error, list interface{}, total int64){
	limit := info.PageSize
	offset := info.PageSize * (info.Page - 1)
	var apiList  []model.SysApi
	var sqlstr string
	var sqlpre []interface{}
	i := 1
	if api.Path != ""{
		sqlstr = "path = $"+strconv.Itoa(i)
		i++
		sqlpre = append(sqlpre,api.Path)
	}
	if api.Description != ""{
		if sqlstr != ""{
			sqlstr = sqlstr + " and description =$"+strconv.Itoa(i)
			i++
			sqlpre = append(sqlpre,api.Description)
		} else {
			sqlstr = " description=$"+strconv.Itoa(i)
			i++
			sqlpre = append(sqlpre,api.Description)
		}
	}
	if api.Method != ""{
		if sqlstr != ""{
			sqlstr = sqlstr + " and method =$"+strconv.Itoa(i)
			i++
			sqlpre = append(sqlpre,api.Method)
		} else {
			sqlstr = " method=$"+strconv.Itoa(i)
			i++
			sqlpre = append(sqlpre,api.Method)
		}
	}
	if api.ApiGroup != ""{
		if sqlstr != ""{
			sqlstr = sqlstr + " and apigroup =$"+strconv.Itoa(i)
			i++
			sqlpre = append(sqlpre,api.ApiGroup)
		} else {
			sqlstr = " apigroup=$"+strconv.Itoa(i)
			i++
			sqlpre = append(sqlpre,api.ApiGroup)
		}
	}
	sqlpre = append(sqlpre,limit)
	sqlpre = append(sqlpre,offset)
	rows,err := global.GVA_DB.Query("select * from sys_apis "+sqlstr+";",sqlpre...)
	if errors.Is(err, sql.ErrNoRows){
		return nil,list,total
	}
	for rows.Next() {
		var apitmp model.SysApi
		err = rows.Scan(&apitmp.ID,&apitmp.CreatedAt, &apitmp.UpdatedAt, &apitmp.DeletedAt, &apitmp.Path, &apitmp.Description, &apitmp.ApiGroup,&apitmp.Method)
		if err != nil {
			return err, list,total
		}
		apiList = append(apiList, apitmp)
		total++
	}
	return  nil,apiList,total
}
//@author: [piexlmax](https://github.com/piexlmax)
//@function: GetAllApis
//@description: 获取所有的api
//@return: err error, apis []model.SysApi
func GetAllApis() (err error, apis []model.SysApi) {
	rows, err := global.GVA_DB.Query("select * from sys_apis")
	if errors.Is(err,sql.ErrNoRows){
		return nil,apis
	}
	for rows.Next(){
		var apitmp model.SysApi
		err = rows.Scan(&apitmp.ID,&apitmp.CreatedAt, &apitmp.UpdatedAt, &apitmp.DeletedAt, &apitmp.Path, &apitmp.Description, &apitmp.ApiGroup,&apitmp.Method)
		if err != nil {
			return err, apis
		}
		apis = append(apis, apitmp)
	}
	return err,apis
}
