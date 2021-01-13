package utils

var (
	AuthorityIdVerify = Rules{"AuthorityId": {NotEmpty()}}
	AuthorityVerify   = Rules{"AuthorityId": {NotEmpty()}, "AuthorityName": {NotEmpty()}, "ParentId": {NotEmpty()}}
)
