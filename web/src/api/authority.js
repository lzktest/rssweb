import service from '@/utils/request'

// @Router  /authority/getAuthorityList [post]
export const getAuthorityList = (data) => {
    return service({
        url: "/authority/getAuthorityList",
        method: 'post',
        data
    })
}