package v1

import (
	"go.uber.org/zap"
	"github.com/gin-gonic/gin"
	"server/utils"
	"server/model"
	"server/model/response"

	"server/global"
	services "server/service"
)

// @Tags SysApi
// @Summary 创建基础api
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data body model.SysApi true "api路径, api中文描述, api组, 方法"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"创建成功"}"
// @Router /api/createApi [post]
func CreateApi(c *gin.Context){
	var api model.SysApi
	_ = c.ShouldBindJSON(&api)
	if err := utils.Verify(api, utils.ApiVerify); err != nil {
		response.FailWithMessage(err.Error(),c)
		return
	}
	if err := services.CreateApi(api); err != nil{
		global.GVA_LOG.Error("创建失败!", zap.Any("err", err))
		response.FailWithMessage("创建失败",c)
	} else {
		response.OkWithMessage("创建成功",c)
	}
}
