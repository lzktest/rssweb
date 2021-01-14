package v1

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"server/global"
	"server/model"
	"server/model/request"
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

// @Tags Authority
// @Summary 分页获取角色列表
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data body request.PageInfo true "页码, 每页大小"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /authority/getAuthorityList [post]
func GetAuthorityList(c *gin.Context) {
	var pageInfo request.PageInfo
	_ = c.ShouldBindJSON(&pageInfo)
	if err := utils.Verify(pageInfo, utils.PageInfoVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err, list, total := services.GetAuthorityInfoList(pageInfo); err != nil {
		global.GVA_LOG.Error("获取失败！",zap.Any("err", err))
		response.FailWithMessage("获取失败"+err.Error(),c)
	} else {
		response.OkWithDetailed(response.PageResult{
			List: list,
			Total: total,
			Page: pageInfo.Page,
			PageSize: pageInfo.PageSize,
		},"获取成功",c)
	}
}
// @Tags Authority
// @Summary 拷贝角色
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data body response.SysAuthorityCopyResponse true "旧角色id, 新角色id, 新权限名, 新父角色id"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"拷贝成功"}"
// @Router /authority/copyAuthority [post]
func CopyAuthority(c *gin.Context){
	var copyInfo response.SysAuthorityCopyResponse
	_ = c.ShouldBindJSON(&copyInfo)
	if err := utils.Verify(copyInfo, utils.OldAuthorityVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := utils.Verify(copyInfo.Authority,utils.AuthorityVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err, authBack := services.CopyAuthority(copyInfo); err != nil {
		global.GVA_LOG.Error("拷贝失败！", zap.Any("err", err))
		response.FailWithMessage("拷贝失败"+err.Error(), c)
	} else {
		response.OkWithDetailed(response.SysAuthorityResponse{Authority: authBack},"拷贝成功",c)
	}
}

// @Tags Authority
// @Summary 更新角色信息
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data body model.SysAuthority true "权限id, 权限名, 父角色id"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"更新成功"}"
// @Router /authority/updateAuthority [post]
func UpdateAuthority(c *gin.Context) {
	var auth model.SysAuthority
	_ = c.ShouldBindJSON(&auth)
	if err := utils.Verify(auth, utils.AuthorityVerify); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err, authority := services.UpdateAuthority(auth); err != nil {
		global.GVA_LOG.Error("更新失败!", zap.Any("err", err))
		response.FailWithMessage("更新失败"+err.Error(), c)
	} else {
		response.OkWithDetailed(response.SysAuthorityResponse{Authority: authority}, "更新成功", c)
	}
}