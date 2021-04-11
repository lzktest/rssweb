<template>
    <el-drawer title="媒体库" :visible.sync="drawer">
        <div style="display:flex;justify-content:space-around;flex-wrap:wrap;padding-top:40px">
            <el-image
              class="header-img-box-list"
              :src="item.url"
              v-for="(item,key) in picList"
              :key = "key"
              @click.native="chooseImg(item.url,target,targetKey)"
              >
              <div slot="error" class="header-img-box-list">
                  <i class="el-icon-picture-outline"></i>
              </div>
            </el-image>
        </div>
    </el-drawer>
</template>
<script>
export default {
    
}
</script>