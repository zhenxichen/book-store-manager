<template>
  <div class="main">
    <TitleBar></TitleBar>
    <Menu></Menu>
    <div class="page">
      <div class="title">
        <div class="title-text">记录零售</div>
      </div>
      <a-input-search
        placeholder="可根据顾客姓名进行查询（搜索框为空则显示全部）"
        enter-button
        @search="onSearch"
        style="width: 100%;"
      />
      <a-table :columns="columns" :data-source="data"></a-table>
    </div>
  </div>
</template>

<script>
import TitleBar from "@/components/TitleBar";
import Menu from "@/components/Menu";
import axios from "axios";

const columns = [
  {
    dataIndex: 'OrderID',
    key: 'OrderID',
    title: '订单号'
  },
  {
    dataIndex: 'CustomerName',
    key: 'CustomerName',
    title: '顾客'
  },
  {
    dataIndex: 'rent_time',
    key: 'rent_time',
    title: '借出时间'
  },
  {
    dataIndex: 'due_date',
    key: 'due_date',
    title: '返还期限'
  },
  {
    dataIndex: 'return_date',
    key: 'return_date',
    title: '还书时间'
  },
  {
    dataIndex: 'operator',
    key: 'operator',
    title: '操作员'
  },
]

export default {
  name: 'Queryrent',
  data() {
    return {
      data: [],
      columns,
      data_bak: []
    }
  },
  components: {
    TitleBar,
    Menu
  },
  created: function(){
    if(this.$global.username === ''){
      this.$router.push({
        name: 'Login'
      });
    }
    else{
      axios
        .get('/api/queryrent/')
        .then((res) => {
          let resJson = JSON.parse(res.data.replace(/'/g, '"'));
          let rentList = resJson.rentList;
          for(let i=0;i<rentList.length;i++){
            if(rentList[i].return_date === 'None'){
              rentList[i].return_date = '-';
            }
          }
          this.data = rentList;
          this.data_bak = rentList;
          console.log(rentList);
        })
        .catch((err) => {
          console.log(err);
        });
    }
  },
  methods: {
    onSearch(value) {
      const totalData = this.data_bak;
      console.log(this.data_bak);
      let tableData = [];
      if(value === ''){ 
        this.data = totalData;
        console.log(this.data);
      }
      else{
        for(let i = 0; i < totalData.length; i++){
          if(totalData[i].CustomerName === value){
            tableData.push(totalData[i]);
          }
        }
        this.data = tableData;
      }
    }
  }
}
</script>

<style scoped>

.page {
  width: 100%;
  padding-top: 65px;
  padding-left: 209px;
}

.title {
  width: 100%;
  height: 45px;
  line-height: 20px;
  background-color: rgba(240, 240, 242, 1);
  text-align: center;
  box-shadow: 0px 0px 0px 0px rgba(0, 0, 0, 0.5);
}

.title-text {
  width: 106px;
  height: 20px;
  color: rgba(144, 144, 144, 1);
  font-size: 14px;
  text-align: left;
  font-family: Arial, Helvetica, sans-serif;
  padding-left: 26px;
  padding-top: 12px;
}

</style>