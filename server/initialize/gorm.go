package initialize

import (
	"os"
	"server/global"
	"server/model"

	"go.uber.org/zap"
	//	"gorm.io/driver/mysql"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
)

// Gorm  初始化数据库并产生数据库全局变量
func Gorm() *gorm.DB {
	switch global.GVA_CONFIG.System.DbType {
	case "mysql":
		//	return GormMysql()
		return nil
	case "postgresql":
		return GormPg()
	default:
		return GormPg()
	}
}

// MysqlTables 注册mysql数据库表专用
// func MysqlTables(db *gorm.DB) {
// 	err := db.AutoMigrate(
// 		model.SysUser{},
// 	)
// 	if err != nil {
// 		global.GVA_LOG.Error("register table faild", zap.Any("err", err))
// 		os.Exit(0)
// 	}
// 	global.GVA_LOG.Info("register table success")
// }

// PgTables 注册pg数据库表专用
func PgTables(db *gorm.DB) {
	err := db.AutoMigrate(
		model.SysUser{},
	)
	if err != nil {
		global.GVA_LOG.Error("register table faild", zap.Any("err", err))
		os.Exit(0)
	}
	global.GVA_LOG.Info("register table success")
}

// GormMysql 初始化Mysql数据库
// func GormMysql() *gorm.DB {
// 	m := global.GVA_CONFIG.Mysql
// 	dsn := m.Username + ":" + m.Password + "@tcp(" + m.Path + ")/" + m.Dbname + "?" + m.Config
// 	mysqlConfig := mysql.Config{
// 		DSN:                       dsn,   // DSN  data source name
// 		DefaultStringSize:         191,   // string 类型字段的默认长度
// 		DisableDatetimePrecision:  true,  // 禁用datetime精度, mysql5.6 之前的数据库不支持
// 		DontSupportRenameIndex:    true,  //重命名索引时采用删除并重建的方式, MySQL 5.6 之前的数据库和 MariaDB 不支持重命名索引
// 		DontSupportRenameColumn:   true,  // 用 `change` 重命名列， MySQL 5.7 之前的数据库和MariaDB 不支持重命名索引
// 		SkipInitializeWithVersion: false, // 根据版本自动配置
// 	}
// 	if db, err := gorm.Open(mysql.New(mysqlConfig), gormConfig(m.LogMode)); err != nil {
// 		global.GVA_LOG.Error("MySQL启动异常", zap.Any("err", err))
// 		os.Exit(0)
// 		return nil
// 	} else {
// 		sqlDB, _ := db.DB()
// 		sqlDB.SetMaxIdleConns(m.MaxIdleConns)
// 		sqlDB.SetMaxOpenConns(m.MaxOpenConns)
// 	}
// }

// GormPg 初始化pg数据库
func GormPg() *gorm.DB {
	m := global.GVA_CONFIG.Pg
	dsn := "host=" + m.Host + " user=" + m.User + " password=" + m.Password + " dbname=" + m.Dbname + " port=" + m.Port + " sslmode=" + m.SslMode + " timezone=" + m.TimeZone
	pgConfig := postgres.config{
		DSN:                  dsn, // data source name
		PreferSimpleProtocol: false,
	}
	if db, err := gorm.Open(postgres.New(pgConfig), gormConfig(m.LogMode)); err != nil {
		global.GVA_LOG.Error("PG连接异常", zap.Any("err", err))
		os.Exit(0)
		return nil
	} else {
		sqlDB, _ := db.DB()
		sqlDB.SetMaxIdleConns(m.MaxIdleConns)
		sqlDB.SetMaxOpenConns(m.MaxOpenConns)
		return db
	}
}

// gormConfig 根据配置决定是否开启日志
func gormConfig(mod bool) *gorm.Config {
	if global.GVA_CONFIG.Gg.LogZap {
		return &gorm.Config{
			Logger:                                   Default.LogMode(logger.Info),
			DisableForeignKeyConstraintWhenMigrating: true,
		}
	}
	if mod {
		return &gorm.Config{
			Logger:                                   logger.Default.LogMode(logger.Info),
			DisableForeignKeyConstraintWhenMigrating: true,
		}
	} else {
		return &gorm.Config{
			Logger:                                   logger.Default.LogMode(logger.Silent),
			DisableForeignKeyConstraintWhenMigrating: true,
		}
	}
}
