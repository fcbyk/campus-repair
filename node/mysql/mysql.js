const mysql = require('mysql')
// 运行前需要配置数据库连接
const db = mysql.createPool({
    host: 'IP地址',
    user: '用户名',
    password: '密码',
    database: '数据库名称'
})

module.exports = db