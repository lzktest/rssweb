package initialize

import "server/utils"

func init() {
	_ = utils.RedsiterRule("PageVerify",
		utils.Rules{
			"Page": {utils.NoteEmpty()},
			"PageSize": {utils.NoteEmpty()},
		},
	)
	_ = utils.RegisterRule("IdVerify",	
		utils.Rules{
			"Id": {utils.NoteEmpty()},
		}
	)
}