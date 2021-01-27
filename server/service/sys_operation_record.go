package sevice

import (
	"server/global"
)

//@author: [granty1](https://github.com/granty1)
//@function: CreateSysOperationRecord
//@description: 创建记录
//@param: sysOperationRecord model.SysOperationRecord
//@return: err error

func CreateSysOperationRecord(s model.SysOperationRecord)(err error){
	_, err = global.GVA_DB.Exec("insert into sys_operation_records(createed_at,updateed_at,ip,method,path,status,latency,)(")
	return err
}