const db = require('../mysql/mysql.js')
const express = require('express')
let router = express.Router()

router.get('/test',function(req,res){
    db.query('select * from simple_account',(err,results)=>{
        if(err) return console.log(err.message)
        res.send(results)
    }) 
})

router.get('/tradition-1',function(req,res){
    db.query('select * from tradition where category="后勤报修" ',
    (err,results)=>{
        if(err) return console.log(err.message)
        res.send(results)
    }) 
})

router.get('/tradition-2',function(req,res){
    db.query('select * from tradition where category="水表、一卡通" ',
    (err,results)=>{
        if(err) return console.log(err.message)
        res.send(results)
    }) 
})

router.get('/tradition-3',function(req,res){
    db.query('select * from tradition where category="室内热水" ',
    (err,results)=>{
        if(err) return console.log(err.message)
        res.send(results)
    }) 
})

router.get('/tradition-4',function(req,res){
    db.query('select * from tradition where category="空调维修" ',
    (err,results)=>{
        if(err) return console.log(err.message)
        res.send(results)
    }) 
})

router.get('/tradition-5',function(req,res){
    db.query('select * from tradition where category="楼道饮水机维修" ',
    (err,results)=>{
        if(err) return console.log(err.message)
        res.send(results)
    }) 
})

router.get('/tradition-6',function(req,res){
    db.query('select * from tradition where category="消防" ',(err,results)=>{
        if(err) return console.log(err.message)
        res.send(results)
    }) 
})

module.exports = router