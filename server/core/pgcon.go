package core

import (
	"database/sql"
	"fmt"
	"os"
	"server/global"
	"server/initialize"

	_ "github.com/lib/pq"
	"go.uber.org/zap"
)

// pg 数据库连接初始化并测试连接情况
func Pgcon() *sql.DB {
	connStr := "user=" + global.GVA_CONFIG.Pg.Username + " password=" + global.GVA_CONFIG.Pg.Password + " dbname=" + global.GVA_CONFIG.Pg.Dbname + " sslmode=" + global.GVA_CONFIG.Pg.Sslmode + " host=" + global.GVA_CONFIG.Pg.Host + " port=" + global.GVA_CONFIG.Pg.Port
	global.GVA_LOG.Debug("start connect db")
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		global.GVA_LOG.Error("postgres connect err:", zap.Any("err", err))
		os.Exit(0)
	} else {
		db.SetMaxOpenConns(global.GVA_CONFIG.Pg.MaxOpenConns)
		db.SetMaxIdleConns(global.GVA_CONFIG.Pg.MaxIdleConns)

		rows, err := db.Query("select  1;")
		if err != nil {
			global.GVA_LOG.Error("db connect err:", zap.Any("err", err))
		} else {
			var st string
			for rows.Next() {
				rows.Scan(&st)
				fmt.Println(st)
			}
			if st == "1" {
				//global.GVA_DB = db
				global.GVA_LOG.Info("postgres connect success at:", zap.Any("Info", connStr))
			} else {
				global.GVA_LOG.Error("db select 1 err")
				os.Exit(0)
			}
		}
	}
	if global.GVA_CONFIG.System.UseMultipoint {
		initialize.Redis()
	}
	return db
}
