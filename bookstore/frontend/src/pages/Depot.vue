<template>
  <div class="main">
    <TitleBar></TitleBar>
    <Menu :page=0></Menu>
    <div class="page">
      <div class="title">
        <div class="title-text">查看库存</div>
      </div>
      <a-table 
        :columns="columns" 
        :data-source="data" 
      />
      <a-modal
        :visible="visible"
        @ok="handleOk"
        @cancel="handleCancel"
      >
        <a-range-picker @change="onChange" />
        <div class="show">
          <p>ISBN：{{modal.ISBN}}</p>
          <p>书名：{{modal.title}}</p>
          <p>作者：{{modal.author}}</p>
          <p>销量：{{modal.sells}}</p>
          <p>借出：{{modal.rents}}</p>
        </div>
      </a-modal>
    </div>
  </div>
</template>

<script>
import TitleBar from "@/components/TitleBar";
import Menu from "@/components/Menu";
import axios from "axios";


const data = [];

export default {
  name: "Depot",
  data() {
    const that = this;
    const columns = [
      {
        dataIndex: "ISBN",
        key: "ISBN",
        title: "ISBN",
        customRender: (text, row, index) => {
          const children = that.$createElement("a", {
            domProps: {
              innerHTML: text
            },
            on: {
              click: function(){
                that.click(text);
              }
            }
          });
          const obj = {
            children: children,
            attrs: {}
          };
          return obj;
        }
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
    return {
      data: [],
      columns,
      visible: false,
      modal: {
        ISBN: '',
        title: '',
        author: '',
        sells: undefined,
        rents: undefined,
      },
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
  },
  methods: {
    click: function(text){
      const ISBN = text;
      let formData = new FormData();
      formData.append('ISBN', ISBN);
      formData.append('begin', '');
      formData.append('end', '');
      axios
        .post('/api/querybook/', formData)
        .then((res) => {
          if(res.data === "ISBN Error"){
            return;
          }
          const resJson = JSON.parse(res.data.replace(/'/g, '"'));
          this.modal.ISBN = resJson.ISBN;
          this.modal.title = resJson.title;
          this.modal.author = resJson.author;
          this.modal.sells = resJson.sell;
          this.modal.rents = resJson.rent;
          this.visible = true;
        })
        .catch((err) => {
          console.log(err);
        });
    },
    handleOk() {
      this.visible = false;
    },
    handleCancel() {
      this.visible = false;
    },
    onChange(date, dateString){
      console.log(dateString);
      const ISBN = this.modal.ISBN;
      let formData = new FormData();
      formData.append('ISBN', ISBN);
      formData.append('begin', dateString[0]);
      formData.append('end', dateString[1]);
      axios
        .post('/api/querybook/', formData)
        .then((res) => {
          if(res.data === "ISBN Error"){
            return;
          }
          const resJson = JSON.parse(res.data.replace(/'/g, '"'));
          this.modal.sells = resJson.sell;
          this.modal.rents = resJson.rent;
        })
        .catch((err) => {
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

.show {
  margin-top: 20px;
}
</style>