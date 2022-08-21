<template>
    <div class="squaretables">
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
            label="故障设备">
            <template slot-scope="scope">
                <span>{{ scope.row.f_equ }}</span>
            </template>
            </el-table-column>

            <el-table-column
            label="地点">
            <template slot-scope="scope">
                <el-popover placement="top">
                <el-button
                size="mini"
                @click="handleShow(scope.$index, scope.row)"
                type="info"
                >详细</el-button>
                <el-button
                size="mini"
                @click="handleAdd(scope.$index, scope.row)" type="primary">接单</el-button>
                <div slot="reference" class="name-wrapper">
                    <span>{{ scope.row.place }}</span>
                </div>
                </el-popover>
            </template>
            </el-table-column>
        </el-table>
        <div class="refresh"><el-button size="medium" @click="refresh">刷新</el-button></div>

      <el-dialog
      :visible.sync="dialogVisible"
      width="70%"
      :show-close='false'
      custom-class='menudialog'
      top='20vh'
      append-to-body
      >
      <div>
        <p>故障单号： {{showData.rnumber}}</p>
        <p>维修类别： {{showData.rsort}}</p>
        <p>故障设备： {{showData.f_equ}}</p>
        <p>故障单发起人： {{showData.init_id}}</p>
        <p>维修地点： {{showData.place}}</p>
        <p>预约维修时间：{{showData.rtime}}</p>
        <p>维修备注：{{showData.note}}</p>
        <p>故障单状态：
          <el-tag size="mini" effect="dark">
            {{showData.order_state}}</el-tag>
        </p>
      </div>
    </el-dialog>

    </div>
</template>

<script>
import axios from 'axios'
// axios.defaults.baseURL = 'http://192.168.31.215:5000/'
axios.defaults.baseURL = 'http://fcbyk.com:5000/'
export default {
    name:'SquareTable',
    data() {
        return {
            tableData: [],
            dialogVisible: false,
            showData:[]
        }
    },
    mounted(){
      this.tableData = JSON.parse(sessionStorage.getItem('square'))
    },
    methods: {
      handleShow(index, row) {
        this.showData = row
        this.dialogVisible = true
      },
      handleAdd(index, row){
        axios({
              method: 'POST',
              url:'/order-receiving',
              params: {
                  rnumber: row.rnumber,
                  rid: sessionStorage.getItem('id')
              },
          }).then(() => {

            axios({
                  method: 'POST',
                  url:'/getsquare',
                  params: {
                      category: sessionStorage.getItem('category'),
                  },
              }).then(response => {
                sessionStorage.setItem('square',JSON.stringify(response.data))
                this.tableData = JSON.parse(sessionStorage.getItem('square'))
                },()=>{})
                this.$message.success({
                  showClose:true,
                  message:'成功接单',
                  duration:1500
                })
          },()=>{
            this.$message.error({
              message:'数据库连接失败',
              duration:1500,
              showClose:true,    
            })
          })
      },
      refresh(){
        axios({
              method: 'POST',
              url:'/getsquare',
              params: {
                  category: sessionStorage.getItem('category'),
              },
          }).then(response => {
            sessionStorage.setItem('square',JSON.stringify(response.data))
            this.tableData = JSON.parse(sessionStorage.getItem('square'))
            this.$message.success({
              showClose:true,
              message:'刷新成功',
              duration:1000
            })
          },()=>{
            this.$message.error({
              message:'数据库连接失败',
              duration:1500,
              showClose:true,    
            })
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
.squaretables{
    padding: 5px 0px;
}
p{
  margin-top: 5px;
}
</style>