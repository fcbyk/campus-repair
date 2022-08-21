<template>
  <span>
    <a @click="dialogVisible = true">注册账号</a>
    
    <el-dialog
      title="注册账号"
      :visible.sync="dialogVisible"
      :width="cwidth"
      :before-close="cancel">
      <div style="height: 30px;"></div>
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
  </span>
</template>

<script>
import axios from 'axios'
// axios.defaults.baseURL = 'http://192.168.31.215:5000/'
axios.defaults.baseURL = 'http://fcbyk.com:5000/'
let emptyStr = ''
export default {
    name:'RegisterAccount',
    props:['cwidth'],
    data() {
        return {
            dialogVisible: false,
            form:{
                name: emptyStr,
                region: emptyStr,
                zpw1: emptyStr,
                zpw2: emptyStr,
            }
        }
    },
    methods:{
        cancel(){
            this.$confirm('确认关闭？','',{
                customClass:'message'
            })
            .then( () => {
            this.dialogVisible = false
            this.form.name = emptyStr
            this.form.region = emptyStr
            this.form.zpw1 = emptyStr
            this.form.zpw2 = emptyStr
            }).catch( ()=> {});
        },
        onSubmit() { 
            if(this.form.region == emptyStr){
                this.$message.error({
                    message:'请选择你的身份',
                    duration:2000,
                    showClose: true,
                })
                return 0
            }
            if(this.form.name == emptyStr){
                this.$message.error({
                    message:'账号不能为空',
                    duration:2000,
                    showClose: true,
                })
                return 0
            }
            if(this.form.zpw1 == emptyStr){
                this.$message.error({
                    message:'密码不能为空',
                    duration:2000,
                    showClose: true,
                })
                return 0
            }
            if(this.form.zpw1 != this.form.zpw2){
                this.$message.error({
                    message:'两次输入的密码不一致',
                    duration:2000,
                    showClose: true,
                })
                return 0
            }
            if(this.form.region=='student' && this.form.name[0]!='s'){
                this.$message.error({
                    message:'学生账号必须以s开头',
                    duration:2000,
                    showClose: true,
                })
                return 0
            }
            if(this.form.region=='staff' && this.form.name[0]!='t'){
                this.$message.error({
                    message:'教职工账号必须以t开头',
                    duration:2000,
                    showClose: true,
                })
                return 0
            }
            if(this.form.region=='repairMan' && this.form.name[0]!='r'){
                this.$message.error({
                    message:'维修师傅账号必须以r开头',
                    duration:1000,
                    showClose: true,
                })
                return 0
            }

            axios({
                method: 'POST',
                url:'/register',
                params: {
                    id: this.form.name,
                    pw: this.form.zpw2,
                    sort: this.form.region
                },
            }).then(response => {
                if(response.data=='successful'){
                    this.$notify({
                        title: '注册成功',
                        message: '请记住你的账号密码',
                        type: 'success',
                        duration:2000
                    });
                    this.dialogVisible = false
                    this.form.name = emptyStr
                    this.form.region = emptyStr
                    this.form.zpw1 = emptyStr
                    this.form.zpw2 = emptyStr
                }
                if(response.data=='err'){
                    this.$notify.error({
                        title: '注册失败',
                        message: '已存在该账号',
                        duration:2000
                    });
                }},()=>{
                    this.$notify.error({
                        title: '注册失败',
                        message: '已存在该账号',
                        duration:2000
                    });
            })
        },
    }
}
</script>

<style>
</style>