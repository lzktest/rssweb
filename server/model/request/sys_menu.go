package request

import "server/model"

type AddMenuAuthorityInfo struct {
	Menus 	[]model.SysBaseMenu
	AuthorityId string
}
