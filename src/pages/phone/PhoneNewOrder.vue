<template>
  <div class="new">
    <div class="newtop">
      <p class="new-title">欢迎使用热海大报修系统</p>
      <p>请选择您的报修方式</p>
    </div>
    <div class="newbot">
      <div class="box1" @click="dialogVisible = true">
        <div class="left"><i class="el-icon-phone-outline"></i></div>
        <div class="right">
          <i>传统报修</i>
          <p>通过传统电话方式进行报修，本系统会为您提供维修电话</p>
        </div>
      </div>
      <div class="box2" @click="neworder">
        <div class="left"><i class="el-icon-mobile-phone"></i></div>
        <div class="right">
          <i>线上报修</i>
          <p>通过填写一些简单的表单信息，进行故障上报</p>
        </div>
      </div>
    </div>

    <el-dialog
      :visible.sync="dialogVisible"
      width="90%"
      custom-class='menudialog'
      top='15vh'
      >
      <div class="diaa">
        <p class="phonetitle">后勤报修</p>
        <p v-for="p in ax" :key="p.rid">
          {{p.name}}: {{p.phone}}</p>
        <p class="phonetitle">水表、一卡通</p>
        <p v-for="p in bx" :key="p.rid">
          {{p.name}}: {{p.phone}}</p>
        <p class="phonetitle">室内热水</p>
        <p v-for="p in cx" :key="p.rid">
          {{p.name}}: {{p.phone}}</p>
        <p class="phonetitle">空调维修</p>
        <p v-for="p in dx" :key="p.rid">
          {{p.name}}: {{p.phone}}</p>
        <p class="phonetitle">楼道饮水机维修</p>
        <p v-for="p in ex" :key="p.rid">
          {{p.name}}: {{p.phone}}</p>
        <p class="phonetitle">消防</p>
        <p v-for="p in fx" :key="p.rid">
          {{p.name}}: {{p.phone}}</p>
      </div>
    </el-dialog>

    <el-dialog
      :visible.sync="dialogVisible2"
      :fullscreen='true'
      title="填写故障单"
      :show-close='false'
      >
      <div style="height: 30px;"></div>
      <el-form ref="user" :model="user" label-width="100px">
        <el-form-item label="维修类别">
          <el-select v-model="user.sort" placeholder="请选择类别">
            <el-option value="后勤报修"></el-option>
            <el-option value="水表、一卡通"></el-option>
            <el-option value="室内热水"></el-option>
            <el-option value="空调维修"></el-option>
            <el-option value="楼道饮水机维修"></el-option>
            <el-option value="消防"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="故障设备名称" >
          <el-input v-model="user.equ" ></el-input>
        </el-form-item>
        <el-form-item label="地点">
          <el-input v-model="user.addr"></el-input>
        </el-form-item>
        <el-form-item label="预约时间" size="mini">
          <el-col :span="11">
            <el-date-picker type="date" placeholder="选择日期" v-model="user.date1" style="width: 150%;" disabled></el-date-picker>
          </el-col>
          <el-col class="line" :span="2"></el-col>
          <el-col :span="11">
            <el-time-picker placeholder="选择时间" v-model="user.date2" style="width: 100%;" disabled></el-time-picker>
          </el-col>
        </el-form-item>
        <el-form-item label="补充说明">
          <el-input type="textarea" v-model="user.note"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="confirm">立即上报</el-button>
          <el-button @click="handleClose">取消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

  </div>
</template>

<script>
import axios from 'axios'
// axios.defaults.baseURL = 'http://192.168.31.215:5000/'
axios.defaults.baseURL = 'http://fcbyk.com:5000/'
let emptyStr = ''
export default {
    name:'PhoneNewOrder',
    data() {
      return {
        dialogVisible:false,
        dialogVisible2:false,
        user:{
          number: '',
          sort: '',
          equ:  '',
          addr: '',
          note: '',
          date1:'',
          date2:''
        },
        ax:'',
        bx:'',
        cx:'',
        dx:'',
        ex:'',
        fx:''
      }
    },
    mounted(){
          axios.get('/tradition-1').then(res=>{
          this.ax = res.data})
          axios.get('/tradition-2').then(res=>{
          this.bx = res.data})
          axios.get('/tradition-3').then(res=>{
          this.cx = res.data})
          axios.get('/tradition-4').then(res=>{
          this.dx = res.data})
          axios.get('/tradition-5').then(res=>{
          this.ex = res.data})
          axios.get('/tradition-6').then(res=>{
          this.fx = res.data})
    },
    methods:{
      neworder(){
        let a= new Date
        this.user.number='f'+a.getDate()+a.getDay()+a.getHours()
        +parseInt(Math.random()*10000)
        this.dialogVisible2 = true  
      },
      handleClose() {
        this.$confirm('确认关闭？',{
          customClass:'message'
        })
          .then(() => {
            this.dialogVisible2 = false
            this.user.number = emptyStr
            this.user.sort = emptyStr
            this.user.equ = emptyStr
            this.user.addr = emptyStr
            this.user.note = emptyStr
          })
          .catch(() => {});
      },
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
      confirm(){
        if(this.user.sort== emptyStr){
          this.$message.error({
            message:"请选择维修类别",
            duration:1500,
            showClose: true,
          })
          return 0
        }
        if(this.user.equ== emptyStr){
          this.$message.error({
            message:"请填写故障设备名称",
            duration:1500,
            showClose: true,
          })
          return 0
        }
        if(this.user.addr== emptyStr){
          this.$message.error({
            message:"请填写维修地点",
            duration:1500,
            showClose: true,
          })
          return 0
        }
        axios({
            method: 'POST',
            url:'/neworder',
            params: {
              number: this.user.number,
              sort: this.user.sort,
              equ:  this.user.equ,
              addr: this.user.addr,
              note: this.user.note,
              uid: sessionStorage.getItem('id')
            },
        }).then(response => {
            if(response.data=='successful'){
                this.dialogVisible2 = false
                this.$message.success({
                  message:"故障单已成功生成",
                  duration:1500,
                  showClose: true,
                })
                this.getpush()
                this.user.number = emptyStr
                this.user.sort = emptyStr
                this.user.equ = emptyStr
                this.user.addr = emptyStr
                this.user.note = emptyStr
            }
            if(response.data=='err'){
                this.$message.error({
                  message:"添加失败,请重试",
                  duration:1500,
                  showClose: true,
                })
            }},()=>{
                this.$message.error({
                  message:"数据库连接失败",
                  duration:1500,
                  showClose: true,
                })
        })
      }
    }
}
</script>

<style scoped>
.newtop{
  margin-top: 80px;
  /* background-color: aqua; */
  text-align: center;
}
.new-title{
  color: #303133;
  font-size: 25px;
  font-weight: 700;
}
.new-title + p{
  color: #606266;
  margin-top: 10px;
}
.newbot{
  /* background-color: aquamarine; */
  height: 300px;
  display: flex;
  justify-content: center;
  flex-direction: column;
  padding: 10px;
  margin-top: 30px;
}
.box1,.box2{
  /* background-color: rgb(208, 208, 208); */
  border: 2px rgb(255, 255, 255) solid;
  box-shadow: 0 2px 4px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
  flex: 1;
  margin-top: 20px;
  border-radius: 10px;
  padding: 10px;
  display: flex;
}
.box1 .left,.box2 .left{
  font-size: 50px;
  /* background-color: aqua; */
  flex: 1;
  display: flex;
  justify-content: center;
  flex-direction: column;
  text-align: center;
  color: #303133;
}
.box1 .right,.box2 .right{
  font-size: 25px;
  /* background-color: rgb(146, 146, 146); */
  flex: 1.8;
  padding: 20px 10px;
  color: #1c1c1c;
}
.box1 .right p,.box2 .right p{
  font-size: 12px;
  margin-top: 10px;
  color: #606266;
}
.box1:hover,.box2:hover{
  border: 2px hsla(210, 83%, 49%, 0.202) solid;
}
.diaa{
  /* background-color: bisque; */
  border-radius: 10px;
  height: 350px;
  display: flex;
  align-items: center;
  flex-direction: column;
  font-size: 15px;
}
.phonetitle{
  margin: 20px 0px 3px 0px;
  font-weight: 700;
}
</style>