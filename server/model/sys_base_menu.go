package model
import "server/global"
type SysBaseMenu struct {
	global.GVA_MODEL
	MenuLevel uint `json: "-"`
	ParentId  string `json:"parentId"`
	Path  string `json:"path"`
	Name string `json:"name"`
	Hidden  bool `json:"hidden"`
	Component string `json:"component"`
	Sort  int `json:sort`
	Meta  `json:"meta"`
	SysAuthoritys []SysAuthority `json:"authoritys"`
	Children []SysBaseMenu `json:"children"`
	//Parameters []SysBaseMenuParameter `json:"parameters"`
}

type Meta struct {
	KeepAlive bool `json:"keepAlive"`
	DefaultMenu bool `json:defautlMenu`
	Title  string `json:"title"`
	Icon   string `json:"icon"`
}
type SysBaseMenuParameter struct {
	global.GVA_MODEL
	SysBaseMenuID uint
	Type 	string `json:"type"`
	Key 	string `json:"key"`
	Value    string `json:value`
}
