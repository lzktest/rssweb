package router

import (
	"github.com/gin-gonic/gin"
	"server/api/v1"
	//"server/middleware"
)

func InitMenuRouter(Router *gin.RouterGroup)(R gin.IRoutes){
	MenuRouter := Router.Group("menu")//.Use(middleware.OperationRecord())
	{
		MenuRouter.POST("addBaseMenu", v1.AddBaseMenu)           // 新增菜单
		MenuRouter.POST("getBaseMenuTree", v1.GetBaseMenuTree)   // 获取用户动态路由
		MenuRouter.POST("getMenuList", v1.GetMenuList)           // 分页获取基础menu列表
		MenuRouter.POST("getBaseMenuById", v1.GetBaseMenuById)   // 根据id获取菜单
		MenuRouter.POST("getMenuAuthority", v1.GetMenuAuthority) // 获取指定角色menu
		MenuRouter.POST("getMenu", v1.GetMenu)  //获取所有动态路由
	}
	return MenuRouter
}