<template>
  <el-container>
    <el-aside width="auto" class="aside">
      <Userpic></Userpic>
      <MenuBar></MenuBar>
    </el-aside>
    <el-main class="main">
        <router-view></router-view>
    </el-main>
  </el-container>
</template>

<script>
import Userpic from '../components/Userpic'
import MenuBar from '../components/MenuBar'
export default {
    name:'Home',
    components:{ Userpic,MenuBar },
}
</script>

<style scoped>
  *{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
  .aside,.main{
    background-color: aquamarine;
    height: 100vh;
  }
</style>