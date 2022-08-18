import Login from '../pages/Login'
import Phone from '../pages/Phone'
import VueRouter from 'vue-router'

import PhoneNewOrder from '../pages/phone/PhoneNewOrder'
import PhoneManageAccount from '../pages/phone/PhoneManageAccount'
import PhoneOrderManagement from '../pages/phone/PhoneOrderManagement'

export default new VueRouter({
    routes:[
        {
            path:'/',
            name:'login',
            component:Login
        },
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
                    component:PhoneOrderManagement
                },
                {
                    path:'search',
                    component:PhoneOrderManagement
                },
                {
                    path:'manage-account',
                    component:PhoneManageAccount
                }
            ]
        }
    ]
})