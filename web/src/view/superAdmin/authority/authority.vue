<template>
    <div class="authority">
      <div class="button-box clearflex">
          <el-button @click="addAuthority('0')" type="primary">新增角色</el-button>
      </div>
      <el-table 
        :data="tableData"
        :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
        row-key="authorityId"
      >
        <el-table-column label="角色id" min-width="180" prop="authorityId"></el-table-column>
        <el-table-column label="角色名称" min-width="180" prop="authorityName"></el-table-column>
        <el-table-column fixed="right" label="操作" width="400">
            <template slot-scope="scope">
                <el-button size="small" type="primary">设置权限</el-button>
                <el-button
                    icon="el-icon-plus"
                    size="small"
                    type="primary"
                    >新增子角色</el-button>
                <el-button
                    icon="el-icon-copy-document"
                    size="small"
                    type="primary"
                    >拷贝</el-button>
                <el-button
                    icon="el-cion-edit"
                    size="small"
                    type="primary"
                    >编辑</el-button>
                <el-button
                    icon="el-icon-delete"
                    size="small"
                    type="danger"
                    >删除</el-button>
            </template>
        </el-table-column>
      </el-table>
    </div>
</template>
<script>
// 获取列表内容封装在mixins内部  getTableData方法  初始化已封装完成
import {
    getAuthorityList,
} from "@/api/authority"

import infoList from "@/mixins/infoList"
export default {
    name: "Authority",
    mixins: [infoList],
    data(){
        var mustUint = (rule, value, callback) => {
            if (!/^[0-9]*[1-9][0-9]*$/.test(value)){
                return callback(new Error("请输入正整数"));
            }
            return callback();
        };
        return {
            AuthorityOption:[
                {
                    authorityId: "0",
                    authorityName: "根角色"
                }
            ],
            listApi: getAuthorityList,
        }
    },
    methods: {
        addAuthority(parentId){
            this.initForm();
            this.dialogTitle = "新增角色";
            this.dialogType = "add";
            this.form.parentId =parentId;
            this.dialogFormVisible = true;
        },
        initForm(){
            if (this.$refs.authorityForm){
                this.$refs.authorityForm.resetFields()
            }
            this.form = {
                authorityId: "",
                authorityName: "",
                parentId: "0"
            };
        },
        setOptions(){
            this.AuthorityOption = [{
                authorityId: "0",
                authorityName: "根角色"
            }];
            
        }
        
    },
    async created(){
            this.pageSize = 999;
            await this.getTableData();
    }
}
</script>