package sevice

import (
	"go.uber.org/zap"
	"server/global"
	"server/model"
)

//@author: [granty1](https://github.com/granty1)
//@function: CreateSysOperationRecord
//@description: 创建记录
//@param: sysOperationRecord model.SysOperationRecord
//@return: err error

func CreateSysOperationRecord(s model.SysOperationRecord)(err error){
	//_, err = global.GVA_DB.Exec("insert into sys_operation_records(createed_at,updateed_at,ip,method,path,status,latency,) values($1,$2,$3,$4,$5,$6,$7);",s.CreatedAt,s.UpdatedAt,s.Ip,s.Method,s.Path,s.Status,s.Latency)
	global.GVA_LOG.Info("operation record",zap.Any("err",s))
	return err
}