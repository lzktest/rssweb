package router

import (
	"server/api/v1"
	"github.com/gin-gonic/gin"
)

func InitRssRouter(Router *gin.RouterGroup){
	ApiRouter := Router.Group("rss")
	{
		ApiRouter.GET("getRssListJson", v1.GetRssListJson)   //获取rss json
		ApiRouter.GET("getRssListXml", v1.GetRssListXml)   //获取rss xml
		ApiRouter.GET("getRssDataList", v1.GetRssDataList)   //获取rss列表
		ApiRouter.POST("addRssDataList", v1.AddRssDataList)   //添加数据
		ApiRouter.POST("deleteRssDataList", v1.DeleteRssDataList)   //删除数据
		ApiRouter.POST("updateRssDataList", v1.UpdateRssDataList)   //更新rss数据
		ApiRouter.POST("getRssDataListById", v1.GetRssDataListById)   //通过id获取数据
	}
}
