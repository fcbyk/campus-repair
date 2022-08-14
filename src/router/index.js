import Login from '../pages/Login'
import Home from '../pages/Home'
import OrderManagement from '../pages/OrderManagement'
import NewOrder from '../pages/NewOrder'
import Search from '../pages/Search'
import ManageAccount from '../pages/ManageAccount'
import VueRouter from 'vue-router'

export default new VueRouter({
    routes:[
        {
            path:'/',
            component:Login
        },
        {
            path:'/home',
            component:Home,
            children:[
                {
                    path:'new-order',
                    component:NewOrder
                },
                {
                    path:'order-management',
                    component:OrderManagement
                },
                {
                    path:'search',
                    component:Search
                },
                {
                    path:'manage-account',
                    component:ManageAccount
                }
            ]
        },
    ]
})