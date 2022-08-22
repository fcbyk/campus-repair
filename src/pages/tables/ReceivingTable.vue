<template>
    <div class="receivingtables">
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
                type="info"
                >详细</el-button>
                <el-button
                size="mini"
                @click="handleOff(scope.$index, scope.row)"
                type="danger"
                >取消</el-button>
                <div slot="reference" class="name-wrapper">
                    <span>{{ scope.row.f_equ }}</span>
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
      >
      <div>
        <p>故障单号： {{showData.rnumber}}</p>
        <p>维修类别： {{showData.rsort}}</p>
        <p>故障设备： {{showData.f_equ}}</p>
        <p>故障单发起人： {{showData.init_id}}</p>
        <p>维修地点： {{showData.place}}</p>
        <p>维修备注：{{showData.note}}</p>
        <p>创建时间：{{date(showData.creation_time)}}</p>
        <p>接单时间：{{date(showData.order_time)}}</p>

                <el-popover 
                placement="top"
                title="接单师傅信息"
                width="300"
                trigger="click"
                >
                  <p>名字：{{user.name}}</p>
                  <p>电话：{{user.phone}}</p>
                <div slot="reference" class="name-wrapper">
                    <span>接单师傅： {{showData.rid}}</span>
                </div>
                </el-popover>

        <!-- <el-popover
        placement="top-start"
        title="标题"
        width="200"
        trigger="click"
        content="这是一段内容,这是一段内容,这是一段内容,这是一段内容。">
        <p slot="reference">接单师傅： {{showData.rid}}</p>
        <el-button >hover 激活</el-button>
        </el-popover> -->
        
        <p>故障单状态：
          <el-tag size="mini" effect="dark" type="success">
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
    name:'ReceivingTable',
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
      this.tableData = JSON.parse(sessionStorage.getItem('receiving'))
    },
    methods: {
      beforelogin() {
            axios({
                method: 'POST',
                url:'/user',
                params: {
                    id: this.showData.rid,
                },
            }).then(response => {
              this.user.name = response.data[0].user_name
              this.user.phone = response.data[0].user_phone
                // sessionStorage.setItem('addr',response.data[0].user_addr)
            }) 
      },
      date(x){
        let a = new Date(x)
        let b = a.toLocaleTimeString('chinese',{hour12:false})
        let c = a.toLocaleDateString()
        return c + ' ' + b
      },
      handleEdit(index, row) {
        this.dialogVisible = true
        this.showData = row
      },
      refresh(){
        axios({
              method: 'POST',
              url:'/getreceiving',
              params: {
                  id: sessionStorage.getItem('id'),
              },
          }).then(response => {
            sessionStorage.setItem('receiving',JSON.stringify(response.data))
            this.tableData = JSON.parse(sessionStorage.getItem('receiving'))
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
      handleOff(index, row){

        this.$confirm('确认取消吗',{
          customClass:'message'
        }).then(() => {

        axios({
              method: 'POST',
              url:'/order-off',
              params: {
                  rnumber: row.rnumber,
              },
          }).then(() => {

              axios({
                    method: 'POST',
                    url:'/getreceiving',
                    params: {
                        id: sessionStorage.getItem('id'),
                    },
                }).then(response => {
                  sessionStorage.setItem('receiving',JSON.stringify(response.data))
                  this.tableData = JSON.parse(sessionStorage.getItem('receiving'))
                },()=>{})
                this.$message.success({
                  showClose:true,
                  message:'取消成功',
                  duration:1000
                })

          },()=>{
            this.$message.error({
              message:'数据库连接失败',
              duration:1500,
              showClose:true,    
            })
          })}).catch(() => {});

      }
    }
}
</script>

<style scoped>
.refresh{
  margin: 10px 30px 0px 0px;
  text-align: end;
}
.receivingtables{
    padding: 5px 15px;
}
p{
  margin-top: 5px;
}
</style>