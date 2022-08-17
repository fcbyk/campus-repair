<template>
  <div class="login">
     {{WidthControl()}}
    <Logo></Logo>
    <LoginForm></LoginForm>

    <div class="bott">
      <RegisterAccount :cwidth='bwidth'></RegisterAccount>
      <TestAccount :cwidth='bwidth'></TestAccount>
      <a href="https://www.yuque.com/docs/share/7e6c1b5d-5487-4c0f-8384-1ea451914d51?# 《课程设计报告》" target="blank">课程设计报告</a>
      <a href="https://element.eleme.cn/#/zh-CN" target="blank">Element UI</a>
    </div>

  </div>
</template>

<script>
import Logo from '../components/Logo'
import LoginForm from '../components/LoginForm'
import TestAccount from '../components/TestAccount'
import RegisterAccount from '../components/RegisterAccount'

let width=window.innerWidth

export default {
    name:'Login',
    components:{Logo,LoginForm,TestAccount,RegisterAccount},
    data() {
    return {
      awidth: width,
      bwidth:'30%'
    }
  },
  methods: {
    WidthControl(){
      console.log(this.awidth)
      if(this.awidth <= 900){
        this.bwidth = '90%'
      }else{
        this.bwidth = '30%'
      }
    },
  }
}
</script>

<style>
.login{
    display: flex;
    justify-content: center;
    flex-direction: column;
    align-items: center;
    margin-top: 60px;
}
.bott{
  margin-top: 100px;
}
.bott a{
  text-decoration: none;
  margin-left: 10px;
  margin-right: 10px;
  color: #6f6f6f;
  font-size: 15px;
}
.bott a:hover{
  color: rgb(55, 55, 55);
  text-decoration-line: underline;
}
</style>