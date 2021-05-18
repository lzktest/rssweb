package main

import (
	//"database/sql"

	_ "github.com/lib/pq"
	"server/core"
	"server/global"
	//"server/initialize"
	//"server/utils"
)

// @title Swagger Example API
// @version 0.0.1
// @description This is a sample Server pets
// @securityDefinitions.apikey ApiKeyAuth
// @in header
// @name x-token
// @BasePath /

func main() {
	//utils.GetData()
	global.GVA_VP = core.Viper()
	global.GVA_LOG = core.Zap()
	global.GVA_DB = core.Pgcon()

	defer global.GVA_DB.Close()
	core.RunWindowsServer()
}
