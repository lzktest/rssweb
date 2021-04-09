<template>
    <div id="scrn">
        <el-container>
          <el-aside class="main-cont main-left" :width="isCollapse?'100px':'240px'">
            <div class="title">
              <h2 class="tit-text" >test project</h2>
              <Aside class="aside"/>
            </div>
          </el-aside>
          <el-container>
            <el-header>
              <el-row>
                <el-col :xs="1" :lg="1" :md='1' :sm="1" :xl="1">
                  <div @click="totalCollapse" class="menu-total">
                    <i class="el-icon-s-unfold" v-if="isCollapse"></i>
                    <i class="el-icon-s-fold" v-else></i>
                  </div>
                </el-col>
                <el-col :xs="23" :lg="23" :md='23' :sm="23" :xl="23" style="text-align: right;">
                    <el-dropdown >
                      <span class="el-dropdown-link" style="margin-left: 5px">
                        <img :src="userInfo.headerImg"/>
                        {{userInfo.nickName}}<i class="el-icon-arrow-down el-icon--right"></i>
                      </span>
                      <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item>
                          <span>
                            更多信息
                            <el-badge is-dot />
                          </span>
                        </el-dropdown-item>
                        <el-dropdown-item @click.native="toPerson" icon="el-icon-s-custom">个人信息</el-dropdown-item>
                        <el-dropdown-item @click.native="LoginOut" icon="el-icon-table-lamp">登出</el-dropdown-item>
                      </el-dropdown-menu>
                    </el-dropdown>
                </el-col>
              </el-row>
              
            </el-header>
            <el-main>
              <!-- <el-row>
                <el-col>
                  <el-tag v-for="item in matched.slice(1,matched.length)" :key="item.path" closable >
                    {{item.meta.title}}
                  </el-tag>
                </el-col>
              </el-row> -->

              <HistoryComponent />
              <el-row>
                <transition mode="out-in" name="el-fade-in-linear">
                  <keep-alive>
                    <router-view v-loading="loadingFlag" element-loading-text="正在加载中" class="admin-box" v-if="$route.meta.keepAlive && reloadFlag"></router-view>
                  </keep-alive>
                </transition>
                <transition>
                  <router-view v-loading="loadingFlag" element-loading-text="正在加载中" class="admin-box" v-if="!$route.meta.keepAlive && reloadFlag"></router-view>
                </transition>
                Main
              </el-row>
            </el-main>
          </el-container>
        </el-container>
    </div>
</template>
<script>
import {mapActions,mapGetters} from "vuex";
import Aside from "@/view/layout/aside/index"
import HistoryComponent from '@/view/layout/aside/historyComponent/history'
export default {
  name: "Layout",
  data(){
    return {
      isSider: false,
      isCollapse: false,
      isMobile: false,
      isShadowBg: false,
      loadingFlag: false,
      reloadFlag: true,
      value: ''
    }
  },
  components:{
    Aside,
    HistoryComponent,
  },
  methods: {
    ...mapActions('user', ['LoginOut']),
    reload(){
      this.reloadFlag =false
      this.$nextTick(()=>{
        this.reloadFlag = true
      })
    },
    totalCollapse() {
      this.isCollapse = !this.isCollapse
      this.isSider = !this.isCollapse
      this.isShadowBg = !this.isCollapse
      this.$bus.emit('collapse', this.isCollapse)
    },
    toPerson(){
      this.$router.push({ name: 'person' })
    }
  },
  computed: {
    ...mapGetters('user', ['userInfo']),
    title(){
      return this.$route.meta.title || '当前页面'
    },
    matched(){
      return this.$route.matched
    }
  },
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