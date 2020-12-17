package main

import (
	"server/core"
	"server/global"
	"server/initialize"
)

// @title Swagger Example API
// @version 0.0.1
// @description This is a sample Server pets
// @securityDefinitions.apikey ApiKeyAuth
// @in header
// @name x-token
// @BasePath /

func main() {
	global.GVA_VP = core.Viper()
	global.GVA_LOG = core.Zap()
	global.GVA_DB = initialize.Gorm()
	//	initialize.MysqlTables(global.GVA_DB)
	initialize.PgTables(global.GVA_DB)
	db, _ := global.GVA_DB.DB()
	defer db.Close()
	core.RunWindowsServer()
}
