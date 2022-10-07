<template>
  <div class="new">
    <div class="newtop">
      <p class="new-title">欢迎使用热海大报修系统</p>
      <p>天气炎热，记得多喝水噢</p>
    </div>
    <div class="newbot">
      <div class="box1" @click="getsquare">
        <div class="left"><i class="el-icon-circle-plus"></i></div>
        <div class="right">
          <i>接单</i>
          <p>系统会为您推送与您维修类别相匹配的故障单</p>
        </div>
      </div>
      <div class="box2" @click="dialogVisible2 = true">
        <div class="left"><i class="el-icon-s-order"></i></div>
        <div class="right">
          <i>工作单</i>
          <p>您需要去完成的故障单</p>
        </div>
      </div>
    </div>

    <el-dialog
      :visible.sync="dialogVisible"
      :fullscreen='true'
      title="系统为您推送的故障单"
      >
      <SquareTable></SquareTable>
    </el-dialog>

    <el-dialog
      :visible.sync="dialogVisible2"
      :fullscreen='true'
      title="待完成的故障单"
      >
      <ToDoListTable></ToDoListTable>
    </el-dialog>

  </div>
</template>

<script>
import axios from 'axios'
// axios.defaults.baseURL = 'http://192.168.31.215:5000/'
axios.defaults.baseURL = 'http://ali.fcbyk.com:5000/'
// let emptyStr = ''
import SquareTable from '../tables/SquareTable'
import ToDoListTable from '../tables/ToDoListTable'

export default {
    name:'PhoneWork',
    components:{ SquareTable ,ToDoListTable },
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
        window.setTimeout(()=>{
          axios({
                method: 'POST',
                url:'/getsquare',
                params: {
                    category: sessionStorage.getItem('category'),
                },
            }).then(response => {
              sessionStorage.setItem('square',JSON.stringify(response.data))
            },()=>{})

          axios({
                method: 'POST',
                url:'/gettodolist',
                params: {
                    rid: sessionStorage.getItem('id'),
                },
            }).then(response => {
              sessionStorage.setItem('todolist',JSON.stringify(response.data))
            },()=>{})

          axios({
                method: 'POST',
                url:'/getcompleted',
                params: {
                    rid: sessionStorage.getItem('id'),
                },
            }).then(response => {
              sessionStorage.setItem('completed',JSON.stringify(response.data))
            },()=>{})
        },200)
    },
    methods:{
      getsquare(){

        // axios({
        //       method: 'POST',
        //       url:'/getsquare',
        //       params: {
        //           category: sessionStorage.getItem('category'),
        //       },
        //   }).then(response => {
        //     sessionStorage.setItem('square',JSON.stringify(response.data))
        //   },()=>{})

          this.dialogVisible = true

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