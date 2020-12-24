package initialize

import (
	"fmt"
	"net/http"
	"server/global"

	"github.com/gin-gonic/gin"
	"github.com/unrolled/secure"
)

// 初始化总路由
func Routers() *gin.Engine {
	var Router = gin.Default()
	Router.StaticFS(global.GVA_CONFIG.Local.Path, http.Dir(global.GVA_CONFIG.Local.Path)) // 为用户头像和文件提供静态地址
	// Router.Use(LoadTls())  // 打开就能玩https了
	global.GVA_LOG.Info("use middleware logger")
}

// 用https把这个中间件在router里面use一下就好

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
