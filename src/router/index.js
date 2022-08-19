import Login from '../pages/Login'
import Phone from '../pages/Phone'
import VueRouter from 'vue-router'

import PhoneNewOrder from '../pages/phone/PhoneNewOrder'
import PhoneManageAccount from '../pages/phone/PhoneManageAccount'
import PhoneOrderManagement from '../pages/phone/PhoneOrderManagement'
import PhoneSearch from '../pages/phone/PhoneSearch'

import PushTables from '../pages/tables/PushTables'
import ReceivingTable from '../pages/tables/ReceivingTable'
import FinishedTable from '../pages/tables/FinishedTable'

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
                    component:PhoneOrderManagement,
                    children:[
                        {
                            name:'push',
                            path:'push',
                            component:PushTables
                        },
                        {
                            name:'receiving',
                            path:'receiving',
                            component:ReceivingTable
                        },
                        {
                            name:'finished',
                            path:'finished',
                            component:FinishedTable
                        }                        
                    ]
                },
                {
                    path:'search',
                    component:PhoneSearch
                },
                {
                    path:'manage-account',
                    component:PhoneManageAccount
                }
            ]
        }
    ]
})