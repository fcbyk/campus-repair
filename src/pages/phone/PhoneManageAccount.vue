<template>
  <div class="all">
    <div class="photo">
        <div @click="alter">
          <el-avatar :src="circleUrl" :size="150"></el-avatar>
        </div>
        <div>
          <p class="name">{{user.name}}</p>
          <el-tag class="tag">学生</el-tag>
          <el-tag type="success" class="tag">新用户</el-tag>
        </div>
    </div>
    <div class="card">
      <div class="card-top">
        <p>基本信息</p>
        <p class='alter'>修改</p>
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
      <el-button type="warning">修改密码</el-button>
      <el-button type="danger">退出登录</el-button>
    </div>
    
  </div>
</template>

<script>
import axios from 'axios'
axios.defaults.baseURL = 'http://127.0.0.1:5000/'
// axios.defaults.baseURL = 'http://fcbyk.com:5000/'
export default {
    name:'PhoneManageAccount',
    data() {
      return {
        id:sessionStorage.getItem('id'),
        circleUrl: `https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fspider.nosdn.127.net%2F399b6ac1db4ba51e476d94fc859df37f.jpeg&refer=http%3A%2F%2Fspider.nosdn.127.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1663262874&t=db0b7e9fec0ed51ef60040cb7a47559e`,
        user:{
          name:'',
          gender: '',
          phone: '',
          addr:'',
          sort:''
        },
        state:true
      }
    },
    mounted() {
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
          }) 
    },
    methods:{
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
              },
          }).then(response => {
              if(response.data == 'successful'){
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
          })
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
  text-align: center;
  /* padding-right: 20px; */
  padding-top: 20px;
}
</style>