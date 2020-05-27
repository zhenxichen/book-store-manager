<template>
  <div class="main">
    <TitleBar></TitleBar>
    <Menu></Menu>
    <div class="page">
      
    </div>
  </div>
</template>

<script>
import TitleBar from "@/components/TitleBar";
import Menu from "@/components/Menu";
import axios from "axios";

export default {
  name: 'Querysell',
  data() {
    return {

    }
  },
  created: function() {
    if(this.$global.username === ''){
      this.$router.push({
        name: 'Login'
      });
    }
    else{
      axios
        .get('/api/querysell/')
        .then((res) => {
          console.log(res);
        });
    }
  }
}
</script>