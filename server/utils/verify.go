package utils

var (
	AuthorityIdVerify = Rules{"AuthorityId": {NotEmpty()}}
	AuthorityVerify   = Rules{"AuthorityId": {NotEmpty()}, "AuthorityName": {NotEmpty()}, "ParentId": {NotEmpty()}}
	PageInfoVerify         = Rules{"Page": {NotEmpty()}, "PageSize": {NotEmpty()}}
	OldAuthorityVerify     = Rules{"OldAuthorityId": {NotEmpty()}}
	MenuVerify             = Rules{"Path": {NotEmpty()}, "ParentId": {NotEmpty()}, "Name": {NotEmpty()}, "Component": {NotEmpty()}, "Sort": {Ge("0")}}
	MenuMetaVerify         = Rules{"Title": {NotEmpty()}}
)
