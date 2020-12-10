import { asyncRouterHandle } from '@/utils/asyncRouter'

//import { asyncMenu } from '@/api/menu'

const formatRouter = (routes) => {
    routes && routes.map(item => {
        item.meta.hidden = item.hidden
        if (item.children && item.children.length > 0 ){
            formatRouter(item.children)
        }
    })
}

export const router = {
    namespaced: true,
    state: {
        asyncRouters: []
    },
    mutations: {
        setAsyncRouter(state, asyncRouter){
            state.asyncRouter = asyncRouters
        }
    },
    actions:{
        async SetAsyncRouter({ commit }){
            const baseRouter = [{
                path: '/layout',
                name: 'layout',
                component: "view/layout/index.vue",
                meta: {
                    title: "底层layout"
                },
                children: []
            }]
            //const asyncRouterRes = await asyncMenu()
            const asyncRouter = asyncRouterRes.data.menus
            asyncRouter.push({
                path: "404",
                name: "404",
                hidden: "404",
                meta: {
                    title: "迷路了*。*",
                },
                component: 'view/error/index.vue'
            })
            formatRouter(asyncRouter)
            baseRouter[0].children = asyncRouter
            baseRouter.push({
                path: '*',
                redirect: '/layout/404'
            })
            asyncRouterHandle(baseRouter)
            commit('setAsyncRouter', baseRouter)
            //console.log('aaa')
            return true
        }
    },
    getters: {
        asyncRouter(state){
            return state.asyncRouters
        }
    }
}