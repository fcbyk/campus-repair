<template>
  <div class="manage">
    <div class="ma-top">
      <div class="ma-topone">
        <el-avatar :src="circleUrl" :size="150"></el-avatar>
        
      </div>
      <div class="ma-toptwo">
        <el-form ref="form" :model="user" label-width="40px" size="mini">
          <el-form-item label="名字">
            <el-input size="mini" v-model="user.name" :disabled="state"></el-input>
          </el-form-item>
          <el-form-item label="id">
            {{name}}
          </el-form-item>
        </el-form>
      </div>
    </div>

    <div class="ma-bott">
      <el-form ref="form" :model="user" label-width="80px" size="medium">
        <el-form-item label="性别">
          <el-radio-group v-model="user.gender" size="medium">
            <el-radio border label="男" :disabled="state"></el-radio>
            <el-radio border label="女" :disabled="state"></el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="联系电话" style="width: 300px;">
          <el-input v-model="user.phone" :disabled="state"></el-input>
        </el-form-item>
        <el-form-item label="默认地址" style="width: 500px;">
          <el-input v-model="user.addr" :disabled="state"></el-input>
        </el-form-item>
        <div style="height: 100px;"></div>
        <el-form-item size="medium">
          <el-button @click="alter">修改</el-button>
          <el-button type="primary" @click="confirm">确定修改</el-button>
        </el-form-item>
      </el-form>
    </div>
    
  </div>
</template>

<script>
import axios from 'axios'
axios.defaults.baseURL = 'http://127.0.0.1:5000/'
// axios.defaults.baseURL = 'http://fcbyk.com:5000/'

export default {
    name:'ManageAccount',
    data() {
      return {
        name:sessionStorage.getItem('id'),
        circleUrl: "https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png",
        user:{
          name:'',
          gender: '',
          phone: '',
          addr:''
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
        this.state = false
      },
      confirm(){
        this.state = true
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
.manage{
    padding: 30px;
    padding-left: 100px;
    height: 96.5vh;
    margin: 10px;
    margin-left: 0px;
    border-radius: 10px;
    background-color: rgb(255, 255, 255);
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
.ma-top{
  display: flex;
  /* background-color: bisque; */
  margin: 10px;
  border-radius: 10px;
}
.ma-topone{
  padding: 10px;
}
.ma-toptwo{
  display: flex;
  flex-direction: column;
  justify-content: end;
  padding: 10px;
}
.ma-bott{
  /* background-color: aquamarine; */
  margin: 10px;
  border-radius: 10px;
}
p{
  margin-top: 10px;
}
</style>