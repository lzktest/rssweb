package model

import (
	"server/global"
)

type SysApi struct {
	global.GVA_MODEL
	Path    string `json:"path"`
	Description string `json:"description"`
	ApiGroup  string `json:"apiGroup"`
	Method   string `json:"method"`
}
