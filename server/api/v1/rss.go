package v1

import (
	"go.uber.org/zap"
	"github.com/gin-gonic/gin"
	"server/utils"
	//"server/model"
	"server/model/response"
	//"server/model/request"
	"server/global"
	//services "server/service"
)

// @Tags Rss
// @Summary 获取rss
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Success 200 {string} string "{"success":true,"data":{},"msg":"创建成功"}"
// @Router /rss/getRssList [GET]
func GetRssList(c *gin.Context){
	if xml, err := utils.GetData(); err != nil{
		global.GVA_LOG.Error("创建失败!", zap.Any("err", err))
		response.OkWithMessage("创建成功",c)
	} else {
		c.XML(200,xml)
	}
}