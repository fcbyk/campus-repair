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
      @open="beforelogin"
      append-to-body
      >
      <div>
        <p>故障单号： {{showData.rnumber}}</p>
        <p>维修类别： {{showData.rsort}}</p>
        <p>故障设备： {{showData.f_equ}}</p>

            <el-popover 
            placement="top"
            title="故障单发起人信息"
            width="300"
            trigger="click"
            >
              <p>名字：{{user.name}}</p>
              <p>电话：{{user.phone}}</p>
              <p>默认地址：{{user.addr}}</p>
            <div slot="reference" class="name-wrapper">
                <p>故障单发起人： {{showData.init_id}}</p>
            </div>
            </el-popover>

        <p>维修地点： {{showData.place}}</p>
        <p>维修备注：{{showData.note}}</p>
        <p>创建时间：{{date(showData.creation_time)}}</p>
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
axios.defaults.baseURL = 'http://ali.fcbyk.com:5000/'
export default {
    name:'SquareTable',
    data() {
        return {
            tableData: [],
            dialogVisible: false,
            showData:[],
            user:{
              name: '',
              phone:  '',
              addr: '',
            },
        }
    },
    mounted(){
      this.tableData = JSON.parse(sessionStorage.getItem('square'))
    },
    methods: {
      beforelogin() {
            axios({
                method: 'POST',
                url:'/user',
                params: {
                    id: this.showData.init_id,
                },
            }).then(response => {
              this.user.name = response.data[0].user_name
              this.user.phone = response.data[0].user_phone
              this.user.addr = response.data[0].user_addr
            }) 
      },
      date(x){
        let a = new Date(x)
        let b = a.toLocaleTimeString('chinese',{hour12:false})
        let c = a.toLocaleDateString()
        return c + ' ' + b
      },
      handleShow(index, row) {
        this.showData = row
        this.dialogVisible = true
      },
      handleAdd(index, row){

        this.$confirm('确认接单吗',{
          customClass:'message'
        }).then(() => {

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

          })
          .catch(() => {});
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