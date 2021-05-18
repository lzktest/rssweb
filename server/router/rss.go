package router

import (
	"server/api/v1"
	"github.com/gin-gonic/gin"
)

func InitRssRouter(Router *gin.RouterGroup){
	ApiRouter := Router.Group("rss")
	{
		ApiRouter.GET("getRssList", v1.GetRssList)   //获取数据
	}
}
