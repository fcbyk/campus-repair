const db = require('../mysql/mysql.js')
const express = require('express')
let router = express.Router()

router.post('/register',(req,res)=>{
    db.query('insert into register set ?',req.query,(err,results)=>{
        if(err) {
            res.send('err')
        }
        if(results.affectedRows===1){
            res.send('successful')
        }
    }) 
})

router.post('/login',(req,res)=>{
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

router.post('/user',(req,res)=>{
    db.query('select * from user_information where user_id= ? ',
    req.query.id,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

router.post('/category',(req,res)=>{
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

router.post('/alter-user',(req,res)=>{
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

router.post('/neworder',(req,res)=>{
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

router.post('/getpush',(req,res)=>{
    db.query('select * from repair_order where init_id= ? and order_state="推送中"',
    req.query.id,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

router.post('/getreceiving',(req,res)=>{
    db.query('select * from repair_order where init_id= ? and order_state="已接单"',
    req.query.id,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

router.post('/getfinished',(req,res)=>{
    db.query('select * from repair_order where init_id= ? and order_state="已完成"',
    req.query.id,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

router.post('/deletethis',(req,res)=>{
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

router.post('/alterorder',(req,res)=>{
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

router.post('/getsquare',(req,res)=>{
    db.query('select * from repair_order where rsort=? and order_state="推送中"',
    req.query.category,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

router.post('/order-receiving',(req,res)=>{
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

router.post('/gettodolist',(req,res)=>{
    db.query('select * from repair_order where rid=? and order_state="已接单"',
    req.query.rid,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

router.post('/order-acomplish',(req,res)=>{
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

router.post('/getcompleted',(req,res)=>{
    db.query('select * from repair_order where rid=? and order_state="已完成"',
    req.query.rid,(err,results)=>{
        if(err) {
            res.send('err')
            return console.log(err.message)
        }
        res.send(results)
    }) 
})

module.exports = router