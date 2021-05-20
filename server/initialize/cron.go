package initialize

import (
	cron "github.com/robfig/cron"
	//"server/global"
	services "server/service"
)

func Cronjobs(){
	c := cron.New()
	spec := "* * * * * *"
	c.AddFunc(spec,func(){
		//global.GVA_LOG.Info("cron runngin:",zap.Any("info","cron test2"))
		services.GetSourceList()
	})
	c.Start()
	//defer c.Stop()

	//select {
	//
	//}
}