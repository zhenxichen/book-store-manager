<template>
  <div class="main">
    <TitleBar></TitleBar>
    <Menu></Menu>
    <div class="page">
      <div class="title">
        <div class="title-text">记录零售</div>
      </div>
      <a-form-model :model= "form" :rules="rules" ref="ruleForm">
        <a-form-model-item label="顾客ID" prop="CustomerID">
          <a-input placeholder="请输入顾客ID" 
          v-model="form.CustomerID"></a-input>
        </a-form-model-item>
        <a-form-model-item label="ISBN" prop="ISBN">
          <a-input placeholder="请输入ISBN号，多本书以英文','分隔" 
            type="textarea" v-model="form.ISBN"
          />
        </a-form-model-item>
        <a-form-model-item label="金额" prop="price">
          <a-input placeholder="请输入本单金额" v-model="form.price" />
        </a-form-model-item>
        <a-form-model-item>
          <a-button type="primary" @click="onSubmit">
            录入
          </a-button>
          <a-button style="margin-left: 30px;">
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
  name: 'Recordsell',
  data() {
    return {
      form: {
        CustomerID: undefined,
        ISBN: '',
        price: ''
      },
      rules: {
        CustomerID: [],
        ISBN: [{required: true, message: '请输入ISBN号'}],
        price: [{required: true, message: '请输入金额'}]
      },
      caption: ''
    };
  },
  methods: {
    onSubmit() {
      let formData = new FormData();
      if(this.form.CustomerID === undefined){
        formData.append('CustomerID', 0);
      }
      else{
        formData.append('CustomerID', this.form.CustomerID);
      }
      if(this.form.ISBN === ''){
        return;
      }
      const isbn = this.form.ISBN;
      const isbnList = isbn.split(',');
      for (let i = 0; i < isbnList.length; i++) {
        formData.append('isbn[]', isbnList[i]);
      }
      if(this.form.price === undefined){
        return;
      }
      formData.append('amount', this.form.price);
      formData.append('OperatorID', this.$global.username);
      console.log(this.$global.username);
      axios
        .post('/api/recordsell/', formData)
        .then((res) => {
          if(res.data === "Wrong ISBN"){
            this.caption = '存在错误的ISBN号码';
          }
          else{
            console.log(res.data);
            this.$router.push({
              name: 'Querysell'
            });
          }
        })
        .catch((err) => {
          console.log(err);
        });
    }
  },
  components: {
    TitleBar,
    Menu
  },
  created: function() {
    console.log(this.$global.username);
    if(this.$global.username === ''){
      this.$router.push({
        name: 'Login'
      });
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