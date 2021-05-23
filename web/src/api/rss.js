import service from '@/utils/request'

// @Tags Rss
// @Summary 获取rssList
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data body  true "获取rssList"
// @Success 200 {string} json "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /rss/getRssDataList [get]
export const getRssDataList = (data) => {
    return service({
        url: "/rss/getRssDataList",
        method: 'get',
        data
    })
}
// @Tags Rss
// @Summary 通过id获取rssList
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data body  true "通过id获取rssList"
// @Success 200 {string} json "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /rss/getRssDataList [get]
export const getRssDataListById = (data) => {
    return service({
        url: "/rss/getRssDataListById",
        method: 'post',
        data
    })
}
// @Tags Rss
// @Summary 添加rssList
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data body  true "添加rssList"
// @Success 200 {string} json "{"success":true,"data":{},"msg":"添加成功"}"
// @Router /rss/addRssDataList [get]
export const addRssDataList = (data) => {
    return service({
        url: "/rss/addRssDataList",
        method: 'post',
        data
    })
}
// @Tags Rss
// @Summary 删除rssList
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data body  true "删除rssList"
// @Success 200 {string} json "{"success":true,"data":{},"msg":"删除成功"}"
// @Router /rss/getRssDataList [get]
export const deleteRssDataList = (data) => {
    return service({
        url: "/rss/deleteRssDataList",
        method: 'post',
        data
    })
}
// @Tags Rss
// @Summary 更新rssList
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Param data body  true "更新rssList"
// @Success 200 {string} json "{"success":true,"data":{},"msg":"更新成功"}"
// @Router /rss/getRssDataList [get]
export const updateRssDataList = (data) => {
    return service({
        url: "/rss/updateRssDataList",
        method: 'post',
        data
    })
}