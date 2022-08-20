<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>

export default {
  name: 'App',
}
</script>

<style>
*{
  margin: 0;
  padding: 0;
}
#app {
  font-family: "Helvetica Neue",Helvetica,"PingFang SC","Hiragino Sans GB","Microsoft YaHei","微软雅黑",Arial,sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.message{
  width: 300px;
}
.el-dialog__body{
  padding-top: 0px;
}
/* .el-dialog__header{
  padding: 0;
} */
.el-popover{
  min-width: 0 !important;
}
.el-card__body{
  padding: 0;
}
.el-card__header{
  padding: 5px;
}
.el-card__header span{
  font-size:13px; 
  margin-left: 10px;
  color: #303133;
}
</style>
