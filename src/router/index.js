import Login from '../pages/Login'
import Home from '../pages/Home'
import OrderManagement from '../pages/OrderManagement'
import NewOrder from '../pages/NewOrder'
import Search from '../pages/Search'
import ManageAccount from '../pages/ManageAccount'
import Phone from '../pages/Phone'
import VueRouter from 'vue-router'

import PhoneNewOrder from '../pages/phone/PhoneNewOrder'
import PhoneManageAccount from '../pages/phone/PhoneManageAccount'

export default new VueRouter({
    routes:[
        {
            path:'/phone',
            name:'phone',
            component:Phone,
            children:[
                {
                    path:'new-order',
                    component:PhoneNewOrder
                },
                {
                    path:'order-management',
                    component:PhoneNewOrder
                },
                {
                    path:'search',
                    component:PhoneNewOrder
                },
                {
                    path:'manage-account',
                    component:PhoneManageAccount
                }
            ]
        },
        {
            path:'/',
            name:'login',
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