<template>
  <div class="new">
    <div class="newtop">
      <p class="new-title">欢迎使用热海大报修系统</p>
      <p>请选择您的报修方式</p>
    </div>
    <div class="newbot">
      <div class="box1">
        <div class="left"><i class="el-icon-phone-outline"></i></div>
        <div class="right">
          <i>传统报修</i>
          <p>通过传统电话方式进行报修，本系统会为您提供维修电话</p>
        </div>
      </div>
      <div class="box2">
        <div class="left"><i class="el-icon-mobile-phone"></i></div>
        <div class="right">
          <i>线上报修</i>
          <p>通过填写一些简单的表单信息，进行故障上报</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
    name:'PhoneNewOrder',
}
</script>

<style scoped>
.newtop{
  margin-top: 80px;
  /* background-color: aqua; */
  text-align: center;
}
.new-title{
  color: #303133;
  font-size: 25px;
  font-weight: 700;
}
.new-title + p{
  color: #606266;
  margin-top: 10px;
}
.newbot{
  /* background-color: aquamarine; */
  height: 300px;
  display: flex;
  justify-content: center;
  flex-direction: column;
  padding: 10px;
  margin-top: 30px;
}
.box1,.box2{
  /* background-color: rgb(208, 208, 208); */
  border: 2px rgb(255, 255, 255) solid;
  box-shadow: 0 2px 4px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
  flex: 1;
  margin-top: 20px;
  border-radius: 10px;
  padding: 10px;
  display: flex;
}
.box1 .left,.box2 .left{
  font-size: 50px;
  /* background-color: aqua; */
  flex: 1;
  display: flex;
  justify-content: center;
  flex-direction: column;
  text-align: center;
  color: #303133;
}
.box1 .right,.box2 .right{
  font-size: 25px;
  /* background-color: rgb(146, 146, 146); */
  flex: 1.8;
  padding: 20px 10px;
  color: #1c1c1c;
}
.box1 .right p,.box2 .right p{
  font-size: 12px;
  margin-top: 10px;
  color: #606266;
}
.box1:hover,.box2:hover{
  border: 2px hsla(210, 83%, 49%, 0.202) solid;
}
</style>