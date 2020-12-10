<template>
    <div id="loginapp">
    <el-form :model="loginForm" ref="loginForm" @keyup.enter.native="submitForm">
      <el-form-item label="用户名" prop="username">
        <el-input v-model="loginForm.username" placeholder="请输入用户名"></el-input>
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input v-model="loginForm.password" placeholder="请输入密码"></el-input>
      </el-form-item>
      <el-form-item label="验证码" prop="">
        <el-input v-model="loginForm.captcha" name="logVerify" placeholder="请输入验证码"></el-input>
        <img v-if="path" :src="path + picPath" alt="请输入验证码" @click="loginVefify()"/>
      </el-form-item>
      <el-form-item>
        <div class="grid-content bg-purple"><el-button type="primary" style="width:100%" @click="submitForm">登录</el-button></div><!--  -->
      </el-form-item>
    </el-form>
    </div>
</template>

<script>
import { mapActions } from "vuex"
import { captcha } from "@/api/user"
const path = process.env.VUE_APP_BASE_API;
export default {
    name: "Login",
    data(){
        return{
        loginForm:{
          username: 'admin',
          password: '123456',
          captcha: '',
          captchaId: '',
        },
        picPath: '',
        logVerify: "",
        path: path,         
        }
    },
    created(){
      this.loginVefify();
    },
    methods: {
      ...mapActions("user", ["LoginIn"]),
      async login(){
        await this.LoginIn(this.loginForm);
      },
      async submitForm(){
        this.$refs.loginForm.validate(async (v) => {
          if (v) {
            this.login();
            this.loginVefify();
          } else {
            this.$message({
              type: "error",
              message: "请正确填写登录信息",
              showClose: true,
            });
            this.loginVefify();
            return false;
          }
        })
      },
      loginVefify(){
        captcha({}).then((ele) => {
          this.picPath = ele.data.picPath;
          this.loginForm.captchaId = ele.data.captchaId
        })

      }
    }

}
</script>

<style>
  #loginapp {
    margin: auto;
    width:400px;
  }
  .el-row {
    margin-bottom: 20px;
    &:last-child {
      margin-bottom: 0;
    }
  }
  .el-col {
    border-radius: 4px;
  }
  .bg-purple-dark {
    background: #99a9bf;
  }
  .bg-purple {
    background: #d3dce6;
  }
  .bg-purple-light {
    background: #e5e9f2;
  }
  .grid-content {
    border-radius: 4px;
    min-height: 40px;
  }
  .row-bg {
    padding: 10px 0;
    background-color: #f9fafc;
  }
</style>