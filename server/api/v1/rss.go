package v1

import (
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
	"server/model"
	"server/model/request"
	services "server/service"
	"server/utils"

	//"server/model"
	"server/model/response"
	//"server/model/request"
	"server/global"
	//services "server/service"
)

// @Tags Rss
// @Summary 获取rssjson
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Success 200 {string} string "{"success":true,"data":{},"msg":"创建成功"}"
// @Router /rss/getRssListJson [GET]
func GetRssListJson(c *gin.Context){
	rssdataid := c.Query("uuid")
	if xml, err := services.GetRssDataJson(rssdataid); err != nil{
		global.GVA_LOG.Error("获取失败!", zap.Any("err", err))
		response.OkWithMessage("获取失败",c)
	} else {
		//c.Header("content-type","application/atom-xml; charset=UTF-8")
		c.Header("connection","keep-alive")
		c.Header("content-disposition","inline")
		c.JSON(200,xml)

	}
}

// @Tags Rss
// @Summary 获取rssxml
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Success 200 {string} string "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /rss/getRssListXml [GET]
func GetRssListXml(c *gin.Context){
	rssdataid := c.Query("uuid")
	if xml, err := services.GetRssDataJson(rssdataid); err != nil{
		global.GVA_LOG.Error("获取失败!", zap.Any("err", err))
		response.OkWithMessage("获取失败",c)
	} else {
		//c.Header("content-type","application/atom-json; charset=UTF-8")
		c.Header("connection","keep-alive")
		c.Header("content-disposition","inline")
		c.XML(200,xml)
	}
}
// @Tags Rss
// @Summary 获取rssdata
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Success 200 {string} string "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /rss/getRssDataList [GET]
func GetRssDataList(c *gin.Context){
	if xmltmp, err := services.GetRssDataList(); err != nil{
		global.GVA_LOG.Error("获取失败!", zap.Any("err", err))
		response.FailWithMessage("获取失败",c)
	} else {
		//c.Header("content-type","application/atom-json; charset=UTF-8")
		response.OkWithData(model.RssDataList{RssDataLists: xmltmp},c)
	}
}

// @Tags Rss
// @Summary 通过id获取rssdata
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data body model.RssDatas  true "id"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /rss/getRssDataListById [POST]
func GetRssDataListById(c *gin.Context){
	var rsstmp model.RssDatas
	_ = c.ShouldBindJSON(&rsstmp)
	if xmltmp, err := services.GetRssDataListbyId(rsstmp.Id); err != nil{
		global.GVA_LOG.Error("获取失败!", zap.Any("err", err))
		response.FailWithMessage("获取失败",c)
	} else {
		//c.Header("content-type","application/atom-json; charset=UTF-8")
		response.OkWithData( xmltmp,c)
	}
}

// @Tags Rss
// @Summary 添加rssdata
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data body model.RssDatas  true "xmltype,xmlttitle,xmldescription,xmllink,cycletime"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"添加成功"}"
// @Router /rss/addRssDataList [post]
func AddRssDataList(c *gin.Context){
	var rsstmp model.RssDatas
	_ = c.ShouldBindJSON(&rsstmp)
	if err := utils.Verify(rsstmp,utils.RssDatas); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := services.AddRssDataList(rsstmp); err != nil{
		global.GVA_LOG.Error("添加失败!", zap.Any("err", err))
		response.FailWithMessage("添加失败",c)
	} else {
		//c.Header("content-type","application/atom-json; charset=UTF-8")
		response.OkWithMessage("添加成功", c)
	}
}
// @Tags Rss
// @Summary 修改rssdata
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data body model.RssDatas  true "id,xmltype,xmlttitle,xmldescription,xmllink,cycletime"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"修改成功"}"
// @Router /rss/updateRssDataList [post]
func UpdateRssDataList(c *gin.Context){
	var rsstmp model.RssDatas
	_ = c.ShouldBindJSON(&rsstmp)
	if err := utils.Verify(rsstmp,utils.RssDatasUpdate); err != nil {
		response.FailWithMessage(err.Error(), c)
		return
	}
	if err := services.UpdateRssDataList(rsstmp); err != nil{
		global.GVA_LOG.Error("修改失败!", zap.Any("err", err))
		response.FailWithMessage("修改失败",c)
	} else {
		//c.Header("content-type","application/atom-json; charset=UTF-8")
		response.OkWithMessage("修改成功", c)
	}
}

// @Tags Rss
// @Summary 删除rssdata
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data body request.RssIdsReq true "id"
// @Success 200 {string} string "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /rss/deleteRssDataList [post]
func DeleteRssDataList(c *gin.Context){
	var rssidtmp request.RssIdsReq
	_ = c.ShouldBindJSON(&rssidtmp)
	global.GVA_LOG.Error("删除失败!", zap.Any("err", rssidtmp))
	if err := services.DeleteDataList(rssidtmp); err != nil{
		global.GVA_LOG.Error("删除失败!", zap.Any("err", err))
		response.FailWithMessage("删除失败",c)
	} else {
		response.OkWithMessage("删除成功", c)
	}
}