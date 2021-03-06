import router from './router'
import { store } from '@/store/index'
import getPageTitle from '@/utils/page'

let asyncRouterFlag = 0

// token验证白名单
const whiteList  = ['login','init','public']
// 公共目录（登录不影响）
const publicList = ['rssview']
router.beforeEach(async(to, from, next) => {
    const token = store.getters['user/token']
    // 在白名单中的判断情况
    // 修改网页标签名称
    document.title = getPageTitle(to.meta.title)
    if (publicList.indexOf(to.name) > -1){
        next()
    } else {
        if (whiteList.indexOf(to.name) > -1){
            if (token) {
                next({ name: store.getters['user/userInfo'].authority.defaultRouter })
            } else {
                next()
            }
        } else {
            // 不在白名单中并且已经登陆的时候
            if (token) {
                // 添加flag防止多次获取动态路由和栈溢出
                if (!asyncRouterFlag && store.getters['router/asyncRouters'].length == 0){
                    asyncRouterFlag++
                    await store.dispatch('router/SetAsyncRouter')
                    const asyncRouters = store.getters['router/asyncRouters']
                    //router.addRoute(asyncRouters)
                    for(var i=0;i<asyncRouters.length;i++){
                        router.addRoute(asyncRouters[i])
                    }
                    next({...to,replace: true})
                } else {
                    next()
                }
            }
            // 不在白名单中且未登陆的时候
            if (!token) {
                next({
                    name: "login",
                    query: {
                        redirect: document.location.hash
                    }
                })
            }
        }
    }
} 
)