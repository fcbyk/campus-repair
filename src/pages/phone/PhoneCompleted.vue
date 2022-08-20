<template>
  <div class="new">
    <!-- <el-empty description="熬夜开发中"></el-empty> -->
    <el-tabs v-model="activeName" type="border-card">
      <el-tab-pane label="历史" name="completed_table"></el-tab-pane>
      <el-tab-pane label="数据统计" name="echarts"></el-tab-pane>
    </el-tabs>
    <router-view></router-view>
  </div>
</template>

<script>
import router from '@/router';
export default {
    name:'PhoneCompleted',
    data() {
      return {
        activeName: 'completed_table'
      }
    },
    watch:{
      activeName:{
        immediate:true,
        handler(newValue){
          router.replace({name: newValue })
        }
      }
    }
}
</script>

<style scoped>

</style>