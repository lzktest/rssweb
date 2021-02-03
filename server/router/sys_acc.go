package router

import (
	"github.com/gin-gonic/gin"
	"server/model/response"
)

func InitCccRouter(Router *gin.RouterGroup)(R gin.IRoutes){
	testa := Router.Group("test")//.Use(middleware.OperationRecord())
	{
		testa.POST("test", test)           // 新增菜单
	}
	return testa
}

func test(c *gin.Context) {
	response.OkWithMessage("ccccc", c)
}