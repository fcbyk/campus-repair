<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
// import router from './router'
// import Login from './pages/Login'

export default {
  name: 'App',
  // components: {Login}
  // mounted(){
  //   // console.log('app组件创建成功'+Math.random())
  //   // 刷新一次创建一次
  //   // router.replace('/login')
  // }
}
</script>

<style>
*{
  margin: 0;
  padding: 0;
  /* box-sizing: border-box; */
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
</style>
