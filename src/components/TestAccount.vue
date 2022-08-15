<template>
  <span>
    <a @click="drawer = true" @mouseup="pwDrawer">测试账号</a>
    <el-drawer
      title="已注册账号"
      :visible.sync="drawer"
      direction="ltr"
      :before-close="handleClose"
      :size="cwidth">
      <div v-for="p in ax" :key="p.id" class="list">
        <p>账号:{{p.id}}</p>
        <p>密码:{{p.pw}}</p>
      </div>
    </el-drawer>
  </span>
</template>

<script>
import axios from 'axios'
axios.defaults.baseURL = 'http://127.0.0.1:5000/'
// axios.defaults.baseURL = 'http://fcbyk.com:5000/'
let width=window.innerWidth
export default {
    name:'TestAccount',
    props:['cwidth'],
    data() {
        return {
            drawer: false,
            ax: '内容为空',
            lwidth: '30%',
            width1: width
        }
    },
    methods:{
        handleClose(done) {
        this.$confirm('确认关闭？')
            .then( () => {
                done();
            }).catch( () => {});
        },
        pwDrawer(){
            axios.get('/').then(res=>{
                this.ax = res.data
        })}
    }
}
</script>

<style scoped>
.list{
  margin: 20px;
  border: #a9a9a9 solid 1px;
  padding: 10px;
  border-radius: 10px;
}
p{
  margin: 10px;
}
</style>