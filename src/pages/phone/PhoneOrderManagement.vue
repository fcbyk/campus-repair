<template>
  <div class="ordermanage">
    <el-tabs v-model="activeName" type="border-card">
      <el-tab-pane label="派送中" name="first">
        <el-table
          :data="tableData"
          style="width: 100%"
          size="medium"
          >
          <el-table-column
            label="故障单号">
            <template slot-scope="scope">
              <span>{{ scope.row.date }}</span>
            </template>
          </el-table-column>

          <el-table-column
            label="维修类别">
            <template slot-scope="scope">
              <el-popover trigger="hover" placement="top">
                <p>姓名: {{ scope.row.name }}</p>
                <p>住址: {{ scope.row.address }}</p>
              <el-button
                size="mini"
                @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
              <el-button
                size="mini"
                type="danger"
                @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                <div slot="reference" class="name-wrapper">
                  <span>{{ scope.row.name }}</span>
                </div>
              </el-popover>
            </template>
          </el-table-column>

          <el-table-column
            label="故障设备">
            <template slot-scope="scope">
              <span>{{ scope.row.address }}</span>
            </template>
          </el-table-column>
        </el-table>


      </el-tab-pane>

      <el-tab-pane label="已接单" name="second">配置管理</el-tab-pane>
      <el-tab-pane label="已完成" name="third">角色管理</el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
export default {
    name:'PhoneOrderManagement',
    data() {
      return {
        activeName: 'first',
        tableData: [{
          date: '2016-05-02',
          name: '王小虎',
          address: '上海市普陀区金沙江路 1518 弄'
        }, {
          date: '2016-05-04',
          name: '王小虎',
          address: '上海市普陀区金沙江路 1517 弄'
        }, {
          date: '2016-05-01',
          name: '王小虎',
          address: '上海市普陀区金沙江路 1519 弄'
        }, {
          date: '2016-05-03',
          name: '王小虎',
          address: '上海市普陀区金沙江路 1516 弄'
        },{
          date: '2016-05-02',
          name: '王小虎',
          address: '上海市普陀区金沙江路 1518 弄'
        }, {
          date: '2016-05-04',
          name: '王小虎',
          address: '上海'
        }, {
          date: '2016-05-01',
          name: '王小虎',
          address: '上海市普陀区金沙江路 1519 弄'
        }, {
          date: '2016-05-03',
          name: '王小虎',
          address: '上海市普陀区金沙江路 1516 弄'
        }]
      }
    },
    methods: {
      // handleClick(tab, event) {
      //   console.log(tab, event);
      // }
      handleEdit(index, row) {
        console.log(index, row);
      },
      handleDelete(index, row) {
        console.log(index, row);
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
</style>