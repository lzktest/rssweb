// +build !windows

package core

import (
	"time"

	"github.com/fvbock/endless"
	"github.com/gin-gonic/gin"
)

//  处理零停机重启和代码升级
func initServer(address string, router *gin.Engine) server {
	s := endless.NewServer(address, router)
	s.ReadHanderTimeout = 10 * time.Millisecond
	s.WriteTimeout = 10 * time.Second
	s.MaxHeaderBytes = 1 << 10
	return s
}
