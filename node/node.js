const express = require('express')
const app = express()


// const cors = require('cors')
// app.use(cors()) 

const mysql = require('mysql')
const db = mysql.createPool({
    host: '',
    user: '',
    password: '',
    database: 'hntou_repair'
})

// let session=require('express-session')
// app.use(session({
//     secret:'keyboard cat',
//     resave:false,
//     saveUninitialized:true
// }))

app.get('/test',function(req,res){
    db.query('select * from simple_account',(err,results)=>{
        if(err) return console.log(err.message)
        res.send(results)
    }) 
})

app.post('/register',(req,res)=>{
    db.query('insert into register set ?',req.query,(err,results)=>{
        if(err) {
            res.send('err')
        }
        if(results.affectedRows===1){
            res.send('successful')
        }
    }) 
})

app.post('/login',(req,res)=>{
    // req.query.id
    db.query('select pw from register where id= ? ',
    req.query.id,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        if(results.length==0){
            res.send('empty')
            return 0
        }
        if(results[0].pw == req.query.pw){
            res.send('successful')
            // req.session.user = req.query
            // req.session.islogin = true
        }else{
            res.send('err')
        }

    }) 
})

app.post('/user',(req,res)=>{
    db.query('select * from user_information where user_id= ? ',
    req.query.id,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

app.post('/category',(req,res)=>{
    db.query('select * from category where rid= ? ',
    req.query.id,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

const sql1 = 'call alter_user_info(?, ?, ?, ?,?, ?)' 

app.post('/alter-user',(req,res)=>{
    // console.log(req.query)
    db.query(sql1,[req.query.name, req.query.gender, 
        req.query.phone,req.query.addr, req.query.id,
        req.query.category],(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        if(results.affectedRows===1){
            res.send('successful')
        }
    }) 
})

app.get('/tradition-1',function(req,res){
    db.query('select * from tradition where category="后勤报修" ',
    (err,results)=>{
        if(err) return console.log(err.message)
        res.send(results)
    }) 
})
app.get('/tradition-2',function(req,res){
    db.query('select * from tradition where category="水表、一卡通" ',
    (err,results)=>{
        if(err) return console.log(err.message)
        res.send(results)
    }) 
})
app.get('/tradition-3',function(req,res){
    db.query('select * from tradition where category="室内热水" ',
    (err,results)=>{
        if(err) return console.log(err.message)
        res.send(results)
    }) 
})
app.get('/tradition-4',function(req,res){
    db.query('select * from tradition where category="空调维修" ',
    (err,results)=>{
        if(err) return console.log(err.message)
        res.send(results)
    }) 
})
app.get('/tradition-5',function(req,res){
    db.query('select * from tradition where category="楼道饮水机维修" ',
    (err,results)=>{
        if(err) return console.log(err.message)
        res.send(results)
    }) 
})
app.get('/tradition-6',function(req,res){
    db.query('select * from tradition where category="消防" ',(err,results)=>{
        if(err) return console.log(err.message)
        res.send(results)
    }) 
})

app.post('/neworder',(req,res)=>{
    db.query('call new_orders(?,?,?,?,?,?)',
    [req.query.number, req.query.sort, req.query.equ, 
    req.query.uid, req.query.addr, req.query.note],
    (err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        if(results.affectedRows===1){
            res.send('successful')
        }
    }) 
})

app.post('/getpush',(req,res)=>{
    db.query('select * from repair_order where init_id= ? and order_state="推送中"',
    req.query.id,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

app.post('/getreceiving',(req,res)=>{
    db.query('select * from repair_order where init_id= ? and order_state="已接单"',
    req.query.id,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

app.post('/getfinished',(req,res)=>{
    db.query('select * from repair_order where init_id= ? and order_state="已完成"',
    req.query.id,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

app.post('/deletethis',(req,res)=>{
    db.query('delete from repair_order where rnumber= ? ',
    req.query.number,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        if(results.affectedRows===1){
            res.send('successful')
        }
    }) 
})

app.post('/alterorder',(req,res)=>{
    db.query('call alter_orders(?,?,?,?,?)',
    [ req.query.sort, req.query.equ, 
    req.query.addr, req.query.note,req.query.number],
    (err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        if(results.affectedRows===1){
            res.send('successful')
        }
    }) 
})

app.post('/getsquare',(req,res)=>{
    db.query('select * from repair_order where rsort=? and order_state="推送中"',
    req.query.category,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

app.post('/order-receiving',(req,res)=>{
    db.query('update repair_order set order_state="已接单",rid = ? where rnumber = ?;',
    [req.query.rid,req.query.rnumber],(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        if(results.affectedRows===1){
            res.send('successful')
        }
    }) 
})

app.post('/gettodolist',(req,res)=>{
    db.query('select * from repair_order where rid=? and order_state="已接单"',
    req.query.rid,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

app.post('/order-acomplish',(req,res)=>{
    db.query('update repair_order set order_state="已完成" where rnumber = ?;',
    [req.query.rnumber],(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        if(results.affectedRows===1){
            res.send('successful')
        }
    }) 
})

app.post('/getcompleted',(req,res)=>{
    db.query('select * from repair_order where rid=? and order_state="已完成"',
    req.query.rid,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

app.use(express.static('dist'))

app.listen(5000,()=>{
    console.log('express server running at http://fcbyk.com:5000')
})
