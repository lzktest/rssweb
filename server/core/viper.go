package core

import (
	"flag"
	"fmt"
	"server/global"
)

func Viper(path ...string) *viper.Viper{
	var config string
	if len(path) == 0 {
		flag.StringVar(&config, "c","","choose config file.")
		flag.Parse()
		if config == "" { // 优先级：命令行 > 环境变量 > 默认值
			if configEnv := os.Getenv(utils.ConfigEnv);
		}
	}
}