package request

import "server/model"

type AddMenuAuthorityInfo struct {
	Menus 	[]model.SysBaseMenu
	AuthorityId string
}
// Get role by id structure
type GetAuthorityId struct {
	AuthorityId string
}
