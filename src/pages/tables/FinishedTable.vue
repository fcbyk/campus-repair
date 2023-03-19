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
                type="info"
                >详细</el-button>
                <el-button
                size="mini"
                @click="star"
                type="primary"
                >评价</el-button>
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
        <p>完成时间：{{date(showData.finish_time)}}</p>

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

        <p>故障单状态：
          <el-tag size="mini" effect="dark" type='info'>
            {{showData.order_state}}</el-tag>
        </p>
      </div>
    </el-dialog>
    
    </div>
</template>

<script>
import axios from '../../utils/request'
export default {
    name:'FinishedTable',
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
      this.tableData = JSON.parse(sessionStorage.getItem('finished'))
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
      star(){
        this.$message.info({
          message:'评价功能还没写! emo',
          showClose:true,
          duration:1500
        })
      },
      handleEdit(index, row) {
        this.dialogVisible = true
        this.showData = row
      },
      refresh(){
        axios({
              method: 'POST',
              url:'/getfinished',
              params: {
                  id: sessionStorage.getItem('id'),
              },
          }).then(response => {
            sessionStorage.setItem('finished',JSON.stringify(response.data))
            this.tableData = JSON.parse(sessionStorage.getItem('finished'))
            this.$message.success({
              message:'刷新成功',
              duration:1000,
              showClose:true,
            })
          },()=>{
            this.$message.error({
              message:'数据库连接失败',
              duration:1500,
              showClose:true,    
            })
          })
      }
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
p{
  margin-top: 5px;
}
</style>