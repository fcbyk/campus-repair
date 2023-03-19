<template>
    <div class="pushtables">
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
                @click="handleShow(scope.$index, scope.row)"
                type="info"
                >详细</el-button>
                <el-button
                size="mini"
                @click="handleEdit(scope.$index, scope.row)"
                type="primary"
                >编辑</el-button>
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

      <el-dialog
      :visible.sync="dialogVisible"
      width="70%"
      :show-close='false'
      custom-class='menudialog'
      top='20vh'
      >
      <div>
        <p>故障单号： {{showData.rnumber}}</p>
        <p>维修类别： {{showData.rsort}}</p>
        <p>故障设备： {{showData.f_equ}}</p>
        <p>故障单发起人： {{showData.init_id}}</p>
        <p>维修地点： {{showData.place}}</p>
        <p>维修备注：{{showData.note}}</p>
        <p>创建时间：{{date(showData.creation_time)}}</p>
        <p>故障单状态：
          <el-tag size="mini" effect="dark">
            {{showData.order_state}}</el-tag>
        </p>
      </div>
    </el-dialog>

    <el-dialog
      :visible.sync="dialogVisible2"
      :fullscreen='true'
      title="修改故障单"
      :show-close='false'
      >
      <div style="height: 30px;"></div>
      <el-form ref="user" :model="showData" label-width="100px">
        <el-form-item label="维修类别">
          <el-select v-model="showData.rsort" placeholder="请选择类别">
            <el-option value="后勤报修"></el-option>
            <el-option value="水表、一卡通"></el-option>
            <el-option value="室内热水"></el-option>
            <el-option value="空调维修"></el-option>
            <el-option value="楼道饮水机维修"></el-option>
            <el-option value="消防"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="故障设备名称" >
          <el-input v-model="showData.f_equ" ></el-input>
        </el-form-item>
        <el-form-item label="地点">
          <el-input v-model="showData.place"></el-input>
        </el-form-item>
        <el-form-item label="预约时间" size="mini">
          <el-col :span="11">
            <el-date-picker type="date" placeholder="选择日期" v-model="showData.date1" style="width: 150%;" disabled></el-date-picker>
          </el-col>
          <el-col class="line" :span="2"></el-col>
          <el-col :span="11">
            <el-time-picker placeholder="选择时间" v-model="showData.date2" style="width: 100%;" disabled></el-time-picker>
          </el-col>
        </el-form-item>
        <el-form-item label="补充说明">
          <el-input type="textarea" v-model="showData.note"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="confirm">立即上报</el-button>
          <el-button @click="dialogVisible2 = false">取消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>

    </div>
</template>

<script>
import axios from '../../utils/request'
let emptyStr = ''
export default {
    name:'PushTables',
    data() {
        return {
            tableData: [],
            dialogVisible: false,
            dialogVisible2:false,
            showData:[]
        }
    },
    mounted(){
      this.tableData = JSON.parse(sessionStorage.getItem('push'))
    },
    methods: {
      date(x){
        let a = new Date(x)
        let b = a.toLocaleTimeString('chinese',{hour12:false})
        let c = a.toLocaleDateString()
        return c + ' ' + b
      },
      handleShow(index, row) {
        this.dialogVisible = true
        this.showData = row
      },
      handleEdit(index, row){
        this.showData = row
        this.dialogVisible2 = true
      },
      handleDelete(index, row) {
        console.log(index, row);
        this.$confirm("确定删除吗",{ 
          customClass:'message'
        }).then(()=>{
          this.deletethis(row.rnumber)
          this.tableData.splice(index,1)
          sessionStorage.setItem('push',JSON.stringify(this.tableData))
        },()=>{})
      },
      refresh(){
        axios({
              method: 'POST',
              url:'/getpush',
              params: {
                  id: sessionStorage.getItem('id'),
              },
          }).then(response => {
            sessionStorage.setItem('push',JSON.stringify(response.data))
            this.tableData = JSON.parse(sessionStorage.getItem('push'))
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
      deletethis(x){
        axios({
              method: 'POST',
              url:'/deletethis',
              params: {
                  number: x,
              },
          }).then(response => {
            if(response.data == 'successful'){
              this.$message.success({
                message:'删除成功',
                duration:1500,
                showClose:true,
              })
            }
          },()=>{
            this.$message.error({
              message:'数据库连接失败',
              duration:1500,
              showClose:true,    
            })
          })
      },
      confirm(){
        if(this.showData.rsort== emptyStr){
          this.$message.error({
            message:'请选择维修类别',
            duration:1500,
            showClose:true,    
          })
          return 0
        }
        if(this.showData.f_equ== emptyStr){
          this.$message.error({
            message:'请填写故障设备名称',
            duration:1500,
            showClose:true,    
          })
          return 0
        }
        if(this.showData.place== emptyStr){
          this.$message.error({
            message:'请填写维修地点',
            duration:1500,
            showClose:true,    
          })
          return 0
        }
        axios({
            method: 'POST',
            url:'/alterorder',
            params: {
              number: this.showData.rnumber,
              sort: this.showData.rsort,
              equ:  this.showData.f_equ,
              addr: this.showData.place,
              note: this.showData.note
            },
        }).then(response => {
            if(response.data=='successful'){

                axios({
                      method: 'POST',
                      url:'/getpush',
                      params: {
                          id: sessionStorage.getItem('id'),
                      },
                  }).then(response => {
                    sessionStorage.setItem('push',JSON.stringify(response.data))
                    this.tableData = JSON.parse(sessionStorage.getItem('push'))
                  },()=>{})

                this.dialogVisible2 = false
                this.$message.success({
                  message:'修改成功',
                  duration:1500,
                  showClose:true,
                })
            }
            if(response.data=='err'){
                this.$message.error({
                  message:'修改失败',
                  duration:1500,
                  showClose:true,    
                })
            }
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
.pushtables{
    padding: 5px 15px;
}
p{
  margin-top: 5px;
}
</style>