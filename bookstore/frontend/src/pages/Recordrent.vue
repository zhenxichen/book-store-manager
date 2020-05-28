<template>
  <div class="main">
    <TitleBar></TitleBar>
    <Menu></Menu>
    <div class="page">
      <div class="title">
        <div class="title-text">记录借出</div>
      </div>
      <a-form-model :model="form" :rules="rules">
        <a-form-model-item label="顾客ID" prop="CustomerID">
          <a-input placeholder="请输入顾客ID" 
          v-model="form.CustomerID" />
        </a-form-model-item>
        <a-form-model-item label="ISBN" prop="ISBN">
          <a-input placeholder="请输入书籍ISBN" 
          v-model="form.ISBN" />
        </a-form-model-item>
        <a-form-model-item>
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
  name: 'Recordrent',
  data() {
    return {
      form: {
        CustomerID: undefined,
        ISBN: ''
      },
      rules: {
        CustomerID: [
          { required: true, message: '请输入顾客ID' }
        ],
        ISBN: [{required: true, message: '请输入ISBN号'}],
      },
      caption: ''
    }
  },
  created: function(){
    if(this.$global.username === ''){
      this.$router.push({
        name: 'Login'
      });
    }
  },
  methods: {
    onSubmit() {
      if(this.form.CustomerID === undefined){
        return;
      }
      if(this.form.ISBN === ''){
        return;
      }
      let formData = new FormData();
      formData.append('CustomerID', this.form.CustomerID);
      formData.append('ISBN', this.form.ISBN);
      formData.append('OperatorID', this.$global.username);
      axios
        .post('/api/recordrent/', formData)
        .then((res) => {
          if(res.data === "Wrong ISBN"){
            this.caption = 'ISBN错误，请重新输入';
            this.$forceUpdate();
          }
          else if(res.data === "Customer Not Found."){
            this.caption = '该顾客ID不存在';
            this.$forceUpdate();
          }
          else{
            this.$router.push({
              name: 'Queryrent'
            });
          }
        })
        .catch((err) => {
          console.log(err);
        })
    },
    onCancel() {
      this.$router.push({
        name: 'Queryrent'
      });
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

.ant-form {
  padding-left: 30px;
  padding-top: 20px;
}

.ant-form-item {
  display: flex;
  text-align: right;
}

.ant-input {
  width: 420px;
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