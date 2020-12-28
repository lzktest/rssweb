package utils

import (
	"server/global"

	"go.uber.org/zap"
)

func CheckErr(err error) {
	if err != nil {
		global.GVA_LOG.Error("sql exec err: ", zap.Any("err", err))
	}
}
