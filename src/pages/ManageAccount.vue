<template>
  <div class="manage">
    <div class="ma-top">
      <div class="ma-topone">
        <el-avatar :src="circleUrl" :size="150"></el-avatar>
        
      </div>
      <div class="ma-toptwo">
        <el-form ref="form" :model="sizeForm" label-width="40px" size="mini">
          <el-form-item label="名字">
            <el-input size="mini" v-model="sizeForm.name" :disabled="state"></el-input>
          </el-form-item>
          <el-form-item label="id">
            {{name}}
          </el-form-item>
        </el-form>
      </div>
    </div>

    <div class="ma-bott">
      <el-form ref="form" :model="sizeForm" label-width="80px" size="medium">
        <el-form-item label="性别">
          <el-radio-group v-model="sizeForm.resource" size="medium">
            <el-radio border label="男" :disabled="state"></el-radio>
            <el-radio border label="女" :disabled="state"></el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="联系电话" style="width: 300px;">
          <el-input v-model="sizeForm.phone" :disabled="state"></el-input>
        </el-form-item>
        <el-form-item label="默认地址" style="width: 500px;">
          <el-input v-model="sizeForm.addr" :disabled="state"></el-input>
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
export default {
    name:'ManageAccount',
    data() {
      return {
        name:sessionStorage.getItem('id'),
        circleUrl: "https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png",
        sizeForm:{
          name:'蓝忘机',
          region: '',
          date1: '',
          date2: '',
          delivery: false,
          type: [],
          resource: '男',
          desc: '',
          phone: '10086',
          addr:''
        },
        state:true
      }
    },
    methods:{
      alter(){
        this.state = false
      },
      confirm(){
        this.state = true
      }
    }
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