<template>
  <div class="logo">
    <div class="change-icon">
    <i class="el-icon-setting"></i>
    </div>
    <p>热海大报修系统</p>
  </div>
</template>

<script>
export default {
    name:'Logo'
}
</script>

<style scoped>
    .logo{
        display: flex;
        justify-content: center;
        flex-direction: column;
        align-items: center;
    }
    .change-icon{
        font-size:50px;
    }
    p{
      margin: 16px 0px;
    }
</style>