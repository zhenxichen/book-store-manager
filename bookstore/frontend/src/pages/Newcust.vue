<template>
  <div class="main">
    <TitleBar></TitleBar>
    <Menu></Menu>
    <div class="page">
      <div class="title">
        <div class="title-text">记录归还</div>
      </div>
      <a-form-model :model="form" :rules="rules">
        <a-form-model-item label="顾客ID" prop="CustomerID">
          <a-input placeholder="请输入顾客ID（数字）" 
          v-model="form.CustomerID" />
        </a-form-model-item>
        <a-form-model-item label="顾客姓名" prop="name">
          <a-input placeholder="请输入顾客姓名" 
          v-model="form.name" />
        </a-form-model-item>
        <a-form-model-item label="地址" prop="address">
          <a-input placeholder="请输入地址（可不填）" 
          v-model="form.address" type="textarea" />
        </a-form-model-item>
        <a-form-model-item style="margin-left: 150px;">
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
  name: 'Newcust',
  data() {
    return {
      form: {
        CustomerID: undefined,
        name: '',
        address: ''
      },
      rules: {
        CustomerID: [{ required: true, message: '请输入顾客ID' }],
        name: [{ required: true, message: '请输入顾客姓名' }],
        address: []
      },
      caption: ''
    }
  },
  components: {
    TitleBar,
    Menu
  },
  methods: {
    onSubmit: function(){
      if(this.form.CustomerID === ''){
        return;
      }
      if(this.form.name === ''){
        return;
      }
      let formData = new FormData();
      formData.append('CustomerID', this.form.CustomerID);
      formData.append('name', this.form.name);
      formData.append('address', this.form.address);
      axios
        .post('/api/newCustomer/', formData)
        .then((res) => {
          if(res.data === "ID existed"){
            this.caption = '该ID已存在';
            this.$forceUpdate();
          }
          else{
            this.$router.push({
              name: 'Depot'
            });
          }
        })
        .catch((err) => {
          console.log(err);
        });
    },
    onCancel: () => {
      this.$router.push({
        name: 'Depot'
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