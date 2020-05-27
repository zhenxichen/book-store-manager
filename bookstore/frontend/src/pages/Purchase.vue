<template>
  <div class="main">
    <TitleBar></TitleBar>
    <Menu></Menu>
    <div class="page">
      <div class="title">
        <div class="title-text">添加库存</div>
      </div>
      <div class="empty"></div>
      <a-form-model :model= "form">
        <div class="line">
          <div class="text">ISBN：</div>
          <a-input placeholder="请输入ISBN" v-model="form.ISBN"></a-input>
        </div>
        <div class="line">
          <div class="text">书刊名称：</div>
          <a-input placeholder="请输入书名" v-model="form.title"></a-input>
        </div>
        <div class="line">
          <div class="text">作者：</div>
          <a-input placeholder="请输入作者" v-model="form.author"></a-input>
        </div>
        <div class="line">
          <div class="text">数量：</div>
          <a-input placeholder="请输入进货数量" v-model="form.number"></a-input>
        </div>
        <div class="line">
          <div class="text-s">类型：</div>
          <a-select show-search style="width: 430px" placeholder="请选择书刊类型" v-model="form.type">
            <a-select-option value=1>书籍</a-select-option>
            <a-select-option value=0>报刊</a-select-option>
          </a-select>
        </div>
        <div class="line">
          <div class="text">售价：</div>
          <a-input placeholder="请输入书刊售价" v-model="form.price"></a-input>
        </div>
        <a-form-model-item style="margin-left: 180px;">
          <a-button type="primary" @click="onSubmit">
            录入
          </a-button>
          <a-button style="margin-left: 30px;" @click="onCancel">
            取消
          </a-button>
        </a-form-model-item>
      </a-form-model>
      <div class="caption">{{caption}}</div>
    </div>
  </div>
</template>

<script>
import TitleBar from "@/components/TitleBar";
import Menu from "@/components/Menu";
import axios from "axios";

export default {
  name: 'Purchase',
  data() {
    return {
      form: {
        ISBN: '',
        title: '',
        author: '',
        number: undefined,
        type: undefined,
        price: undefined
      },
      caption: ''
    }
  },
  components: {
    TitleBar,
    Menu
  },
  methods: {
    onSubmit() {
      //console.log(this.form);
      let formData = new FormData();
      if(this.form.ISBN === ''){
        this.caption = 'ISBN号码不得为空';
        this.$forceUpdate();
        return;
      }
      formData.append('ISBN', this.form.ISBN);
      if(this.form.title === ''){
        this.caption = '书名不得为空';
        this.$forceUpdate();
        return;
      }
      formData.append('title', this.form.title);
      if(this.form.author === ''){
        this.caption = '作者不得为空';
        this.$forceUpdate();
        return;
      }
      formData.append('author', this.form.author);
      if(this.form.number === undefined){
        this.caption = '请填写进货数量';
        this.$forceUpdate();
        return;
      }
      formData.append('number', this.form.number);
      if(this.form.price === undefined){
        this.caption = '请填写商品售价';
        this.$forceUpdate();
        return;
      }
      formData.append('price', this.form.price);
      if(this.form.type === undefined){
        this.caption = '请选择书刊类型';
        this.$forceUpdate();
        return;
      }
      if(this.form.type === "1"){
        formData.append('type', 1);
      }
      else{
        formData.append('type', 0);
      }
      axios
        .post('/api/purchase/', formData)
        .then(() => {
          this.$router.push({
            name: 'Depot'
          });
        });
    },
    onCancel() {
      this.$router.push({
        name: 'Depot'
      });
    }
  },
  created: function(){
    // 若未登录，则跳转至登录界面
    if(this.$global.username === ''){
      this.$router.push({
        name: 'Login'
      });
    }
  }
}
</script>

<style scoped>

.page{
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

.line {
  width: 455px;
  height: 40px;
  margin-bottom: 20px;
  display: flex;
}

.line .text {
  width: 100px;
  height: 20px;
  color: rgba(16, 16, 16, 1);
  font-size: 14px;
  text-align: right;
  font-family: Arial, Helvetica, sans-serif;
  padding-top: 5px;
  margin-right: 3px;
}

.text-s {
  width: 100px;
  height: 20px;
  color: rgba(16, 16, 16, 1);
  font-size: 14px;
  text-align: right;
  font-family: Arial, Helvetica, sans-serif;
  padding-top: 5px;
  margin-right: -1px;
}

.line a-input {
  width: 406px;
  height: 40px;
}

.line a-select {
  height: 40px;
}

.empty {
  width: 100%;
  height: 30px;
}

.container {
  margin-left: 60px;
}

.caption {
  color: red;
  width: 400px;
  height: 20px;
  font-size: 14px;
  text-align: center;
  padding-left: 130px;
}

</style>