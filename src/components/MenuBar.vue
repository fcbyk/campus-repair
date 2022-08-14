<template>
    <el-menu default-active="1-4-1" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose" :collapse="isCollapse">
    <el-menu-item index="1" @click="tonew('/home/new-order')">
        <i class="el-icon-edit"></i>
        <span slot="title" >故障上报</span>
    </el-menu-item>
    <el-menu-item index="2" @click="tonew('/home/order-management')">
        <i class="el-icon-document"></i>
        <span slot="title">订单管理</span>
    </el-menu-item>
    <el-menu-item index="3" @click="tonew('/home/search')">
        <i class="el-icon-search"></i>
        <span slot="title">信息查询</span>
    </el-menu-item>
    <el-menu-item index="4" @click="tonew('/home/manage-account')">
        <i class="el-icon-user"></i>
        <span slot="title">账号管理</span>
    </el-menu-item>
    <el-menu-item index="5" disabled>
        <i class="el-icon-warning"></i>
        <span slot="title">开发中</span>
    </el-menu-item>
    </el-menu>
</template>

<script>
import router from '@/router';
export default {
    name:'MenuBar',
    data() {
      return {
        isCollapse: false,
      };
    },
    methods: {
      handleOpen(key, keyPath) {
        console.log(key, keyPath);
      },
      handleClose(key, keyPath) {
        console.log(key, keyPath);
      },
      tonew(x){
        router.push(x)
      }
    }
}
</script>

<style scoped>
  .el-menu-vertical-demo{
    height: 60vh;
    margin: 10px;
    border-radius: 10px;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1)
  }
  .el-menu-vertical-demo:not(.el-menu--collapse) {
    width: 250px;
  }
</style>