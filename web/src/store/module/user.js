import { login } from '@/api/user'
import { jsonInBlacklist } from '@/api/jwt'
import router from '@/router/index'
export const user = {
    namespaced: true,
    state: {
        userInfo: {
            uuid: "",
            nickName: "",
            headerImg: "",
            authority: "",
        },
        token: "",
        expiresAt: ""
    },
    mutations: {
        setUserInfo(state, userInfo){
            // 这里的 `state` 对象是模块的局部状态
            state.userInfo = userInfo
        },
        setToken(state, token){
            // 这里的`state`对象是模块的局部状态
            state.token = token
        },
        setExpiresAt(state, expiresAt){ 
            //  这里的`state`对象是模块的局部状态
            state.expiresAt = expiresAt
        },
        LoginOut(state){
            state.userInfo = {}
            state.token = ""
            state.expiresAt = ""
            router.push({ name: 'login', replace: true})
            sessionStorage.clear()
            window.location.reload()
        },
        ResetUserInfo(state, userInfo = {}){
            state.userInfo = {...state.userInfo,
                ...userInfo
            }
        }
    },
    actions: {
        async LoginIn({ commit, dispatch, rootGetters}, loginInfo){
            const res = await login(loginInfo)
            //console.log(res)
            if (res.Code == 0){
                commit('setUserInfo', res.Data.user)
                commit('setToken', res.Data.Token)
                commit('setExpiresAt', res.Data.ExpiresAt)
                await dispatch('router/SetAsyncRouter',{},{root: true})
                const asyncRouters = rootGetters['router/asyncRouters']
                router.addRoutes(asyncRouters)
                const redirect = router.history.current.query.redirect
                if (redirect){
                    router.push({ path: redirect})
                } else {
                    router.push({ path: '/layout'})
                }
                return true
            }
            
        },
        async LoginOut({ commit }){
            const res = await jsonInBlacklist()
            if (res.code == 0){
                commit("LoginOut")
            }
        }
    },
    getters: {
        userInfo(state){
            return state.userInfo
        },
        token(state){
            return state.token
        },
    }
}