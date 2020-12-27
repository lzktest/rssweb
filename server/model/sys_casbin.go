package model

type CasbinModel struct {
	Ptype       string `json:"ptype"`
	AuthorityId string `json:"rolename"`
	Path        string `json:"path"`
	Method      string `json:"method"`
}
