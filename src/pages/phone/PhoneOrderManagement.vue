<template>
  <div class="ordermanage">
    <el-tabs v-model="activeName" type="border-card">
      <el-tab-pane label="推送中" name="first">
        <el-table
          :data="tableData1"
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
      </el-tab-pane>

      <el-tab-pane label="已接单" name="second">
        <el-table
          :data="tableData2"
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
      </el-tab-pane>

      <el-tab-pane label="已完成" name="third">
        <el-table
          :data="tableData3"
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
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import axios from 'axios'
axios.defaults.baseURL = 'http://192.168.31.215:5000/'
// axios.defaults.baseURL = 'http://fcbyk.com:5000/'
export default {
    name:'PhoneOrderManagement',
    data() {
      return {
        activeName: 'first',
        tableData1: [],
        tableData2: [],
        tableData3: []
      }
    },
    mounted(){
      this.tableData1 = JSON.parse(sessionStorage.getItem('push'))
      this.tableData2 = JSON.parse(sessionStorage.getItem('receiving'))
      this.tableData3 = JSON.parse(sessionStorage.getItem('finished'))
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
          this.tableData1.splice(index,1)
          sessionStorage.setItem('push',JSON.stringify(this.tableData1))
        },()=>{})
      },
      refresh(){
        this.$message.success({
          showClose:true,
          message:'刷新成功'
        })
        axios({
              method: 'POST',
              url:'/getpush',
              params: {
                  id: sessionStorage.getItem('id'),
              },
          }).then(response => {
            sessionStorage.setItem('push',JSON.stringify(response.data))
            this.tableData1 = JSON.parse(sessionStorage.getItem('push'))
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
</style>

<style>
.el-tab-pane{
  padding: 0px;
}
.el-tabs--border-card{
  box-shadow: none;
  border: none;
}
.refresh{
  margin: 10px 30px 0px 0px;
  text-align: end;
}
</style>