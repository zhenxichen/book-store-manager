<template>
  <div class="titlebar">
    <div class="title">书店书刊出租和零售管理系统</div>
  </div>
</template>

<style scoped>

.titlebar{
  width: 100%;
  height: 65px;
  line-height: 26px;
  background-color: rgba(36, 104, 169, 1);
  color: rgba(16, 16, 16, 1);
  font-size: 18px;
  text-align: left;
  font-family: Arial, Helvetica, sans-serif;
  border: none;
  position: fixed;
  display: flex;
}

.title{
  height: 65px;
  margin-top: 50px;
  margin-left: 24px;
  color: rgba(255, 255, 255, 1);
  font-weight: 700;
  transform: translateY(-50%);
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