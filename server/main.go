package main

import (
	"server/core"
	"server/global"
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
}
