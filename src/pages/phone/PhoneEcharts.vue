<template>
  <div class="echarts">
    <!-- <el-empty description="熬夜开发中"></el-empty> -->
    <el-alert
      type="warning"
      title="以下数据为静态数据，实时数据尚未关联"
      show-icon>
    </el-alert>
    <div style="height: 10px;"></div>
    <el-card class="box-card" :v-show="vshow">
      <div slot="header" class="clearfix">
        <span>您的服务分</span>
      </div>

      <div class="chartbox1">
        <div ref="chartDom1" class="chartDom1"></div>
      </div>
      <p>数据来源：完成故障单后的用户评价</p>
    </el-card>
    <div style="height: 20px;"></div>
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>您最近一周的工作情况</span>
      </div>
      <div class="chartbox2">
        <div ref="chartDom2" class="chartDom2"></div>
      </div>
      <p>数据来源：每天所完成的故障单数</p>
    </el-card>
    <div style="height: 20px;"></div>

    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>您常去的地方</span>
      </div>
      <div class="chartbox3">
        <div ref="chartDom3" class="chartDom3"></div>
      </div>
      <p>数据来源：您所完成的故障单的一级地址分布</p>
    </el-card>
    <div style="height: 20px;"></div>
  </div>
</template>

<script>
import * as echarts from 'echarts/core'
import { GaugeChart } from 'echarts/charts'
import { CanvasRenderer } from 'echarts/renderers'
echarts.use([GaugeChart, CanvasRenderer])

import { GridComponent } from 'echarts/components'
import { LineChart } from 'echarts/charts'
import { UniversalTransition } from 'echarts/features'
echarts.use([GridComponent, LineChart, UniversalTransition])

import {
  TitleComponent,
  TooltipComponent,
  VisualMapComponent
} from 'echarts/components';
import { PieChart } from 'echarts/charts';
import { LabelLayout } from 'echarts/features';
echarts.use([
  TitleComponent,
  TooltipComponent,
  VisualMapComponent,
  PieChart,
  LabelLayout
]);

export default {
    name:'PhoneEcharts',
    data() {
      return {
        option:{
          series: [
              {
                type: 'gauge',
                startAngle: 180,
                endAngle: 0,
                min: 0,
                max: 1,
                splitNumber: 10,
                axisLine: {
                  lineStyle: {
                    width: 3,
                    color: [
                      [0.2, '#F56C6C'],
                      [0.4, '#E6A23C'],
                      [0.6, '#909399'],
                      [0.8, '#409EFF'],
                      [1, '#20d56c']
                    ]
                  }
                },
                pointer: {
                  icon: 'path://M12.8,0.7l12,40.1H0.7L12.8,0.7z',
                  length: '12%',
                  width: 10,
                  offsetCenter: [0, '-60%'],
                  itemStyle: {
                    color: 'auto'
                  }
                },
                axisTick: {
                  length: 12,
                  lineStyle: {
                    color: 'auto',
                    width: 1
                  }
                },
                splitLine: {
                  length: 16,
                  lineStyle: {
                    color: 'auto',
                    width: 2
                  }
                },
                axisLabel: {
                  color: '#464646',
                  fontSize: 10,
                  distance: -50,
                  formatter: function (value) {
                    if (value === 0.9) {
                      return '极好';
                    } else if (value === 0.7) {
                      return '优秀';
                    } else if (value === 0.5) {
                      return '良好';
                    } else if (value === 0.3) {
                      return '中等';
                    }else if (value === 0.1) {
                      return '较差';
                    }
                    return '';
                  }
                },
                title: {
                  offsetCenter: [0, '-20%'],
                  fontSize: 10
                },
                detail: {
                  fontSize: 20,
                  offsetCenter: [0, '0%'],
                  valueAnimation: true,
                  formatter: function (value) {
                    return Math.round(value * 100) + '分';
                  },
                  color: 'auto'
                },
                data: [
                  {
                    value: 0.98,
                    name: '您的服务极好'
                  }
                ]
              }
          ]
        },
        option2:{
          xAxis: {
            type: 'category',
            data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
          },
          yAxis: {
            type: 'value'
          },
          series: [
            {
              data: [3, 5, 4, 4, 2, 3, 5],
              type: 'line'
            }
          ]
        },
        option3:{
          // backgroundColor: '#2c343c',
          // title: {
          //   text: 'Customized Pie',
          //   left: 'center',
          //   top: 20,
          //   textStyle: {
          //     color: '#ccc'
          //   }
          // },
          tooltip: {
            trigger: 'item'
          },
          visualMap: {
            show: false,
            min: 80,
            max: 600,
            inRange: {
              colorLightness: [0, 1]
            }
          },
          series: [
            {
              name: '已完成故障单数',
              type: 'pie',
              radius: '55%',
              center: ['50%', '50%'],
              data: [
                { value: 335, name: '1栋学生公寓' },
                { value: 310, name: '图书馆' },
                { value: 274, name: '9栋学生公寓' },
                { value: 235, name: '8栋教学楼' },
                { value: 400, name: '黑超' }
              ].sort(function (a, b) {
                return a.value - b.value;
              }),
              roseType: 'radius',
              label: {
                color: '#909399'
              },
              labelLine: {
                lineStyle: {
                  color: '#2c343c'
                },
                smooth: 0.2,
                length: 10,
                length2: 20
              },
              itemStyle: {
                color: '#c23531',
                // shadowBlur: 200,
                // shadowColor: 'rgba(0, 0, 0, 0.5)'
              },
              animationType: 'scale',
              animationEasing: 'elasticOut',
              animationDelay: function () {
                return Math.random() * 200;
              }
            }
          ]
        },
        vshow:false
      }
    },
    methods: {
      // hello(){
      //   echarts.init(this.$refs.chartDom).clear()
      //   echarts.init(this.$refs.chartDom).setOption(this.option);
      // }
    },
    mounted(){
      echarts.init(this.$refs.chartDom1).setOption(this.option);
      echarts.init(this.$refs.chartDom2).setOption(this.option2);
      echarts.init(this.$refs.chartDom3).setOption(this.option3);
    }
}
</script>

<style scoped>
.echarts{
  padding: 10px;
}
.chartDom1{
  /* border: salmon solid 2px; */
  height: 350px;
  padding: 0;
}
p{
  font-size: 10px;
  text-align: center;
  /* background-color: beige; */
  margin-bottom: 10px;
  color: #909399;
}
.chartbox1{
  height: 200px;
  /* background-color: aqua; */
  overflow: hidden;
}
.chartDom2{
  height: 300px;
}
.chartDom3{
  height: 300px;
}
</style>