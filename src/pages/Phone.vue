<template>
  <div class="overall">
    <div class="content"></div>
    <div class="nav">
    </div>
  </div>
</template>

<script>
export default {
    name:'Phone'
}
</script>

<style scoped>

@media screen and (max-width:800px){
.overall{
    display: flex;
    flex-direction: column;
    flex: auto;
}
.nav{
    height: 10vh;
    /* width: 100%; */
    background-color: aquamarine;
    border-radius: 10px;
    margin: 10px;
    margin-top: 0px;
    margin-bottom: 2vh;
}
.content{
    height: 85vh;
    /* width: 100%; */
    background-color:burlywood;
    border-radius: 10px;
    margin: 10px;
    margin-top: 1vh;
    margin-bottom: 2vh;
}
}
</style>