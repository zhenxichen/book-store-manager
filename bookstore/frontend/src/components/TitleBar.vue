<template>
  <div class="titlebar">
    <div class="title">书店书刊出租和零售管理系统</div>
  </div>
</template>

<style scoped>

.titlebar{
  left: 0px;
  top: 0px;
  width: 100%;
  height: 65px;
  line-height: 26px;
  background-color: rgba(36, 104, 169, 1);
  color: rgba(16, 16, 16, 1);
  font-size: 18px;
  text-align: left;
  font-family: Arial, Helvetica, sans-serif;
  border: 1px solid rgba(255, 255, 255, 0);
  position: absolute;
}

.title{
  position: absolute;
  top: 50%;
  left: 24px;
  color: rgba(255, 255, 255, 1);
  font-weight: 700;
  transform: translateY(-50%);
}

.username{
  top: 45%;
  left: 95%;
  width: 42px;
  height: 17px;
  color: rgba(255, 255, 255, 1);
  font-size: 14px;
  text-align: left;
  font-family: Arial, Helvetica, sans-serif;
  position: absolute;
  transform: translateY(-50%)
}

</style>

<script>
export default {
  name: 'TitleBar',
  data() {
    return {
      
    }
  }
}
</script>