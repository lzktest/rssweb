// +build windows

package core

import (
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
)

//  处理零停机重启和代码升级
func initServer(address string, router *gin.Engine) server {
	return &http.Server{
		Addr:           address,
		Handler:        router,
		ReadTimeout:    10 * time.Second,
		WriteTimeout:   10 * time.Second,
		MaxHeaderBytes: 1 << 20,
	}
}
