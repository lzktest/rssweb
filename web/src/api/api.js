import service from '@/utils/request'
// @Tags Api
// @Summary 获取所有的Api 不分页
// @Security ApiKeyAuth
// @accept application/json
// @Produce application/json
// @Success 200 {string} json "{"success":true,"data":{},"msg":"获取成功"}"
// @Router /api/getAllApis [post]
export const getAllApis = (data) => {
    return service({
        url: "/api/getAllApis",
        method: 'post',
        data
    })
}
