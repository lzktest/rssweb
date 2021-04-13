<template>
    <div class="router-history">
        <el-tabs 
            v-model="activeValue"
            type="card"
            @tab-click="changeTab"
            :closable="!(this.$route.name==defaultRouter)"
            >
            <el-tab-pane
                :key="item.name + JSON.stringify(item.query)+JSON.stringify(item.params)"
                :label="item.meta.title"
                :name="item.name + JSON.stringify(item.query)+JSON.stringify(item.params)"
                :tab="item"
                v-for="item in historys">
            </el-tab-pane>
        </el-tabs>
    </div>
</template>
<script>
import { mapGetters } from "vuex";
  const getFmtString = (item) => {
      return item.name + JSON.stringify(item.query)+ JSON.stringify(item.params)
  }
export default{
  name: "HistoryComponent",
  data(){
      return {
          historys: [],
          activeValue: "",
          isMobile: false,
          isCollapse: false,
      }
  },
  computed: {
      ...mapGetters("user",["userInfo"]),
      defaultRouter() {
          return this.userInfo.authority.defaultRouter;
      }
  },
  created() {
      this.$bus.on("mobile", isMobile =>{
          this.isMobile = isMobile;
      });
      this.$bus.on("collapse", isCollapse => {
          this.isCollapse = isCollapse;
      });
      const initHistorys = [
          {
            name: this.defaultRouter,
            meta: {
              title: "首页"
            },
            query: {},
            params: {}
          }
      ];
      this.historys = JSON.parse(sessionStorage.getItem("historys")) || initHistorys;
         if (!window.sessionStorage.getItem("historys")){
             this.activeValue = getFmtString(this.$route)
         } else {
             this.activeValue = window.sessionStorage.getItem("activeValue");
         }
       this.setTab(this.$route);
  },
   beforeDestroy(){
       this.$bus.off("collapse");
       this.$bus.off("mobile");
   },
   methods: {
       isSame(route1, route2){
           if (route1.name != route2.name){
               return false;
           }
           for (let key in route1.query){
               if (route1.query[key] != route2.query[key]){
                   return false;
               }
           }
           for (let key in route1.params){
               if (route1.params[key] != route2.params[key]){
                   return false;
               }
           }
           return true;
       },
       setTab(route){
           if (!this.historys.some(item => this.isSame(item, route))){
               const obj = {};
               obj.name = route.name;
               obj.meta = route.meta;
               obj.query = route.query;
               obj.params = route.params;
               this.historys.push(obj);
               console.log(route)
           }
           window.sessionStorage.setItem(
               "activeValue",
               getFmtString(this.$route)
           );
       },
       changeTab(component){
           const tab = component.$attrs.tab;
           //console.log(tab.name,tab.query,tab.params);
           this.$router.push({
               name: tab.name,
               query: tab.query,
               params: tab.params
           });
           //console.log(this.$router)
       },
   }
}
</script>