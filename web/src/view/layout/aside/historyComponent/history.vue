<template>
    <div class="router-history">
        <el-tabs 
            v-model="activeValue"
            type="card"
            :closable="!(this.$route.name==defaultRouter)"
            >
            <el-tab-pane
                :key="item.name + JSON.stringify(item.query)+JSON.stringify(item.params)"
                :label="item.meta.title"
                :name="item.name + JSON.stringify(item.query)+JSON.stringify(item.params)"
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
      }
  },
  computed: {
      ...mapGetters("user",["userInfo"]),
      defaultRouter() {
          return this.userInfo.authority.defaultRouter;
      }
  },
   
}
</script>