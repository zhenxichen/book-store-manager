<template>
  <div class="main">
    <TitleBar></TitleBar>
    <Menu></Menu>
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

    }
  },
  components: {
    TitleBar,
    Menu
  }
}
</script>