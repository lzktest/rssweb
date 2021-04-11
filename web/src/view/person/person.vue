<template>
    <div>
        <el-row>
            <el-col :span="6">
                <div class="fl-left avatar-box">
                    <div class="user-card">
                        <el-avatar
                          class="user-avatar"
                          :size="160"
                          :src="userInfo.headerImg"
                          shape="square"
                          @click.native="openChooseImg"
                          ></el-avatar>
                          <div class="user-personality">
                              <p class="nickname">{{userInfo.nickName}}</p>
                              <p class="person-info">这个家伙很懒，什么都没有留下</p>
                          </div>
                          <div class="user-information">
                              <ul>
                                  <li>
                                      <i class="el-icon-user"></i>资深前端工程师
                                  </li>
                                  <li>
                                      <i class="el-icon-data-analysis"></i>aaa群
                                  </li>
                                  <li>
                                      <i class="el-icon-video-camera-solid"></i>成都
                                  </li>
                                  <li>
                                      <i class="el-icon-medal-1"></i>golang/vue/sql
                                  </li>
                              </ul>
                          </div>
                    </div>
                </div>
            </el-col>
            <el-col :span="18">
                <div class="user-addcount">
                    <el-tabs v-model="activeName">
                        <el-tab-pane label="账号绑定" name="second">
                            <ul>
                                <li>
                                    <p class="title">密保手机</p>
                                    <p class="desc">已绑定手机:1234567891<a href="#">立即修改</a></p>
                                </li>
                                <li>
                                    <p class="title">密保邮箱</p>
                                    <p class="desc">已绑定邮箱:1234567891<a href="#">立即修改</a></p>
                                </li>
                                <li>
                                    <p class="title">密保问题</p>
                                    <p class="desc">未设置密保问题<a href="#">立即设置</a></p>
                                </li>
                                <li>
                                    <p class="title">修改密码</p>
                                    <p class="desc">修改个人密码<a href="#">修改密码</a></p>
                                </li>
                            </ul>
                        </el-tab-pane>
                    </el-tabs>
                </div>
            </el-col>
        </el-row>
        <!-- <ChooseImg ref="chooseImg" @enter-img="enterImg" /> -->
    </div>
</template>
<script>
import { mapGetters, mapMutations } from 'vuex';
import { setUserInfo } from "@/api/user";
//import ChooseImg from "@/components/chooseImg";

const path = process.env.VUE_APP_BASE_API;
export default {
    name: "Person",
    data(){
        return {
            path: path,
            activeName: "second",

        }
    },
    computed:{
        ...mapGetters("user",["userInfo","token"])
    },
    methods: {
        ...mapMutations("user",["ResetUserInfo"]),
        openChooseImg(){
            this.$refs.chooseImg.open();
        },
        async enterImg(url){
            const res = await setUserInfo({ headerImg: url, ID: this.userInfo.ID });
            if (res.code == 0 ){
                this.ResetUserInfo({ headerImg: url });
                this.$message({
                    type: "success",
                    message: "设置成功"
                });
            }
        },
        handleClick(tab, event){
            console.log(tab, event);
        }
    }
};
</script>