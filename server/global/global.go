package global

import (
	"server/config"

	"github.com/spf13/viper"
)

var (
	GVA_CONFIG config.Server
	GVA_VP     *viper.Viper
)
