const fs = require('fs')            // 文件输入输出，用来导入证书        
const https = require('https')      // https服务器  
const express = require('express')  // express模块导入

//读取证书
const privateKey = fs.readFileSync('./secure/8574894_ali.fcbyk.com.key', 'utf8')
const certificate = fs.readFileSync('./secure/8574894_ali.fcbyk.com.pem', 'utf8')

// 创建 express 应用
const app = express()

// 监听 / 路径的 get 请求
app.get('/', function(req, res) {
  res.send('Hello Word!')
})

// 允许跨域
const cors = require('cors')
app.use(cors()) 

// 全局中间件
app.use((req,res,next)=>{
    res.setHeader('Access-Control-Allow-Origin', 'https://fcbyk.com');
    next()
})

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

const httpsServer = https.createServer({ key: privateKey, cert: certificate }, app)
httpsServer.listen(443, function() {
  console.log('https Server is running')
})
