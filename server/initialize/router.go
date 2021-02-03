package initialize

import (
	"fmt"
	"net/http"
	_ "server/docs"
	"server/global"
	"server/router"
	"server/middleware"

	"github.com/gin-gonic/gin"
	ginSwagger "github.com/swaggo/gin-swagger"
	"github.com/swaggo/gin-swagger/swaggerFiles"
	"github.com/unrolled/secure"
)

// 初始化总路由
func Routers() *gin.Engine {
	var Router = gin.Default()
	Router.StaticFS(global.GVA_CONFIG.Local.Path, http.Dir(global.GVA_CONFIG.Local.Path)) // 为用户头像和文件提供静态地址
	// Router.Use(LoadTls())  // 打开就能玩https了
	// global.GVA_LOG.Info("use https ...")
	// 跨域
	//Router.Use(Cors())
	global.GVA_LOG.Info("handler cross-domain ...")
	// 添加swagger路由
	Router.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))
	global.GVA_LOG.Info("register swagger handler")
	// 不需要鉴权的路由
	PublicGroup := Router.Group("")
	{
		router.InitBaseRouter(PublicGroup) // 注册基础功能路由 不做鉴权
		router.InitCasbinRouter(PublicGroup)  // 添加及修改api权限，获取api权限列表
		router.InitAuthorityRouter(PublicGroup) // 角色操作

		router.InitJwtRouter(PublicGroup)                   // jwt相关路由
		router.InitUserRouter(PublicGroup)                  // 注册用户路由

	}
	PrivateGroup := Router.Group("")
	PrivateGroup.Use(middleware.JWTAuth())//.Use(middleware.CasbinHandler())
	{
		router.InitCccRouter(PrivateGroup)   // 测试
		router.InitMenuRouter(PrivateGroup)  // 菜单操作
	}
	global.GVA_LOG.Info("router register success")
	return Router
}

// 用https把这个中间件在router里面use一下就好
// 使用https
func LoadTls() gin.HandlerFunc {
	return func(c *gin.Context) {
		middleware := secure.New(secure.Options{
			SSLRedirect: true,
			SSLHost:     "localhost:443",
		})
		err := middleware.Process(c.Writer, c.Request)
		if err != nil {
			// 如果出现错误，请不要继续
			fmt.Println(err)
			return
		}
		// 继续往下处理
		c.Next()
	}
}

// 处理跨域请求,支持options访问
func Cors() gin.HandlerFunc {
	return func(c *gin.Context) {
		method := c.Request.Method
		origin := c.Request.Header.Get("Origin")
		c.Header("Access-Control-Allow-Origin", origin)
		c.Header("Access-Control-Allow-Headers", "Content-Type,AccessToken,X-CSRF-Token, Authorization, Token,X-Token,X-User-Id")
		c.Header("Access-Control-Allow-Methods", "POST, GET, OPTIONS,DELETE,PUT")
		c.Header("Access-Control-Expose-Headers", "Content-Length, Access-Control-Allow-Origin, Access-Control-Allow-Headers, Content-Type")
		c.Header("Access-Control-Allow-Credentials", "true")

		// 放行所有OPTIONS方法
		if method == "OPTIONS" {
			c.AbortWithStatus(http.StatusNoContent)
		}
		// 处理请求
		c.Next()
	}
}
