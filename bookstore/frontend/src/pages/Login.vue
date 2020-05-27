<template>
  <div class="main">
    <div class="bg">
      <img src="@/assets/loginback.png" />
    </div>
    <div class="loginWin">
      <div class="title">登录</div>
      <form @submit.prevent="submit">
        <div class="bar">
          <div class="icon"><img src="@/assets/md-person.svg" /></div>
          <input type="text" placeholder="请输入账号" v-model="user.username"/>
        </div>
        <div class="bar">
          <div class="icon"><img src="@/assets/md-https.svg" /></div>
          <input type="password" placeholder="请输入密码" 
          v-model="user.password"/>
        </div>
        <input type="submit" value="登录" class="submit" />
      </form>
      <div class="down">
        <div class="caption">{{caption}}</div>
        <div class="signup">
          <router-link to="/signup">注册></router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'Login',
  data() {
    return {
      user:{
        username: '',
        password: '',
      },
      caption: ''
    }
  },
  methods: {
    submit() {
      let formData = new FormData();
      formData.append('username', this.user.username);
      formData.append('password', this.user.password);
      axios.post(
        '/api/login/',
        formData
      )
      .then((res) => {
        if(res.data === "Username Not Exist"){
          this.caption = '用户名错误';
          this.$forceUpdate();
        }
        else if(res.data === "Wrong Password."){
          this.caption = '密码错误';
          this.$forceUpdate();
        }
        else{
          console.log(res);
          this.$global.setUsername(res.username);
          this.$router.push({
            name: 'Depot'
          });
        }
      })
      .catch((err) => {
        console.log(err);
      })
    }
  }
}
</script>

<style scoped>
  
.main{
  width: 100%;
  height: 100%;
  background-color: rgba(255, 255, 255, 1);
}

.bg{
  position: absolute;
  left: 91px;
  top: 50%;
  width: 650px;
  height: 470px;
  transform: translateY(-50%);
}

.bg img{
  width: 650px;
  height: 470px;
}

.loginWin{
  position: absolute;
  left: 854px;
  top: 50%;
  width: 490px;
  height: 545px;
  line-height: 20px;
  border-radius: 3px;
  background-color: rgba(255, 255, 255, 1);
  text-align: center;
  box-shadow: 0px 1px 5px 0px rgba(0, 0, 0, 0.2);
  border: 1px solid rgba(255, 255, 255, 0);
  transform: translateY(-50%);
}

.loginWin .title{
  margin-top: 44px;
  margin-left: 42px;
  width: 96px;
  height: 36px;
  color: rgba(16, 16, 16, 1);
  font-size: 24px;
  text-align: left;
  font-family: Arial, Helvetica, sans-serif;
  margin-bottom: 40px;
}

.bar{
  width: 420px;
  height: 55px;
  line-height: 20px;
  border-radius: 3px;
  background-color: rgba(255, 255, 255, 1);
  border: 1px solid rgba(220, 220, 220, 1);
  margin-bottom: 30px;
  margin-left: 42px;
  text-align: left;
  display: flex;
}

.bar .icon{
  width: 25px;
  height: 25px;
  margin-top: 15px;
  margin-left: 15px;
}

.bar .icon img{
  width: 25px;
  height: 25px;
  background-color: rgba(255, 255, 255, 1);
  border-radius: 50%;
}

.bar input{
  border-style: none;
  margin-left: 10px;
  width: 370px;
  font-size: 20px;
  box-shadow: none;
  text-shadow: none;
  outline-color: transparent;
}

.submit{
  margin-left: 15px;
  width: 420px;
  height: 55px;
  line-height: 23px;
  border-radius: 3px;
  background-color: rgba(58, 98, 215, 1);
  color: rgba(255, 255, 255, 1);
  font-size: 16px;
  text-align: center;
  font-family: Arial, Helvetica, sans-serif;
  border: 1px solid rgba(58, 98, 215, 1);
  margin-bottom: 30px;
}

.down{
  width: 420px;
  height: 27px;
  display: flex;
  margin-left: 42px;
}

.caption{
  color: red;
  font-size: 18px;
  text-align: center;
  width: 365px;
  height: 27px;
  padding-left: 50px;
}

.signup{
  width: 55px;
  height: 27px;
  text-align: center;
}

.signup router-link {
  width: 55px;
  height: 27px;
  text-align: center;
  color: rgba(58, 98, 215, 1);
  font-size: 18px;
  text-align: left;
  font-family: Arial, Helvetica, sans-serif;
}

a{
  text-decoration: none;
}

.router-link-active{
  text-decoration: none;
  color: rgba(58, 98, 215, 1);
}

</style>