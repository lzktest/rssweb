package utils

var (
	IdVerify               = Rules{"ID": {NotEmpty()}}
	AuthorityIdVerify = Rules{"AuthorityId": {NotEmpty()}}
	AuthorityVerify   = Rules{"AuthorityId": {NotEmpty()}, "AuthorityName": {NotEmpty()}, "ParentId": {NotEmpty()}}
	PageInfoVerify         = Rules{"Page": {NotEmpty()}, "PageSize": {NotEmpty()}}
	OldAuthorityVerify     = Rules{"OldAuthorityId": {NotEmpty()}}
	MenuVerify             = Rules{"Path": {NotEmpty()}, "ParentId": {NotEmpty()}, "Name": {NotEmpty()}, "Component": {NotEmpty()}, "Sort": {Ge("0")}}
	MenuMetaVerify         = Rules{"Title": {NotEmpty()}}
	LoginVerify            = Rules{"CaptchaId": {NotEmpty()}, "Captcha": {NotEmpty()}, "Username": {NotEmpty()}, "Password": {NotEmpty()}}
	RegisterVerify         = Rules{"Username": {NotEmpty()}, "NickName": {NotEmpty()}, "Password": {NotEmpty()}, "AuthorityId": {NotEmpty()}}
	ChangePasswordVerify   = Rules{"Username": {NotEmpty()}, "Password": {NotEmpty()}, "NewPassword": {NotEmpty()}}
	SetUserAuthorityVerify = Rules{"UUID": {NotEmpty()}, "AuthorityId": {NotEmpty()}}
	ApiVerify		= Rules{"Path":{NotEmpty()},"Description":{NotEmpty()},"ApiGroup":{NotEmpty()},"Method":{NotEmpty()}}
	RssDatas 	=Rules{"Xmltype":{NotEmpty()},"XmlTitle":{NotEmpty()},"XmlLink":{NotEmpty()},"CycleTime":{NotEmpty()}}
	RssDatasUpdate 	=Rules{"Id":{NotEmpty()},"Xmltype":{NotEmpty()},"XmlTitle":{NotEmpty()},"XmlLink":{NotEmpty()},"CycleTime":{NotEmpty()}}
	RssDataLoad =Rules{"titel":{NotEmpty()},"htmlUrl":{NotEmpty()}}
)
