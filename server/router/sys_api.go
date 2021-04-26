package router

import (
	"server/api/v1"
	"github.com/gin-gonic/gin"
)

func InitApiRouter(Router *gin.RouterGroup){
	ApiRouter := Router.Group("api")
	{
		ApiRouter.POST("createApi", v1.CreateApi)   //创建api
		ApiRouter.POST("deleteApi", v1.DeleteApi)   //删除api
		ApiRouter.POST("getAllApis", v1.GetAllApis)   //获取所有api不分页
		ApiRouter.POST("getApiList", v1.GetApiList)   //获取所有api分页
		ApiRouter.POST("getApiById", v1.GetApiById) //根据id获取api
		ApiRouter.POST("updateApi", v1.UpdateApi) //根据id修改api
		ApiRouter.POST("deleteApisByIds", v1.DeleteApisByIds) //删除所有选中的api

	}
}
