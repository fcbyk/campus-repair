import Login from '../pages/Login'
import Home from '../pages/Home'
import VueRouter from 'vue-router'

export default new VueRouter({
    routes:[
        {
            path:'/login',
            component:Login
        },
        {
            path:'/home',
            component:Home
        }
    ]
})