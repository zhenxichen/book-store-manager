<template>
  <div class="main">
    <TitleBar></TitleBar>
    <Menu></Menu>
    <div class="page">
      <div class="title">
        <div class="title-text">零售查询</div>
      </div>
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
    dataIndex: 'amount',
    key: 'amount',
    title: '金额'
  },
  {
    dataIndex: 'operator',
    key: 'operator',
    title: '操作员'
  },
  {
    dataIndex: 'time',
    key: 'time',
    title: '时间'
  },
]

export default {
  name: 'Querysell',
  data() {
    return {
      data: [],
      columns
    }
  },
  created: function() {
    if(this.$global.username === ''){
      this.$router.push({
        name: 'Login'
      });
    }
    else{
      axios
        .get('/api/querysell/')
        .then((res) => {
          let resJson = JSON.parse(res.data.replace(/'/g, '"'));
          let sellList = resJson.sellList;
          this.data = sellList;
        })
        .catch((err) => {
          console.log(err);
        })
    }
  },
  components: {
    TitleBar,
    Menu
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