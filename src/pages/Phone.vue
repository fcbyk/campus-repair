<template>
  <div class="overall">
    <div class="tip">
      <h2>很抱歉，该系统还未适配pc端</h2>
      <p>请把浏览器宽度减小到800px以下</p>
      <p>以触发CSS渲染画面</p>
    </div>
    <div class="content">
        <router-view></router-view>
    </div>
    <div class="nav">
        <input type="radio" name="tab" id="home" checked  @click="tonew('/phone/new-order')">
        <input type="radio" name="tab" id="comment">
        <input type="radio" name="tab" id="envelope">
        <input type="radio" name="tab" id="heart">
        <input type="radio" name="tab" id="user">
        <label for="home" class="home">
          <div class="icc"><i class="el-icon-edit"></i></div>
          <p>故障上报</p>
        </label>
        <label for="comment" class="comment" @click="tonew('/phone/order-management')">
          <div class="icc"><i class="el-icon-document"></i></div>
          <p slot="title">故障单</p>
        </label>
        <label for="envelope" class="envelope" @click="tonew('/phone/search')">
          <div class="icc"><i class="el-icon-search"></i></div>
          <p>信息查询</p>
        </label>
        <label for="heart" class="heart" @click="tonew('/phone/manage-account')">
          <div class="icc"><i class="el-icon-user"></i></div>
          <p>账号管理</p>
        </label>
        <div class="tab"></div>
    </div>
  </div>
</template>

<script>
import router from '@/router';
export default {
    name:'Phone',
    data() {
      return {
        to:'',
      }
    },
    methods:{
      tonew(x){
        if(x==this.to) return 0
        this.to=x
        router.replace(x)
      }
    }
}
</script>

<style scoped>
.content,.nav{
  display: none;
}
.tip{
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  height: 100vh;
}
.tip p{
  margin-top: 10px;
}

@media screen and (max-width:800px){
.tip{
  display: none;
}
.content,.nav{
  display: initial;
}
.overall{
    display: flex;
    flex-direction: column;
    flex: auto;
    background-color: rgb(250, 250, 250);
}
.content{
    height: 84vh;
    background-color:burlywood;
    border-radius: 10px;
    margin: 10px;
    margin-top: 2vh;
    margin-bottom: 2vh;
    background-color: rgb(255, 255, 255);
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    overflow:auto;
}
.nav{
    height: 10vh;
    background-color: aquamarine;
    border-radius: 10px;
    margin: 10px;
    margin-top: 0px;
    margin-bottom: 2vh;
    display: flex;
    position: relative;
    background-color: rgb(255, 255, 255);
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
    overflow:hidden;
}
.nav label{
    flex:1;
    width:100%;
    position: relative;
    z-index: 1;
    display: flex;
    justify-content: center;
    align-content: center;
    flex-direction: column;
    padding: 10px;
    color: #333;
}
.nav label p{
    position: relative;
    z-index: -1;
    color: #333;
    font-size: 10px;
    font-weight: 500;
    text-decoration: none;
    text-align: center;
}
.nav input{
    display: none;
}
.nav .tab{
    position: absolute;
    height: 100%;
    width: 25%;
    left: 0px;
    bottom: 0px;
    /* 渐变背景 自左向右 */
    /* background: linear-gradient(to right, #f09819, #ff5858); */
    background-color: #409EFF;
    border-radius: 10px;
    /* 添加动画过渡 贝塞尔曲线 */
    transition: 0.6s cubic-bezier(0.68,-0.2,0.265,1.2);
}
.nav #home:checked ~ label.home p,
.nav #comment:checked ~ label.comment p,
.nav #envelope:checked ~ label.envelope p,
.nav #heart:checked ~ label.heart p,
.nav #user:checked ~ label.user p,
.nav #home:checked ~ label.home .icc,
.nav #comment:checked ~ label.comment .icc,
.nav #envelope:checked ~ label.envelope .icc,
.nav #heart:checked ~ label.heart .icc,
.nav #user:checked ~ label.user .icc{ 
    color: rgb(239, 239, 239);
    /* 这里字体颜色改变也需要加个动画过渡 */
    transition-delay: 0.2s;
    transition-duration: 0.2s;
}
.nav #comment:checked ~ .tab{
    left: 25%;
}
.nav #envelope:checked ~ .tab{
    left: 50%;
}
.nav #heart:checked ~ .tab{
    left: 75%;
}
.nav #user:checked ~ .tab{
    left: 100%;
}
.icc{
  font-size: 30px;
  text-align: center;
}
}
</style>