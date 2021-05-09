<template>
    <div>
        <div class="button-box clearflex">
            <el-button @click="addUser" type="primary">新增用户</el-button>
        </div>
        <el-table :data="tableData" border stripe>
            <el-table-column label="头像" min-width="50">
                <template slot-scope="scope">
                    <CustomPic :picSrc="scope.row.headerImg" />
                </template>
            </el-table-column>
            <el-table-column label="uuid" min-width="250" prop="uuid"></el-table-column>
            <el-table-column label="用户名" min-width="150" prop="userName"></el-table-column>
            <el-table-column label="昵称" min-width="150" prop="nickName"></el-table-column>
            <el-table-column label="用户角色" min-width="150">
                <template slot-scope="scope">
                    <el-cascader
                        v-model="scope.row.authority.authorityId"
                        :options="authOptions"
                        :show-all-levels="false"
                        :props="{ checkStrictly: true,label:'authorityName',value:'authorityId',disabled:'disabled',emitPath:false}"
                        fileterable
                        ></el-cascader>
                </template>
            </el-table-column>
            <el-table-column label="操作" min-width="150">
                <template slot-scope="scope">
                    <el-popover placement="top" width="160" v-model="scope.row.visible">
                        <p>确定要删除此用户吗</p>
                        <div style="text-align: right; margin: 0">
                            <el-button size="mini" type="text">取消</el-button>
                            <el-button type="primary" size="mini" @click="deleteUser(scope.row)">确定</el-button>
                        </div>
                        <el-button type="danger" icon="el-icon-delete" size="small" slot="reference">删除</el-button>
                    </el-popover>
                </template>
            </el-table-column>
        </el-table>
        <el-pagination
            :current-page="page"
            :page-size="pageSize"
            :page-sizes="[10,30,50,100]"
            :style="{float:'right',padding:'20px'}"
            :total="total"
            layout="total, sizes, prev, pager, next, jumper"
        ></el-pagination>
        <el-dialog :visible.sync="addUserDialog" custom-class="user-dialog" title="新增用户">
            <el-form  ref="userForm" :model="userInfo">
                <el-form-item label="用户名" label-width="80px" prop="username">
                    <el-input v-model="userInfo.username"></el-input>
                </el-form-item>
                <el-form-item label="密码" label-width="80px" prop="password">
                    <el-input v-model="userInfo.password"></el-input>
                </el-form-item>
                <el-form-item label="别名" label-width="80px" prop="nickName">
                    <el-input v-model="userInfo.nickName"></el-input>
                </el-form-item>
                <el-form-item label="头像" label-width="80px">
                    <div style="display:inline-block" >
                        <img class="header-img-box" v-if="userInfo.headerImg" :src="userInfo.headerImg"/>
                        <div v-else class="header-img-box">从媒体库选择</div>
                    </div>
                </el-form-item>
                <el-form-item label="用户角色" label-width="80px" prop="authorityId">
                    <el-cascader
                        v-model="userInfo.authorityId"
                        :options="authOptions"
                        :show-all-levels="false"
                        :props="{ checkStrictly: true, label:'authorityName',value:'authorityId',disabled:'disabled',emitPath:false}"
                        filterable
                        ></el-cascader>
                </el-form-item>
            </el-form>
            <div class="dialog-footer" slot="footer">
                <el-button> 取消</el-button>
                <el-button @click="enterAddUserDialog" type="primary">确定</el-button>
            </div>
        </el-dialog>
    </div>
</template>
<script>
// 获取列表内容封装在mixins内部  getTableData方法 初始化已封装完成
const path = process.env.VUE_APP_BASE_API
import {
    getUserList,
    register,
    deleteUser,
} from "@/api/user"
import infoList from "@/mixins/infoList"
import { getAuthorityList } from "@/api/authority"
import { mapGetters } from 'vuex'
import CustomPic from "@/components/customPic"
export default {
    name: "Api",
    mixins: [infoList],
    components: { CustomPic },
    data(){
        return {
            listApi: getUserList,
            path: path,
            authOptions: [],
            addUserDialog: false,
            userInfo: {
                username: "",
                password: "",
                nickName: "",
                headerImg: "",
                authorityId: ""
            }
        }
    },
    computed: {
        ...mapGetters("user",["token"])
    },
    methods: {
        setOptions(authData){
            this.authOptions = []
            this.setAuthorityOptions(authData, this.authOptions)
        },
        setAuthorityOptions(AuthorityData, optionsData){
            AuthorityData &&
               AuthorityData.map(item => {
                   if (item.children && item.children.length){
                       const option = {
                           authorityId: item.authorityId,
                           authorityName: item.authorityName,
                           children: []
                       };
                       this.setAuthorityOptions(item.children, option.children);
                       optionsData.push(option);
                   } else {
                       const option = {
                           authorityId: item.authorityId,
                           authorityName: item.authorityName
                       };
                       optionsData.push(option);
                   }
               });
        },
        addUser(){
            this.addUserDialog = true;
        },
        async deleteUser(row){
            const res = await deleteUser({ id: row.ID });
            if (res.Code == 0){
                this.getTableData();
                row.visible = false;
            }
        },
        async enterAddUserDialog(){
            this.$refs.userForm.validate(async valid => {
                if(valid){
                    const res = await register(this.userInfo);
                    if (res.Code == 0){
                        this.$message({ type: "success", message: "创建成功" });
                    }
                    await this.getTableData();
                    this.closeAddUserDialog();
                }
            });
        },
        closeAddUserDialog(){
            this.$refs.userForm.resetFields();
            this.addUserDialog = false;
        }
    },
    async created(){
        this.getTableData();
        const res = await getAuthorityList({ page: 1, pageSize: 999 });
        this.setOptions(res.Data.list)
    }
}
</script>