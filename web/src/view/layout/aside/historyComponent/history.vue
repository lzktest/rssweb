<template>
    <div class="router-history">
        <el-tabs 
            v-model="activeValue"
            type="card"
            @tab-click="changeTab"
            @tab-remove="removeTab"
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
          contextMenuVisible: false,
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
               
           }
           window.sessionStorage.setItem(
               "activeValue",
               getFmtString(this.$route)
           );
       },
       changeTab(component){
           const tab = component.$attrs.tab;
           this.$router.push({
               name: tab.name,
               query: tab.query,
               params: tab.params
           });
       },
       removeTab(tab){
           const index = this.historys.findIndex(
               item => getFmtString(item) == tab
           );
           if (
               getFmtString(this.$route) == tab
           ) {
               if (this.historys.length == 1){
                   this.$router.push({ name: this.defaultRouter });
               } else {
                   if (index < this.historys.length - 1 ){
                       this.$router.push({
                           name: this.historys[index + 1].name,
                           query: this.historys[index + 1].query,
                           params: this.historys[index + 1].params
                       });
                   } else {
                       this.$router.push({
                           name: this.historys[index - 1].name,
                           query: this.historys[index - 1].query,
                           params: this.historys[index - 1].params
                       });
                   }
               }
           }
           this.historys.splice(index, 1);
       }
   },
    watch: {
           contextMenuVisible(){
               if (this.contextMenuVisible){
                   document.body.addEventListener("click",() => {
                       console.log(this.contextMenuVisible);
                       this.contextMenuVisible = false;
                   });
               } else {
                   document.body.removeEventListener("click", ()=>{
                       this.contextMenuVisible = false;
                   });
               }
           },
           $route(to, now){
               this.historys = this.historys.filter(item => !item.meta.closeTab);
               this.setTab(to);
               sessionStorage.setItem("historys",JSON.stringify(this.historys));
               this.activeValue = window.sessionStorage.getItem("activeValue")
               if (now && to && now.name == to.name){
                   this.$bus.$emit("reload");
               }
           }
       }
}
</script>