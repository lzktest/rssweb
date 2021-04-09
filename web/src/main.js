import Vue from 'vue'
import App from './App.vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

Vue.config.productionTip = false

Vue.use(ElementUI)

import router from '@/router/index'
import { store } from '@/store/index'

// 路由守卫
import Bus from '@/utils/bus.js'
Vue.use(Bus)

import '@/permission'

new Vue({
  render: h => h(App),
  router,
  store
}).$mount('#app')
