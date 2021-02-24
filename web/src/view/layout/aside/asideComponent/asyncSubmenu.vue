<template>
  <el-submenu :popper-append-to-body="true" ref="subMenu" :index="routerInfo.name">
    <template slot="title">
      <i :class="'el-icon-'+routerInfo.meta.icon"></i>
      <span slot="title">{{routerInfo.meta.title}}</span>
    </template>
    <MenuItem class="menuItem" :key="item.name" :routerInfo="item" v-for="item in routerInfo.children"/>
  </el-submenu>
</template>
<script>
import MenuItem from "@/view/layout/aside/asideComponent/menuItem";

export default {
  name: 'AsyncSubmenu',
  props: {
    routerInfo: {
      default: function(){
        return null
      },
      type: Object
    }
  },
  // created(){
  //   console.log('bbb')
  //   console.log(this.routerInfo.name)
  //   console.log(this.routerInfo)
  //   console.log('ccc')
  // },
  components: {
    MenuItem
  }
}
</script>
<!--<style>-->
<!--.el-menu-vertical{-->
<!--  width: 100%;-->
<!--  background: #191a23;-->
<!--}-->
<!--</style>-->