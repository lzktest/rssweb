package router

import (
	v1 "server/api/v1"

	"github.com/gin-gonic/gin"
)

// 不需要验证的路由
func InitBaseRouter(Router *gin.RouterGroup) (R gin.IRoutes) {
	BaseRouter := Router.Group("base")
	{
		//BaseRouter.POST("login", v1.Login)
		BaseRouter.POST("captcha", v1.Captcha)
		BaseRouter.POST("UpdateCasbin", v1.UpdateCasbin)
		BaseRouter.POST("getPolicyPathByAuthorityId", v1.GetPolicyPathByAuthorityId)
	}
	return BaseRouter
}
