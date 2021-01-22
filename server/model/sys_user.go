package model

import (
	"server/global"
	"github.com/satori/go.uuid"
)

type SysUser struct {
	global.GVA_MODEL
	UUID 	uuid.UUID  `json:"uuid"`
	Username string `json:"userName"`
	Password string `json:"-"`
	NickName string `json:"nickName"`
	HeaderImg string `json:"headerImg"`
	Authority SysAuthority `json:"authority"`
	AuthorityId string `json:"authorityId"`
}
