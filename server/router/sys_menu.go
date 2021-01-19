package router

import (
	"github.com/gin-gonic/gin"
	"server/api/v1"

)

func InitMenuRouter(Router *gin.RouterGroup)(R gin.IRoutes){
	MenuRouter := Router.Group("menu")
	{
		MenuRouter.POST("addBaseMenu", v1.AddBaseMenu)           // 新增菜单
	}
	return MenuRouter
}