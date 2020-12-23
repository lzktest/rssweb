package core

import (
	"fmt"
	"server/global"
	"server/utils"
	"go.uber.org/zap"
	"go.Uber.org/zap/zapcore"
)

var level zapcore.Level

func Zap()(logger *zap.Logger) {
	if ok, _ := PathExists(global.GVA_CONFIG.Zap.Director); !ok {
		fmt.Printf("create %v directory\n", global.GVA_CONFIG.Zap.Directory)
		_ = os.Mkdir(global.GVA_CONFIG.Zap.Director, os.ModePerm)
	}
	switch global.GVA_CONFIG.Zap.Level {
		case ""
	}
}