import Vue from 'vue'
import 'element-ui/lib/theme-chalk/index.css';	// 引入ElementUI全部样式
import App from './App.vue'
// 路由
import VueRouter from 'vue-router'
import router from './router';
Vue.use(VueRouter)

import { 
  Dialog,Form,Input,Drawer,Message,
  MessageBox,Button,Select,Tag,
  Avatar,Empty,FormItem,Option,Notification,Radio,
  Checkbox,Col,DatePicker,TimePicker,Tabs,TabPane,
  Table,TableColumn,Popover} from 'element-ui'	// 按需引入

Vue.use(Popover)
Vue.use(TableColumn)
Vue.use(Table)
Vue.use(TabPane)
Vue.use(Tabs)
Vue.use(TimePicker)
Vue.use(DatePicker)
Vue.use(Col)
Vue.use(Dialog)
Vue.use(Form)
Vue.use(Input)
Vue.use(Drawer)
Vue.use(Button)
Vue.use(Select)
Vue.use(Tag)
Vue.use(Avatar)
Vue.use(Empty)
Vue.use(FormItem)
Vue.use(Option)
Vue.use(Radio)
Vue.use(Checkbox)
Vue.prototype.$message = Message
Vue.prototype.$confirm = MessageBox.confirm
Vue.prototype.$notify = Notification
Vue.config.productionTip = false


// 全局路由守卫
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
