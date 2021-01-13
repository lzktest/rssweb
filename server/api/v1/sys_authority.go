package v1

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"server/global"
	"server/model"
	"server/model/response"
	services "server/service"
	"server/utils"
)

// @Tags Authority
// @Summary 创建角色
// @accept application/json
// @Produce application/json
// @Param data body model.SysAuthority true "权限id,权限名,父角色id"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"创建成功"}"
// @Router /authority/createAuthority [post]
func CreateAuthority(c *gin.Context){
	var authority model.SysAuthority
	_ = c.ShouldBindJSON(&authority)
	if err := utils.Verify(authority,utils.AuthorityVerify); err != nil {
		response.FailWithMessage(err.Error(),c)
		return
	}
	if err, authBack := services.CreateAuthority(authority); err != nil {
		global.GVA_LOG.Error("创建失败!",zap.Any("err",err))
		response.FailWithMessage("创建失败!"+err.Error(), c)
	} else {
		response.OkWithDetailed(response.SysAuthorityResponse{Authority: authBack}, "创建成功", c)
	}
}