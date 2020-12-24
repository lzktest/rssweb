package main

import (
	//"database/sql"

	"fmt"
	"server/core"
	"server/global"

	_ "github.com/lib/pq"
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
	fmt.Print(global.GVA_CONFIG)
	global.GVA_LOG = core.Zap()
	global.GVA_DB = core.Pgcon()
	defer global.GVA_DB.Close()

}
