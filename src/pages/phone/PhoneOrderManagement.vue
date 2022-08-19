<template>
  <div class="ordermanage">
    <el-tabs v-model="activeName" type="border-card">
      <el-tab-pane label="推送中" name="push"></el-tab-pane>
      <el-tab-pane label="已接单" name="receiving"></el-tab-pane>
      <el-tab-pane label="已完成" name="finished"></el-tab-pane>
    </el-tabs>
    <router-view></router-view>
  </div>
</template>

<script>
import router from '@/router'
export default {
    name:'PhoneOrderManagement',
    data() {
      return {
        activeName: 'push'
      }
    },
    watch:{
      activeName:{
        immediate:true,
        handler(newValue){
          router.replace({name: newValue })
        }
      }
    }
}
</script>

<style>
.el-tab-pane{
  padding: 0px;
}
.el-tabs--border-card{
  box-shadow: none;
  border: none;
}
.el-tabs__content{
  padding: 0 !important; 
}
</style>