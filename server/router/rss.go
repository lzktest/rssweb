package router

import (
	"server/api/v1"
	"github.com/gin-gonic/gin"
)

func InitRssRouter(Router *gin.RouterGroup){
	ApiRouter := Router.Group("rss")
	{
		ApiRouter.GET("getRssListJson", v1.GetRssListJson)   //获取数据
		ApiRouter.GET("getRssListXml", v1.GetRssListXml)   //获取数据
	}
}
