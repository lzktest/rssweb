package model

import (
	"server/global"
	"time"
)

//如含有time.Time 请自行import time包
type SysOperationRecord struct {
	global.GVA_MODEL
	Ip 	string `json:"ip"`
	Method string `json:"method"`
	Path string `json:"path"`
	Status int `json:"status"`
	Latency time.Duration `json:"latency"`
	Agent  string `json:"agent"`
	ErrorMessage string `json:"error_message"`
	Body   string `json:"body"`
	Resp   string `json:"resp"`
	UserID int `json:"user_id"`
	User  SysUser `json:"user"`
}
