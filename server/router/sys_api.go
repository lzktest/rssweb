package router

import (
	"server/api/v1"
	"github.com/gin-gonic/gin"
)

func InitApiRouter(Router *gin.RouterGroup){
	ApiRouter := Router.Group("api")
	{
		ApiRouter.POST("createApi", v1.CreateApi)   //创建api
	}
}
