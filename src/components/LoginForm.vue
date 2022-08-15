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
// axios.defaults.baseURL = 'http://127.0.0.1:5000/'
axios.defaults.baseURL = 'http://fcbyk.com:5000/'
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
                        this.open2()
                        router.push('/home')
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