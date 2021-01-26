package router

import (
	"github.com/gin-gonic/gin"
	"server/api/v1"
)

func InitJwtRouter(Router *gin.RouterGroup){
	ApiRouter := Router.Group("jwt")
	{
		ApiRouter.POST("jsonInBlocklist", v1.JsonInBlocklist) // jwt 加入黑名单
	}
}
