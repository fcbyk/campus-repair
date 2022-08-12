<template>
  <div id="app">
    {{width2()}}
    <div class="change-icon">
      <i class="el-icon-setting"></i>
    </div>
    <p>热海大报修系统</p>

    <div class="formm">
      <el-input v-model="id" placeholder="请输入账号" id="idd"></el-input>
      <el-input placeholder="请输入密码" v-model="pw" show-password></el-input>
      <div id="wm"><a href="javascript:void">忘记密码?&nbsp;&nbsp;</a></div>
      <button class="btn-login" @click="login">登录</button>
    </div>

    <div class="bott">
      <a @click="dialogVisible = true">注册账号</a>
      <a @click="drawer = true" @mouseup="pwDrawer">测试账号</a>
      <a href="https://www.yuque.com/docs/share/7e6c1b5d-5487-4c0f-8384-1ea451914d51?# 《课程设计报告》" target="blank">课程设计报告</a>
      <a href="https://element.eleme.cn/#/zh-CN" target="blank">Element UI</a>
    </div>

    <el-drawer
      title="已注册账号"
      :visible.sync="drawer"
      direction="ltr"
      :before-close="handleClose"
      :size="lwidth">
      <div v-for="p in ax" :key="p.id" class="yzc">
        <p>账号:{{p.id}}</p>
        <p>密码:{{p.pw}}</p>
      </div>
    </el-drawer>

    <el-dialog
      title="注册账号"
      :visible.sync="dialogVisible"
      :width="lwidth"
      :before-close="cancel">

      <el-form ref="form" :model="form" label-width="80px">
          <el-form-item label="我是">
            <el-select v-model="form.region" placeholder="你的身份">
              <el-option label="学生" value="student"></el-option>
              <el-option label="教职工" value="staff"></el-option>
              <el-option label="维修师傅" value="repairMan"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="设置账号">
            <el-input v-model="form.name"></el-input>
          </el-form-item>
          <el-form-item label="设置密码">
            <el-input v-model="form.zpw1" show-password></el-input>
          </el-form-item>
          <el-form-item label="确认密码">
            <el-input v-model="form.zpw2" show-password></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="onSubmit">立即创建</el-button>
            <el-button @click="cancel('确认关闭？')">取消</el-button>
          </el-form-item>
      </el-form>
    </el-dialog>
    <!-- <p>{{width1}}</p> -->
  </div>
</template>

<script>
// import HelloWorld from './components/HelloWorld.vue'
import axios from 'axios'
// axios.defaults.baseURL = 'http://127.0.0.1:5000/'
axios.defaults.baseURL = 'http://fcbyk.com:5000/'
let width=window.innerWidth
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
      ax:'我来了！123',
      dialogVisible: false,
      lwidth:'30%',
      form: {
          name: '',
          region: '',
          zpw1:'',
          zpw2:'',
      },
      width1:width
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
        // console.log('123')
        axios.get('/').then(res=>{
          // console.log(this)
          this.ax = res.data
        })
    },
    cancel(){
        this.$confirm('确认关闭？')
        .then( () => {
          this.dialogVisible=false
          this.form.name= ''
          this.form.region= ''
          this.form.zpw1=''
          this.form.zpw2=''
        })
        .catch( ()=> {});
    },
    open1() {
      this.$notify({
        title: '注册成功',
        message: '请记住你的账号密码',
        type: 'success'
      });
    },
    open4(x) {
      this.$notify.error({
        title: '注册失败',
        message: x
      });
    },
    open2() {
      this.$message({
        message: '密码正确，但未能跳转，页面开发中',
        type: 'success'
      });
    },
    onSubmit() { 
      if(this.form.region==''){
        this.$message.error('请选择你的身份')
        return 0
      }
      if(this.form.name==''){
        this.$message.error('账号不能为空')
        return 0
      }
      if(this.form.zpw1==''){
        this.$message.error('密码不能为空')
        return 0
      }
      if(this.form.zpw1 != this.form.zpw2){
        this.$message.error('两次输入的密码不一致')
        return 0
      }
      if(this.form.region=='student' && this.form.name[0]!='s'){
        this.$message.error('学生账号必须以s开头')
        return 0
      }
      if(this.form.region=='staff' && this.form.name[0]!='t'){
        this.$message.error('教职工账号必须以t开头')
        return 0
      }
      if(this.form.region=='repairMan' && this.form.name[0]!='r'){
        this.$message.error('维修师傅账号必须以r开头')
        return 0
      }
      console.log('submit!');
      let aa=this.form.name
      let bb=this.form.zpw2
      let cc=this.form.region
      axios({
        method: 'POST',
        url:'/register',
        params: {
            id: aa,
            pw: bb,
            sort: cc
        },
      }).then(response => {
        if(response.data=='successful'){
          this.open1()
        }
        if(response.data=='err'){
          this.open4('已存在该账号')
        }
        
      },()=>{
        this.open4('数据库连接失败')
      })
      console.log(333)
    },
    login(){
      let aa=this.id
      let bb=this.pw
      if(aa==''){
        this.$message.error('请输入账号');
        return 0
      }
      if(bb==''){
        this.$message.error('请输入密码');
        return 0
      }
      axios({
      method: 'POST',
      url:'/login',
      params: {
          id: aa,
          pw: bb,
      },}).then(response => {
        if(response.data=='successful'){
          this.open2()
        }
        if(response.data=='err'){
          this.$message.error('密码错误');
        }
        if(response.data=='empty'){
          this.$message.error('不存在该账号');
        }
      },()=>{
        this.$message.error('数据库连接失败');
      })
    },
    width2(){
      console.log(this.width1)
      if(this.width1<=900){
        this.lwidth='90%'
      }else{
        this.lwidth='30%'
      }
    },
  },
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
  font-size: 15px;
}
.bott a:hover{
  color: rgb(55, 55, 55);
  text-decoration-line: underline;
}
.yzc{
  margin: 20px;
  border: #a9a9a9 solid 1px;
  padding: 10px;
  border-radius: 10px;
}
</style>
