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
        <input type="radio" name="tab" id="home" checked>
        <input type="radio" name="tab" id="comment">
        <input type="radio" name="tab" id="heart">
        <label for="home" class="home" @click="tonew('neworder')">
          <div class="icc"><i :class="nav1icon"></i></div>
          <p>{{nav1}}</p>
        </label>
        <label for="comment" class="comment" @click="tonew('ordermanagement')">
          <div class="icc"><i :class="nav2icon"></i></div>
          <p slot="title">{{nav2}}</p>
        </label>
        <label for="heart" class="heart" @click="tonew('manageaccount')">
          <div class="icc"><i :class="nav3icon"></i></div>
          <p>{{nav3}}</p>
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
        nav1:'故障上报',
        nav2:'故障单',
        nav3:'账号管理',
        nav1icon:'el-icon-edit',
        nav2icon:'el-icon-document',
        nav3icon:'el-icon-user',
        // thisurl:location.href
      }
    },
    mounted() {
      if (sessionStorage.getItem('id')[0]=='r') {
        this.nav1 = '工作'
        this.nav2 = '已完成'
        this.nav3 = '账号'
        this.nav1icon = 'el-icon-s-cooperation'
        this.nav2icon = 'el-icon-s-claim'
        this.nav3icon = 'el-icon-s-custom'
      }
      // console.log(this.thisurl)
    },
    methods:{
      tonew(x){
        if(x==this.to) return 0
        this.to=x
        if(x=='neworder' && sessionStorage.getItem('id')[0]=='r'){
          router.replace({name:'work'})
          return 0
        }
        router.replace({name:x})
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
    /* background-color: aquamarine; */
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
    width: 33.333333333%;
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
.nav #heart:checked ~ label.heart p,
.nav #home:checked ~ label.home .icc,
.nav #comment:checked ~ label.comment .icc,
.nav #heart:checked ~ label.heart .icc{ 
    color: rgb(239, 239, 239);
    /* 这里字体颜色改变也需要加个动画过渡 */
    transition-delay: 0.2s;
    transition-duration: 0.2s;
}
.nav #comment:checked ~ .tab{
    left: 33.333333333%;
}
.nav #heart:checked ~ .tab{
    left: 66.666666666%;
}
.icc{
  font-size: 30px;
  text-align: center;
}
}
</style>