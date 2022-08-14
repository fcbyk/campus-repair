<template>
  <div class='user'>
    <p>用户头像</p>
    <p>名字</p>
  </div>
</template>

<script>
export default {
    name:'Userpic'
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
</style>