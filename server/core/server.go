package core

import (
	"fmt"
	"server/global"
	"server/initialize"
	"time"
)

type server interface {
	ListenAndServe() error
}

func RunWindowsServer() {
	if global.GVA_CONFIG.System.UseMultipoint {
		fmt.Printf("test")
	}
	Router := initialize.Routers()
	address := fmt.Sprintf(":%d", global.GVA_CONFIG.System.Addr)
	s := initServer(address, Router)
	// 保证文本正常输出
	time.Sleep(10 * time.Microsecond)
	fmt.Printf(`
	欢迎使用 testproject
	当前版本:V2.3.8
	默认自动化文档地址:http://127.0.0.1%s/swagger/index.html
	默认前端文件运行地址:http://127.0.0.1:8080
`, address)
	go 	initialize.Cronjobs()
	global.GVA_LOG.Error(s.ListenAndServe().Error())
}
