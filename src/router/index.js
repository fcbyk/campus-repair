import Login from '../pages/Login'
import Phone from '../pages/Phone'
import VueRouter from 'vue-router'

import PhoneNewOrder from '../pages/phone/PhoneNewOrder'
import PhoneManageAccount from '../pages/phone/PhoneManageAccount'

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
        }
    ]
})