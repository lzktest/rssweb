<template>
    <div id="scrn">
        <el-container>
          <el-aside class="main-cont main-left" :width="[isCollapse?'100px':'240px']">
            <div class="title">
              <h2 class="tit-text" >test project</h2>
              <Aside class="aside"/>
            </div>
          </el-aside>
          <el-container>
            <el-header>
              <el-row>
                <el-col :xs="2" :lg="1" :md="1" :sm="1" :xl="1">
                  <div @click="totalCollapse" class="menu-total">
                    <i class="el-icon-s-unfold" v-if="isCollapse"></i>
                    <i class="el-icon-s-fold" v-else></i>
                  </div>
                </el-col>
              </el-row>
              <el-row>
                <el-col>
                  <div>
                  bottominfo
                  </div>
                </el-col>
              </el-row>
            </el-header>
            <el-main>Main</el-main>
          </el-container>
        </el-container>
    </div>
</template>
<script>
import {mapActions} from "vuex";
import Aside from "./aside/index"

export default {
  name: "Layout",
  data(){
    return {
      isSider: false,
      isCollapse: false,
      isMobile: false,
      isShadowBg: false,
      value: ''
    }
  },
  components:{
    Aside,
  },
  methods: {
    ...mapActions('user', ['LoginOut']),
    totalCollapse() {
      this.isCollapse = !this.isCollapse
      this.isSider = !this.isCollapse
      this.isShadowBg = !this.isCollapse
      this.$bus.emit('collapse', this.isCollapse)
    },
  }
}
</script>

<style>
  .el-header {
    background-color: #B3C0D1;
    color: #333;
    text-align: center;
    height: 30%;
  }
  
  .el-aside {
    background-color: #191a23;
    color: #333;
    text-align: center;
    /*line-height: 100%;*/
    height: auto;
    width: auto;
  }

  
  .el-main {
    background-color: #E9EEF3;
    color: #333;
    text-align: center;
    height: 70%;
  }
  
  /*body > .el-container {*/
  /*  margin-top: 0px;*/
  /*}*/
  #app, body{
    margin-top: 0px;
    margin-bottom: 0px;
    height: 100%;
  }
  .el-container, html,#scrn{
    height: 100%;
  }
  /*.el-container:nth-child(5) .el-aside,*/
  /*.el-container:nth-child(6) .el-aside {*/
  /*  line-height: 260px;*/
  /*}*/
  
  /*.el-container:nth-child(7) .el-aside {*/
  /*  line-height: 320px;*/
  /*}*/
  .menu-total {
         float: left;
         width: 30px;
         height: 30px;
         line-height: 30px;
         font-size: 30px;
       }
</style>