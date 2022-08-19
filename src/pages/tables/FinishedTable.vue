<template>
    <div class="finishedtables">
        <el-table
            :data="tableData"
            style="width: 100%"
            size="medium"
            >
            <el-table-column
            label="故障单号">
            <template slot-scope="scope">
                <span>{{ scope.row.rnumber }}</span>
            </template>
            </el-table-column>

            <el-table-column
            label="维修类别">
            <template slot-scope="scope">
                <span>{{ scope.row.rsort }}</span>
            </template>
            </el-table-column>

            <el-table-column
            label="故障设备">
            <template slot-scope="scope">
                <el-popover placement="top">
                <el-button
                size="mini"
                @click="handleEdit(scope.$index, scope.row)"
                type="primary"
                >详细</el-button>
                <el-button
                size="mini"
                @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                <el-button
                size="mini"
                type="danger"
                @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                <div slot="reference" class="name-wrapper">
                    <span>{{ scope.row.f_equ }}</span>
                </div>
                </el-popover>
            </template>
            </el-table-column>
        </el-table>
        <div class="refresh"><el-button size="medium" @click="refresh">刷新</el-button></div>
    </div>
</template>

<script>
import axios from 'axios'
axios.defaults.baseURL = 'http://192.168.31.215:5000/'
// axios.defaults.baseURL = 'http://fcbyk.com:5000/'
export default {
    name:'FinishedTable',
    data() {
        return {
            tableData: []
        }
    },
    mounted(){
      this.tableData = JSON.parse(sessionStorage.getItem('finished'))
    },
    methods: {
      handleEdit(index, row) {
        console.log(index, row);
      },
      handleDelete(index, row) {
        console.log(index, row);
        this.$confirm("确定删除吗",{ 
          customClass:'message'
        }).then(()=>{
          this.deletethis(row.rnumber)
          this.tableData.splice(index,1)
          sessionStorage.setItem('finished',JSON.stringify(this.tableData))
        },()=>{})
      },
      refresh(){
        this.$message.success({
          showClose:true,
          message:'刷新成功'
        })
        axios({
              method: 'POST',
              url:'/getfinished',
              params: {
                  id: sessionStorage.getItem('id'),
              },
          }).then(response => {
            sessionStorage.setItem('finished',JSON.stringify(response.data))
            this.tableData = JSON.parse(sessionStorage.getItem('finished'))
          },()=>{
            this.$message.error('数据库连接失败')
          })
      },
      deletethis(x){
        axios({
              method: 'POST',
              url:'/deletethis',
              params: {
                  number: x,
              },
          }).then(response => {
            if(response.data == 'successful'){
              this.$message.success('删除成功')
            }
          },()=>{
            this.$message.error('数据库连接失败')
          })
      },
    }
}
</script>

<style scoped>
.refresh{
  margin: 10px 30px 0px 0px;
  text-align: end;
}
.finishedtables{
    padding: 5px 15px;
}
</style>