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

                    </el-select>
                </el-form-item>
                <el-form-item>
                    <el-button  type="primary">查询</el-button>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary">新增api</el-button>
                </el-form-item>
                <el-form-item>

                </el-form-item>
            </el-form>
        </div>
        <el-table :data="tableData"  border stripe>
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
                            :key="scope.row.methodFileter"
                            :type="scope.row.method|tagTypeFiletr"
                            effect="dark"
                            size="mini">
                            {{scope.row.method|methodFileter}}</el-tag>
                    </div>
                </template>
            </el-table-column>
        </el-table> 
    </div>
</template>
<script>
import {
    getApiList,
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
            apis:[],
            
        }
    },
    created(){
        this.getTableData()
    }
}
</script>
