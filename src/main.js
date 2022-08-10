import Vue from 'vue'
import App from './App.vue'
import ElementUI from 'element-ui';							// 引入ElementUI组件库
import 'element-ui/lib/theme-chalk/index.css';	// 引入ElementUI全部样式

Vue.config.productionTip = false

Vue.use(ElementUI)	// 使用ElementUI

new Vue({
  render: h => h(App),
}).$mount('#app')
