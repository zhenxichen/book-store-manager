<template>
  <div class="menu">
    <div class="title">
      <img src="@/assets/md-av_timer.svg" />
      <div class="text">系统菜单</div>
    </div>
    <div class="item" id="depot" v-on:click="depot">
      查看库存
    </div>
    <div class="item" id="purchase" v-on:click="purchase">
      添加库存
    </div>
    <div class="item" id="querysell" v-on:click="querysell">
      零售查询
    </div>
    <div class="item" id="recordsell" v-on:click="recordsell">
      记录零售
    </div>
    <div class="segment"></div>
  </div>
</template>

<style scoped>

.menu {
  width: 208px;
  height: 959px;
  border: none;
  position: fixed;
  top: 67px;
}

.title {
  width: 208px;
  height: 43px;
  width: 208px;
  height: 43px;
  line-height: 20px;
  background-color: rgba(255, 255, 255, 1);
  text-align: center;
  box-shadow: 0px 0px 0px 0px rgba(0, 0, 0, 0.5);
  display: flex;
}

.title img {
  width: 20px;
  height: 20px;
  margin-left: 22px;
  margin-top: 13px;
}

.title .text {
  margin-top: 13px;
  margin-left: 8px;
  width: 56px;
  height: 20px;
  opacity: 0.4;
  color: rgba(0, 0, 0, 1);
  font-size: 14px;
  text-align: left;
  font-family: Arial, Helvetica, sans-serif;
  cursor: default;
}

.item {
  width: 208px;
  height: 40px;
  line-height: 20px;
  background-color: rgba(255, 255, 255, 1);
  text-align: left;
  box-shadow: 0px 0px 0px 0px rgba(0, 0, 0, 0.5);
  padding-left: 50px;
  color: rgba(95, 95, 95, 1);
  font-size: 14px;
  font-family: Arial, Helvetica, sans-serif;
  cursor: pointer;
}

.segment {
  width: 1px;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.1);
  position: fixed;
  left: 208px;
  top: 65px;
}

</style>

<script>
export default {
  name: 'Menu',
  props: {
    page: Number
  },
  data() {
    return {
      pageIndex: this.page
    }
  },
  methods: {
    depot() {
      this.$router.push({
        name: 'Depot'
      });
    },
    purchase() {
      this.$router.push({
        name: 'Purchase'
      });
    },
    querysell() {
      this.$router.push({
        name: 'Querysell'
      });
    },
    recordsell() {
      this.$router.push({
        name: 'Recordsell'
      });
    },
  },
  created: function(){
    
  }
}
</script>