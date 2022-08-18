<template>
  <div class="all">
    <div class="photo">
        <div >
          <span @click="alter">
            <el-avatar :src="circleUrl" :size="150" ></el-avatar>
          </span>
          
        </div>
        <div>
          <p class="name">{{user.name}}</p>
          <el-tag class="tag">{{tag1}}</el-tag>
          <el-tag type="success" class="tag">新用户</el-tag>
        </div>
    </div>
    <div class="card">
      <div class="card-top">
        <p>基本信息</p>
        <p class='alter'  @click="dialogVisible2 = true">修改</p>

        <el-dialog
          :visible.sync="dialogVisible2"
          :fullscreen='true'
          title="修改个人信息"
          :show-close='false'
          >
        <el-form ref="user" :model="user" label-width="70px">
          <el-form-item label="ID" >
            <el-input v-model="id" disabled></el-input>
          </el-form-item>
          <el-form-item label="名字">
            <el-input v-model="user.name"></el-input>
          </el-form-item>
          <el-form-item label="人员类别">
            <el-select v-model="user.sort" placeholder="请选择类别" disabled>
              <el-option label="学生" value="student"></el-option>
              <el-option label="教职工" value="staff"></el-option>
              <el-option label="维修师傅" value="beijing"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="性别">
            <el-select v-model="user.gender" placeholder="请选择性别">
              <el-option label="男" value="男"></el-option>
              <el-option label="女" value="女"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="联系电话">
            <el-input v-model="user.phone"></el-input>
          </el-form-item>
          <el-form-item label="默认地址">
            <el-input type="textarea" v-model="user.addr"></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="confirm">修改</el-button>
            <el-button @click="dialogVisible2 = false">取消</el-button>
          </el-form-item>
        </el-form>
        </el-dialog>

      </div>
      <hr>
      <div class="card-bot">
        <p>id：{{id}}</p>
        <p>姓名：{{user.name}}</p>
        <p>人员类别：{{user.sort}}</p>
        <p>性别：{{user.gender}}</p>
        <p>联系电话：{{user.phone}}</p>
        <p>常用地址：{{user.addr}}</p>
      </div>
    </div>
      <div class="log-out">
      <el-button type="info" icon="el-icon-more" @click="dialogVisible = true"></el-button>
      <el-button type="info" @click="logout">退出登录</el-button>
    </div>

    <el-dialog
      :visible.sync="dialogVisible"
      width="70%"
      :show-close='false'
      custom-class='menudialog'
      top='30vh'
      >
      <div class="dia">
        <div class="change-icon">
          <i class="el-icon-setting"></i>
        </div>
        <p class="hh">热海大报修系统</p>
        <p class="tt">系统版本号：v0.1.0</p>
        <p class="tt">最近一次更新时间：2022-08-17</p>
        <div class="aa">
          <a href="javaScript:void(0) ">bug反馈</a>
          <a href="javaScript:void(0) ">联系我们</a>
        </div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import axios from 'axios'
import router from '@/router'
axios.defaults.baseURL = 'http://192.168.31.215:5000/'
// axios.defaults.baseURL = 'http://fcbyk.com:5000/'
export default {
    name:'PhoneManageAccount',
    data() {
      return {
        id:sessionStorage.getItem('id'),
        circleUrl: `https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fspider.nosdn.127.net%2F399b6ac1db4ba51e476d94fc859df37f.jpeg&refer=http%3A%2F%2Fspider.nosdn.127.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663262874&t=db0b7e9fec0ed51ef60040cb7a47559e`,
        user:{
          name: sessionStorage.getItem('name'),
          gender:  sessionStorage.getItem('gender'),
          phone:  sessionStorage.getItem('phone'),
          addr: sessionStorage.getItem('addr'),
          sort:  sessionStorage.getItem('sort')
        },
        state:true,
        dialogVisible:false,
        dialogVisible2:false,
        tag1:''
      }
    },
    mounted(){
      if(this.user.sort=='student'){
        this.tag1='学生'
      }else if(this.user.sort=='staff'){
        this.tag1='教职工'
      }else{
        this.tag1='维修师傅'
      }
    },
    methods:{
      beforelogin() {
            axios({
                method: 'POST',
                url:'/user',
                params: {
                    id: sessionStorage.getItem('id'),
                },
            }).then(response => {
                sessionStorage.setItem('name',response.data[0].user_name)
                sessionStorage.setItem('gender',response.data[0].user_gender)
                sessionStorage.setItem('phone',response.data[0].user_phone)
                sessionStorage.setItem('sort',response.data[0].user_sort)
                sessionStorage.setItem('addr',response.data[0].user_addr)
            }) 
      },
      alter(){
        this.$message({
          showClose: true,
          message: '暂不支持修改头像，如需修改，联系开发者',
          type: 'error'
        })
      },
      confirm(){
        axios({
              method: 'POST',
              url:'/alter-user',
              params: {
                  id: sessionStorage.getItem('id'),
                  name:this.user.name,
                  gender:this.user.gender,
                  phone:this.user.phone,
                  addr:this.user.addr
              },
          }).then(response => {
              if(response.data == 'successful'){
                  this.beforelogin() 
                  this.dialogVisible2 = false
                  this.$message({
                      message: '修改成功',
                      type: 'success'
                  })
              }
          },()=>{
            this.$message.error('数据库连接失败')
          })
      },
      user_info(){
        axios({
              method: 'POST',
              url:'/user',
              params: {
                  id: sessionStorage.getItem('id'),
              },
          }).then(response => {
              console.log(response.data)
              this.user.name = response.data[0].user_name
              this.user.gender = response.data[0].user_gender
              this.user.phone = response.data[0].user_phone
              this.user.sort = response.data[0].user_sort
          })
      },
      logout(){
        this.$confirm(this.user.name+'，您要下线了吗','',{
                customClass:'message'
            }).then( () => {
                router.replace('/')
                sessionStorage.clear()
            }).catch( () => {});
      },
      handleClose(done) {
        this.$confirm('确认关闭？',{
          customClass:'message'
        })
          .then(() => {
            done();
          })
          .catch(() => {});
      }
    },
}
</script>

<style scoped>
.photo{
  text-align: center;
  padding: 10px;
}
.photo p{
  text-align: center;
}
.name{
  font-size: 30px;
  font-weight: 700;
}
.tag{
  margin: 5px;
}
.card{
  height: 190px;
  /* background-color: aqua; */
  margin:0px 10px;
  border-radius: 5px;
  border: 1px rgba(122, 122, 122, 0.223) solid;
  padding:5px 15px;
}
.card-bot{
  font-size: 14px;
  color: rgb(50, 50, 50);
}
.card-bot P{
  margin-top: 2px;
}
.card-top{
  font-size: 20px;
  /* font-weight: bold; */
  margin-bottom: 8px;
  color:rgb(50, 50, 50);
  display: flex;
  justify-content: space-between;
}
hr{
  box-shadow: none;
  border: 0.1px rgba(122, 122, 122, 0.223) solid;
  box-sizing: border-box;
  margin-bottom: 5px;
}
.alter{
  font-size: 14px;
  padding-top: 5px;
  padding-right: 5px;
  color: #409EFF;
}
.log-out{
  text-align: end;
  padding-right: 30px;
  padding-top: 20px;
}
.change-icon{
  font-size:80px;
}
.hh{
  margin: 5px 0px;
  font-size: 16px;
  /* font-weight: bold; */
}
.tt{
  font-size: 12px;
}
.aa a{
  text-decoration: none;
  color: #409EFF;
  font-size: 11px;
  margin: 0px 5px;
}
.aa{
  margin-top: 5px;
}
</style>

<style>
.menudialog{
  /* background-color: aquamarine; */
  border-radius: 10px;
  padding: 0;
}
.dia{
  /* background-color: bisque; */
  border-radius: 10px;
  height: 210px;
  display: flex;
  align-items: center;
  flex-direction: column;
}
</style>