<template>
  <div class="new">
    <!-- <el-steps :active="active" finish-status="success">
      <el-step title="维修类别"></el-step>
      <el-step title="步骤 2"></el-step>
      <el-step title="步骤 3"></el-step>
      <el-step title="步骤 4"></el-step>
      <el-step title="步骤 5"></el-step>
    </el-steps> -->
    <!-- <div class="fromm"> -->
      <h1>故障上报</h1>
      <el-form ref="form" :model="form" label-width="120px">
        <el-form-item label="确定维修类别">
          <el-radio-group v-model="form.resource">
            <el-radio label="后勤报修"></el-radio>
            <el-radio label="水表、一卡通"></el-radio>
            <el-radio label="室内热水"></el-radio>
            <el-radio label="空调维修"></el-radio>
            <el-radio label="楼道饮水机维修"></el-radio>
            <el-radio label="消防"></el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="故障设备名称">
          <el-input v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item label="地点">
          <el-input v-model="form.addr"></el-input>
        </el-form-item>
        <el-form-item label="预约维修时间">
          <el-col :span="11">
            <el-date-picker type="date" placeholder="选择日期" v-model="form.date1" style="width: 100%;"></el-date-picker>
          </el-col>
          <el-col class="line" :span="2"></el-col>
          <el-col :span="11">
            <el-time-picker placeholder="选择时间" v-model="form.date2" style="width: 100%;"></el-time-picker>
          </el-col>
        </el-form-item>
        <el-form-item label="详细说明(留言)">
          <el-input type="textarea" v-model="form.desc"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="onSubmit">提交</el-button>
          <el-button>清空</el-button>
        </el-form-item>
      </el-form>
    <!-- </div> -->
    <!-- <div class="bottw">
      <el-button @click="rnext">上一步</el-button>
      <el-button @click="next">下一步</el-button>
    </div> -->
  </div>
</template>

<script>
export default {
    name:'NewOrder',
    data() {
      return {
        // active: 0,
        form: {
          name: '',
          date1: '',
          date2: '',
          type: [],
          resource: '',
          desc: '' ,
          addr:''
        }
      }
    },
    methods: {
      // next() {
      //   if (this.active++ > 4) this.active = 0;
      // },
      // rnext(){
      //   if (this.active-- < 0) this.active = 4;
      // },
      onSubmit() {
        console.log('submit!');
      }
    }
}
</script>

<style scoped>
.new{
    padding: 45px;
    height: 96.5vh;
    margin: 10px;
    margin-left: 0px;
    border-radius: 10px;
    background-color: rgb(255, 255, 255);
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
.fromm{
  height: 70vh;
  /* margin: 20px; */
}
.bottw{
  display: flex;
  justify-content: end;
  margin-right: 100px;
  /* margin-top: 30px; */
}
h1{
  margin-bottom: 30px;
  margin-left: 30px;
  font-size: 30px;
}
</style>