<template>
    <div class="authority">
      <div class="button-box clearflex">
          <el-button @click="addAuthority('0')" type="primary">新增角色</el-button>
      </div>
      <el-table 
        :data="tableData"
        :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
        row-key="authorityId"
        stripe
      >
        <el-table-column label="角色id" min-width="180" prop="authorityId"></el-table-column>
        <el-table-column label="角色名称" min-width="180" prop="authorityName"></el-table-column>
        <el-table-column  label="操作" width="500">
            <template slot-scope="scope">
                <el-button size="small" type="primary">设置权限</el-button>
                <el-button
                    @click="addAuthority(scope.row.authorityId)"
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
                    @click="editAuthority(scope.row)"
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
      <!-- 新增角色弹窗 -->
      <el-dialog :title="dialogTitle" :visible.sync="dialogFormVisible">
          <el-form :model="form" ref="authorityForm">
              <el-form-item label="父级角色" prop="parentId">
                  <el-cascader
                    :disabled="dialogType=='add'"
                    :options="AuthorityOption"
                    :props="{ checkStrictly: true,label:'authorityName',value:'authorityId',disabled:'disabled',emitPath:false }"
                    :show-all-levels="false"
                    filterable
                    v-model="form.parentId"
                    ></el-cascader>
              </el-form-item>
              <el-form-item label="角色ID" prop="authorityId">
                  <el-input :disabled="dialogType=='edit'" autocomplete="off" v-model="form.authorityId"></el-input>
              </el-form-item>
              <el-form-item label="角色姓名" prop="authorityName">
                  <el-input autocomplete="off" v-model="form.authorityName"></el-input>
              </el-form-item>
          </el-form>
          <div class="dialog-footer" slot="footer">
              <el-button @click="closeDialog">取 消</el-button>
              <el-button @click="enterDialog" type="primary">确 定</el-button>
          </div>
      </el-dialog>
    </div>
</template>
<script>
// 获取列表内容封装在mixins内部  getTableData方法  初始化已封装完成
import {
    getAuthorityList,
    createAuthority,
    updateAuthority,
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
            dialogTitle: "新增角色",
            dialogType: "add",
            dialogFormVisible: false,
            form: {
                authorityId: "",
                authorityName: "",
                parentId: "0"
            },
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
        // 关闭窗口
        closeDialog(){
            this.initForm();
            this.dialogFormVisible = false;
            this.apiDialogFlag = false;
        },
        // 确定弹窗
        async enterDialog(){
            if (this.form.authorityId == "0") {
                this.$message({
                    type: "error",
                    message: "角色id不能为0"
                });
                return false;
            }
            this.$refs.authorityForm.validate(async valid => {
                if (valid){
                    switch (this.dialogType){
                        case "add":
                            {
                                console.log("test")
                                const res = await createAuthority(this.form);
                                console.log(res)
                                if (res.Code == 0){
                                    this.$message({
                                        type: "success",
                                        message: "添加成功!"
                                    });
                                    this.getTableData();
                                    this.closeDialog();
                                }
                            }
                            break;
                        case "edit":
                            {
                                const res = await updateAuthority(this.form);
                                if (res.Code ==0){
                                    this.$message({
                                        type: "success",
                                        message: "修改成功!"
                                    });
                                    this.getTableData();
                                    this.closeDialog();
                                }
                            }
                            break;
                    }
                    this.initForm();
                    this.dialogFormVisible = false;
                }
                
            })
        },
        setOptions(){
            this.AuthorityOption = [{
                authorityId: "0",
                authorityName: "根角色"
            }];
            this.setAuthorityOptions(this.tableData, this.AuthorityOption, false);
            
        },
        setAuthorityOptions(AuthorityData, optionsData, disabled){
            this.form.authorityId = String(this.form.authorityId);
            AuthorityData &&
              AuthorityData.map(item => {
                  if (item.children && item.children.length){
                      const option = {
                          authorityId: item.authorityId,
                          authorityName: item.authorityName,
                          disabled: disabled || item.authorityId == this.form.authorityId,
                          children: []
                      };
                      this.setAuthorityOptions(
                          item.children,
                          option.children,
                          disabled || item.authorityId == this.form.authorityId
                      );
                      optionsData.push(option);
                  } else {
                      const option = {
                          authorityId: item.authorityId,
                          authorityName: item.authorityName,
                          disabled: disabled || item.authorityId == this.form.authorityId,
                      };
                      optionsData.push(option);
                  }
                  
              });
        },
        editAuthority(row){
            this.setOptions();
            this.dialogTitle = "编辑角色";
            this.dialogType = "edit";
            for (let key in this.form){
                this.form[key] = row[key];
            }
            this.setOptions();
            this.dialogFormVisible = true;
        }
        
    },
    async created(){
            this.pageSize = 999;
            await this.getTableData();
    }
}
</script>