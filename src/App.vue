<template>
  <div id="app">
    <div class="change-icon">
      <i class="el-icon-setting"></i>
    </div>
    <p>热海大报修系统</p>
    <div class="formm">
      <el-input v-model="id" placeholder="请输入账号" id="idd"></el-input>
      <el-input placeholder="请输入密码" v-model="pw" show-password></el-input>
      <div id="wm"><a href="javascript:void">忘记密码?&nbsp;&nbsp;</a></div>
      <button class="btn-login" >登录</button>
    </div>
    <div class="bott">
      <a href="javascript:void">注册账号</a>
      <a @click="drawer = true" @mouseup="pwDrawer">测试账号</a>
      <a href="https://www.yuque.com/docs/share/7e6c1b5d-5487-4c0f-8384-1ea451914d51?# 《课程设计报告》" target="blank">课程设计报告</a>
      <a href="https://element.eleme.cn/#/zh-CN" target="blank">Element UI</a>
    </div>
    <el-drawer
      title="已注册账号"
      :visible.sync="drawer"
      direction="ltr"
      :before-close="handleClose">
      
      <p>{{ax}}</p>
    </el-drawer>
  </div>
</template>

<script>
// import HelloWorld from './components/HelloWorld.vue'
import axios from 'axios'
axios.defaults.baseURL = 'http://127.0.0.1:5000/'
export default {
  name: 'App',
  components: {
    // HelloWorldd
  },
  data() {
    return {
      id:'',
      pw:'',
      radio:'',
      drawer: false,
      ax:'我来了！123'
    }
  },
  methods: {
    handleClose(done) {
      this.$confirm('确认关闭？')
        .then( () => {
          done();
        })
        .catch( ()=> {});
    },
    pwDrawer(){
        // drawer = true
        console.log('123')
        axios.get('/').then(res=>{
          console.log(this)
          this.ax = res.data
        })
    }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  /* text-align: center; */
  color: #2c3e50;
  margin-top: 60px;
  display: flex;
  justify-content: center;
  flex-direction: column;
  align-items: center;
  /* width: 100vw; */
}
.change-icon{
    font-size:50px;
}
.formm{
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
#idd{
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
.bott{
  margin-top: 100px;
}
.bott a{
  text-decoration: none;
  margin-left: 10px;
  margin-right: 10px;
  color: #6f6f6f;
}
.bott a:hover{
  color: rgb(55, 55, 55);
  text-decoration-line: underline;
}
</style>
