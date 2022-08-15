<template>
  <div class='user'>
    <div>
      <el-avatar :src="circleUrl" :size="150"></el-avatar>
    </div>
    <p>{{name}}</p>
  </div>
</template>

<script>
export default {
    name:'Userpic',
    data() {
      return {
        name:sessionStorage.getItem('id'),
        circleUrl: "https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png",
      }
    },
}
</script>

<style scoped>
  .user{
    height: 35vh;
    width: 250px;
    border-radius: 10px;
    margin: 10px;
    background-color: rgb(255, 255, 255);
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
  }
  p{
    font-size: 20px;
    margin-top: 10px;
    font-weight: 550;
  }
</style>