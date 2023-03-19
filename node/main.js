const express = require('express')
const app = express()

// 允许跨域
const cors = require('cors')
app.use(cors()) 

// let session=require('express-session')
// app.use(session({
//     secret:'keyboard cat',
//     resave:false,
//     saveUninitialized:true
// }))

// 注册路由模块
app.use(require('./router/get.js'))
app.use(require('./router/post.js'))

// 托管静态资源
// app.use(express.static('dist'))

app.listen(80,()=>{
    console.log('express server is running in http://127.0.0.1/')
})
