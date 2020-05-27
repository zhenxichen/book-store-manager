<template>
  <div class="main">
    <TitleBar></TitleBar>
    <Menu :page=0></Menu>
    <div class="page">
      <div class="title">
        <div class="title-text">查看库存</div>
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
    dataIndex: "ISBN",
    key: "ISBN",
    title: "ISBN"
  },
  {
    dataIndex: "title",
    key: "title",
    title: "书刊名称"
  },
  {
    dataIndex: "author",
    key: "author",
    title: "作者"
  },
  {
    dataIndex: "Type",
    key: "Type",
    title: "类别"
  },
  {
    dataIndex: "price",
    key: "price",
    title: "售价"
  },
  {
    dataIndex: "number",
    key: "number",
    title: "库存"
  }
];

const data = [];

export default {
  name: "Depot",
  data() {
    return {
      data: [],
      columns
    };
  },
  components: {
    TitleBar,
    Menu
  },
  created: function() {
    if(this.$global.username === ''){
      this.$router.push({
        name: 'Login'
      });
    }
    else{
      let resJson;
      axios
        .get("/api/depot/")
        .then(res => {
          const resStr = res.data.replace(/'/g, '"');
          //console.log(resStr);
          resJson = JSON.parse(resStr);
          //console.log(resJson);
          let bookList = resJson.bookList;
          for (let i = 0; i < bookList.length; i++) {
            bookList[i].key = i;
            if(bookList[i].type === 0){
              bookList[i].Type = "报刊";
            }
            else{
              bookList[i].Type = "书籍";
            }
          }
          this.data = bookList;
          console.log(this.data);
        })
        .catch(err => {
          console.log(err);
        });
    }
  }
};
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