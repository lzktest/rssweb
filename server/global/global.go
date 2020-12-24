package global

import (
	"database/sql"
	"server/config"

	_ "github.com/lib/pq"

	"github.com/spf13/viper"
	"go.uber.org/zap"
)

var (
	GVA_CONFIG config.Server
	GVA_VP     *viper.Viper
	GVA_LOG    *zap.Logger
	GVA_DB     *sql.DB
)
