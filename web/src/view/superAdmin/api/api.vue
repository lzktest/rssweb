<template>
    <div>
        <div class="search-term">
            <el-form :inline="true" :model="searchInfo" class="demo-form-inline">
                <el-form-item label="路径">
                    <el-input placeholder="路径" v-model="searchInfo.path"></el-input>
                </el-form-item>
                <el-form-item label="描述">
                    <el-input placeholder="描述" v-model="searchInfo.description"></el-input>
                </el-form-item>
                <el-form-item label="api组">
                    <el-input placeholder="api组" v-model="searchInfo.apiGroup"></el-input>
                </el-form-item>
                <el-form-item label="请求">
                    <el-select clearable placeholder="请选择" v-model="searchInfo.method">
                        <el-option
                            :key="item.value"
                            :label="`${item.label}(${item.value})`"
                            :value="item.value"
                            v-for="item in methodOptions"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item>
                    <el-button @click="onSubmit" type="primary">查询</el-button>
                </el-form-item>
                <el-form-item>
                    <el-button @click="openDialog('addApi')" type="primary">新增api</el-button>
                </el-form-item>
                <el-form-item>
                    <el-popover placement="top" width="160">
                        <p>确定要删除吗?</p>
                        <div style="text-align: right; margin: 0">
                            <el-button size="mini" type="text">取消</el-button>
                            <el-button @click="onDelete" size="mini" type="primary">确定</el-button>
                        </div>
                        <el-button icon="el-icon-delete" size="mini" slot="reference" type="danger">批量删除</el-button>
                    </el-popover>
                </el-form-item>
            </el-form>
        </div>
        <el-table :data="tableData"  border stripe @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55"></el-table-column>
            <el-table-column label="id" min-width="60" prop="ID" sortable="custom"></el-table-column>
            <el-table-column label="api路径" min-width="150" prop="path" sortable="custom"></el-table-column>
            <el-table-column label="api分组" min-width="150" prop="apiGroup" sortable="custom"></el-table-column>
            <el-table-column label="api简介" min-width="150" prop="description" sortable="custom"></el-table-column>
            <el-table-column label="请求" min-width="150" prop="method" sortable="custom">
                <template slot-scope="scope">
                    <div>
                        {{scope.row.method}}
                        <el-tag
                            :key="scope.row.methodFiletr"
                            :type="scope.row.method|tagTypeFiletr"
                            effect="dark"
                            size="mini">
                            {{scope.row.method|methodFiletr}}</el-tag>
                    </div>
                </template>
            </el-table-column>
            <el-table-column fixed="right" label="操作" width="200">
                <template slot-scope="scope">
                    <el-button @click="editApi(scope.row)" size="small" type="primary" icon="el-icon-edit">编辑</el-button>
                    <el-button @click="deleteApi(scope.row)" size="small" type="danger" icon="el-icon-delete">删除</el-button>
                </template>
            </el-table-column>
        </el-table> 
        <el-dialog :title="dialogTitle" :visible.sync="dialogFormVisible">
            <el-form :inline="true" :model="form" label-width="80px" ref="apiForm">
                <el-form-item label="路径" prop="path">
                    <el-input autocomplete="off" v-model="form.path"></el-input>
                </el-form-item>
                <el-form-item label="请求" prop="method">
                    <el-select placeholder="请选择" v-model="form.method">
                        <el-option 
                            :key="item.value" 
                            :label="`${item.label}(${item.value})`"
                            :value="item.value"
                            v-for="item in methodOptions">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="api分组" prop="apiGroup">
                    <el-input autocomplete="off" v-model="form.apiGroup"></el-input>
                </el-form-item>
                <el-form-item label="api简介" prop="description">
                    <el-input autocomplete="off" v-model="form.description"></el-input>
                </el-form-item>
            </el-form>
            <div class="warning">新增Api需要在角色管理内配置权限才可使用</div>
            <div class="dialog-footer" slot="footer">
                <el-button >取消</el-button>
                <el-button @click="enterDialog" type="primary"> 确定</el-button>
            </div>
        </el-dialog>
    </div>
</template>
<script>
import {
    getApiList,
    createApi,
    deleteApisByIds,
    deleteApi,
    getApiById,
    updateApi,
} from "@/api/api";
import infoList from "@/mixins/infoList";
const methodOptions = [
    {
        value:"POST",
        label:"创建",
        type: "success"
    },
    {
        value:"GET",
        label:"查看",
        type:"",
    },
    {
        value:"PUT",
        label:"更新",
        type: "warning"
    },
    {
        value:"DELETE",
        label:"删除",
        type: "danger"
    }
];
export default {
    name: "Api",
    mixins: [infoList],
    data(){
        return {
            listApi:getApiList,
            dialogTitle: "新增Api",
            dialogFormVisible: false,
            apis:[],
            methodOptions: methodOptions,
            form: {
                path: "",
                apiGroup: "",
                method: "",
                description: ""
            },
            
        }
    },
    methods: {
        // 选中api
        handleSelectionChange(val){
            this.apis = val;
        },
        async onDelete(){
            const ids = this.apis.map(item=> item.ID)
            const res = await deleteApisByIds({ids})
            if(res.Code==0){
                this.$message({
                    type: "success",
                    message: res.Msg
                })
                if (this.tableData.length == ids.length){
                    this.page--;
                }
                this.deleteVisible = false
                this.getTableData()
            }else{
                this.$message({
                    type: "warning",
                    message: res.Msg
                })
            }
        },
        onSubmit(){
            this.page =1 ;
            this.pageSize = 10;
            this.getTableData();
        },
        initForm(){
            this.$refs.apiForm.resetFields();
            this.form = {
                path: "",
                apiGroup: "",
                method: "",
                description: ""
            };
        },
        closeDialog(){
            this.initForm();
            this.dialogFormVisible = false;
        },
        openDialog(type){
            switch (type) {
                case "addApi":
                    this.dialogTitle = "新增Api";
                    break;
                case "edit":
                    this.dialogTitle = "编辑Api";
                    break;
                default:
                    break;
            }
            this.type = type;
            this.dialogFormVisible = true;
        },
        async editApi(row){
            const res = await getApiById({ id: row.ID });
            this.form = res.Data.api;
            this.openDialog("edit");
        },
        async deleteApi(row){
            this.$confirm("此操作将永久删除所有角色下该api, 是否继续？","提示",{
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warnging"
            })
                .then(async () => {
                    const res = await deleteApi(row);
                    if (res.Code == 0){
                        this.$message({
                            type: "success",
                            message: "删除成功!"
                        });
                        if (this.tableData.length == 1){
                            this.page--;
                        }
                        this.getTableData();
                    }
                })
                .catch(() =>{
                    this.$message({
                        type: "info",
                        message: "已取消删除"
                    });
                });
        },
        async enterDialog(){
            this.$refs.apiForm.validate(async valid => {
                if (valid) {
                    switch (this.type){
                        case "addApi":
                            {
                                const res = await createApi(this.form);
                                if (res.Code == 0){
                                    this.$message({
                                        type: "success",
                                        message:"添加成功",
                                        showClose: true
                                    });
                                } 
                                this.getTableData();
                                this.closeDialog();
                            }
                            break;
                        case "edit":
                            {
                                const res = await updateApi(this.form);
                                if (res.Code == 0){
                                    this.$message({
                                        type: "success",
                                        message: "编辑成功",
                                        showClose: true
                                    });
                                }
                                this.getTableData();
                                this.closeDialog();
                            }
                            break;
                        default:
                            {
                                this.$message({
                                    type: "error",
                                    message: "未知操作",
                                    showClose: true
                                });
                            }
                            break;
                    }
                }
            })
        }
    },
    filters: {
        methodFiletr(value){
            const target = methodOptions.filter(item => item.value === value)[0];
            return target && `${target.label}`;
        },
        tagTypeFiletr(value){
            const target = methodOptions.filter(item => item.value === value)[0];
            return target && `${target.type}`;
        }
    },
    created(){
        this.getTableData()
    }
}
</script>
