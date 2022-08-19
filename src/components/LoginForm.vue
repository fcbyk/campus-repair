<template>
    <div class="loginform">
        <el-input v-model="id" placeholder="请输入账号" id="idd"></el-input>
        <el-input v-model="pw" placeholder="请输入密码" show-password></el-input>
        <div id="wm"><a href="javascript:void">忘记密码?&nbsp;&nbsp;</a></div>
        <button class="btn-login" @click="login">登录</button>
    </div>
</template>

<script>
import axios from 'axios'
import router from '@/router'
axios.defaults.baseURL = 'http://192.168.31.215:5000/'
// axios.defaults.baseURL = 'http://fcbyk.com:5000/'
let emptyStr = ''
export default {
    name:'LoginForm',
    data() {
        return {
            id:emptyStr,
            pw:emptyStr,
        }
    },
    methods:{
        getpush(){
            axios({
                method: 'POST',
                url:'/getpush',
                params: {
                    id: sessionStorage.getItem('id'),
                },
            }).then(response => {
                sessionStorage.setItem('push',JSON.stringify(response.data))
            },()=>{})
        },
        getreceiving(){
            axios({
                method: 'POST',
                url:'/getreceiving',
                params: {
                    id: sessionStorage.getItem('id'),
                },
            }).then(response => {
                sessionStorage.setItem('receiving',JSON.stringify(response.data))
            },()=>{})
        },
        getfinished(){
            axios({
                method: 'POST',
                url:'/getfinished',
                params: {
                    id: sessionStorage.getItem('id'),
                },
            }).then(response => {
                sessionStorage.setItem('finished',JSON.stringify(response.data))
            },()=>{})
        },
        open2() {
            this.$message({
                message: '登录成功',
                type: 'success'
            })
        },
        login(){
            let aa = this.id
            let bb = this.pw
            if(aa == emptyStr){
                this.$message.error('请输入账号')
                return 0
            }
            if(bb == emptyStr){
                this.$message.error('请输入密码')
                return 0
            }
            axios({
                method: 'POST',
                url:'/login',
                params: {
                    id: aa,
                    pw: bb,
                },}).then(response => {
                    if(response.data == 'successful'){
                        sessionStorage.setItem('id',this.id)
                        this.beforelogin()
                        this.getpush()
                        this.getreceiving()
                        this.getfinished()
                        this.open2()
                        router.replace('/phone/new-order')
                    }
                    if(response.data == 'err'){
                        this.$message.error('密码错误')
                    }
                    if(response.data == 'empty'){
                        this.$message.error('不存在该账号')
                    }
                },()=>{
                    this.$message.error('数据库连接失败')
            })
        },
        beforelogin() {
            axios({
                method: 'POST',
                url:'/user',
                params: {
                    id: this.id,
                },
            }).then(response => {
                sessionStorage.setItem('name',response.data[0].user_name)
                sessionStorage.setItem('gender',response.data[0].user_gender)
                sessionStorage.setItem('phone',response.data[0].user_phone)
                sessionStorage.setItem('sort',response.data[0].user_sort)
                sessionStorage.setItem('addr',response.data[0].user_addr)
            }) 
            if(this.id[0]=='r'){
                axios({
                    method: 'POST',
                    url:'/category',
                    params: {
                        id: this.id,
                    },
                }).then(response => {
                    sessionStorage.setItem('category',response.data[0].category)
                }) 
            }
        },
    }
}
</script>

<style>
.loginform{
  border: solid rgb(206, 206, 206) 1px;
  width: 300px;
  /* height: 250px; */
  background-color: rgb(243, 250, 255);
  border-radius: 10px;
  padding: 10px 20px;
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: center;
}
.loginform #idd{
  margin-bottom: 10px;
  margin-top: 10px;
}
.btn-login{
    margin: 10px;
    width: 300px;
    height: 40px;
    border-radius: 5px;
    border: none;
    background-color: rgb(1, 142, 1);
    color: aliceblue;
    font-weight: 500;
    margin-top: 20px;
}
.btn-login:hover{
    background-color: rgb(0, 117, 0);
}
#wm{
  width: 300px;
  font-size: 10px;
  color: rgb(105, 105, 105);
  text-align: end;
  margin-top: 5px;
}
#wm a{
  text-decoration: none;
  color: #6f6f6f;
}
#wm a:hover{
  color: rgb(73, 73, 73);
}
</style>