package v1

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	services "server/service"
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
// @Router /rss/getRssListJson [GET]
func GetRssListJson(c *gin.Context){
	rssdataid := c.Query("uuid")
	global.GVA_LOG.Error("创建失败!", zap.Any("err", rssdataid))
	if xml, err := services.GetRssDataJson(rssdataid); err != nil{
		global.GVA_LOG.Error("创建失败!", zap.Any("err", err))
		response.OkWithMessage("创建成功",c)
	} else {
		//c.Header("content-type","application/atom-xml; charset=UTF-8")
		c.Header("connection","keep-alive")
		c.Header("content-disposition","inline")
		c.XML(200,xml)

	}
}

// @Tags Rss
// @Summary 获取rss
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Success 200 {string} string "{"success":true,"data":{},"msg":"创建成功"}"
// @Router /rss/getRssListXml [GET]
func GetRssListXml(c *gin.Context){
	if xml, err := services.GetData(); err != nil{
		global.GVA_LOG.Error("创建失败!", zap.Any("err", err))
		response.OkWithMessage("创建成功",c)
	} else {
		//c.Header("content-type","application/atom-json; charset=UTF-8")
		c.Header("connection","keep-alive")
		c.Header("content-disposition","inline")
		c.XML(200,xml)
	}
}