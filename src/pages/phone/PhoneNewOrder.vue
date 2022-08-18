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
      <div class="box2" @click="dialogVisible2 = true">
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
        <p>本系统所有维修师傅的电话</p>
      </div>
    </el-dialog>

    <el-dialog
      :visible.sync="dialogVisible2"
      :fullscreen='true'
      title="填写故障单"
      :show-close='false'
      >
      <el-form ref="user" :model="user" label-width="100px">
        <el-form-item label="维修类别">
          <el-select v-model="user.sort" placeholder="请选择类别">
            <el-option label="后勤报修" value="1"></el-option>
            <el-option label="水表、一卡通" value="2"></el-option>
            <el-option label="室内热水" value="3"></el-option>
            <el-option label="空调维修" value="4"></el-option>
            <el-option label="楼道饮水机维修" value="5"></el-option>
            <el-option label="消防" value="6"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="故障设备名称" >
          <el-input v-model="id" ></el-input>
        </el-form-item>
        <el-form-item label="地点">
          <el-input v-model="user.name"></el-input>
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
          <el-input type="textarea" v-model="user.addr"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="confirm">立即上报</el-button>
          <el-button @click="dialogVisible2 = false">取消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

  </div>
</template>

<script>
export default {
    name:'PhoneNewOrder',
    data() {
      return {
        dialogVisible:false,
        dialogVisible2:false,
        user:{
          name: '',
          gender:  '',
          phone:  '',
          addr: '',
          sort:  ''
        },
      }
      
    },
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
}
</style>