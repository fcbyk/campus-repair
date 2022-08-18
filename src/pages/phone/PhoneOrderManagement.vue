<template>
  <div class="ordermanage">
    <el-tabs v-model="activeName" type="border-card">
      <el-tab-pane label="派送中" name="first">
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
export default {
    name:'PhoneOrderManagement',
    data() {
      return {
        activeName: 'first',
        tableData1: [{
          rnumber: '00001',
          rsort: '后勤维修',
          f_equ: '插座'
        }, {
          rnumber: '00002',
          rsort: '空调维修',
          f_equ: '寝室空调'
        }, {
          rnumber: '00003',
          rsort: '水表，一卡通',
          f_equ: '热水读卡器'
        }],
        tableData2: [],
        tableData3: []
      }
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
          this.tableData1.splice(index,1)
        },()=>{})
      },
      refresh(){
        this.$message.success('刷新成功')
      }
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