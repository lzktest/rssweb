package v1

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"server/global"
	"server/model"
	"server/model/response"
	services "server/service"
)

// @Tags Jwt
// @Summary jwt加入黑名单
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Success 200 {string} string "{"success":true,"data":{},"msg":"拉黑成功"}"
// @Router /jwt/jsonInBlocklist [post]
func JsonInBlocklist(c *gin.Context){
	token := c.Request.Header.Get("x-token")
	jwt := model.JwtBlocklist{Jwt: token}
	if err := services.JsonInBlocklist(jwt); err != nil {
		global.GVA_LOG.Error("jwt作废失败!",zap.Any("err", err))
		response.FailWithMessage("jwt作废失败",c)
	} else {
		response.OkWithMessage("jwt作废成功", c)
	}
}
