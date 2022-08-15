import Vue from 'vue'
import App from './App.vue'
import ElementUI from 'element-ui';							// 引入ElementUI组件库
import 'element-ui/lib/theme-chalk/index.css';	// 引入ElementUI全部样式
import VueRouter from 'vue-router'
import router from './router';

Vue.use(VueRouter)

Vue.config.productionTip = false

Vue.use(ElementUI)	// 使用ElementUI

router.beforeEach((to,from,next) => {
  if(to.name !== 'login' && sessionStorage.getItem('id') == null ){
    next({ name:'login'})
  }else{
    next()
  }
})

new Vue({
  render: h => h(App),
  router:router
}).$mount('#app')
