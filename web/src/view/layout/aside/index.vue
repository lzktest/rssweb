<template>
  <div>
    <el-container>
      <transition>
        <el-menu
          :collapse="isCollapse"
          :collapse-transition="true"
          :default-active="active"
          @select="selectMenuItem"
          active-text-color="#fff"
          class="el-menu-vertical"
          text-color="rgb(191,203,217)"
          unique-opened
          >
          <template v-for="item in asyncRouters[0].children">
            <aside-component :key="item.name" :routerInfo="item" v-if="!item.hidden" />
          </template>
        </el-menu>
      </transition>
    </el-container>
  </div>
</template>
<script>
import { mapGetters, mapMutations } from "vuex";
import AsideComponent from "@/view/layout/aside/asideComponent";
export default {
  name: "Aside",
  data(){
    return {
      active: "",
      isCollapse: false
    };
  },
  methods: {
    ...mapMutations("history", ["addHistory"]),
    selectMenuItem(index, _, ele){
      const query = {};
      const params = {};
      ele.route.parameters &&
          ele.route.parameters.map(item => {
            if (item.type == "query"){
              query[item.key] = item.value;
            } else {
              params[item.key] = item.value;
            }
          });
          console.log(index);
          console.log(this.$route.name);
          console.log('test');
      if (index === this.$route.name) return;
      if (index.indexOf("http://") > -1 || index.indexOf("https://") > -1) {
        window.open(index);
      } else {
        this.$router.push({ name: index, query, params });
      }
    }
  },
  computed: {
    ...mapGetters("router", ["asyncRouters"])
  },
  components: {
    AsideComponent
  },
  created(){
    this.active = this.$route.name;
    let screenWidth = document.body.clientWidth;
    if (screenWidth < 1000){
      this.isCollapse = ! this.isCollapse;
    }
    this.$bus.on("collapse", item => {
      this.isCollapse = item;
    });
  },
  watch: {
    $route(){
      this.active = this.$route.name;
    }
  },
  beforeDestroy(){
    this.$bus.off("collapse");
  }
};
</script>
<style>
.el-menu-vertical{
  width: 100%;
  background: #191a23;
  border-right: 0px;
}
</style>