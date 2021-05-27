<template>
    <div>
        <div class="search-term">
            <el-form :inline="true" :model="searchRss" class="demo-form-inline">
                <el-form-item label="id">
                    <el-input placeholder="id" v-model="searchRss.Id"></el-input>
                </el-form-item>
                <el-form-item label="标题">
                    <el-input placeholder="title" v-model="searchRss.Title"></el-input>
                </el-form-item>
                <el-form-item label="描述">
                    <el-input placeholder="id" v-model="searchRss.Description"></el-input>
                </el-form-item>
                <el-form-item label="源地址">
                    <el-input placeholder="title" v-model="searchRss.Link"></el-input>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary">查询</el-button>
                </el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="openDialog('addRsssource')">新增rss</el-button>
                </el-form-item>
                <el-form-item>
                    <el-popover placeholder="top" width="160" v-model="deleteVisible">
                        <p>确定要删除吗？</p>
                        <div style="text-align: right; margin: 0" >
                            <el-button size="mini" type="text">取消</el-button>
                            <el-button @click="onDelete" size="mini" type="primary">确定</el-button>
                        </div>
                        <el-button icon="el-icon-delete" size="mini" slot="reference" type="danger">批量删除</el-button>
                    </el-popover>
                </el-form-item>
            </el-form>
            <div>
                <input type="file" ref="uploadxml" >
                <el-button size="mini" @click="readXML" type="primary">开始导入</el-button>
            </div>
        </div>
        <el-table :data="rssDatas" border strip @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55"></el-table-column>
            <el-table-column label="id" min-width="30" prop="id" sortable="custom"></el-table-column>
            <el-table-column label="标题" min-width="30" prop="xmltitle" sortable="custom"></el-table-column>
            <el-table-column label="描述" min-width="50" prop="xmldescription" sortable="custom"></el-table-column>
            <el-table-column label="源地址" min-width="30" prop="xmllink" sortable="custom"></el-table-column>
            <el-table-column label="类型" min-width="20" prop="xmltype" sortable="custom"></el-table-column>
            <el-table-column label="间隔时长" min-width="20" prop="cycletime" sortable="custom">
                <template slot-scope="cyclescope">
                    <div>
                        {{cyclescope.row.cycletime}}分钟
                    </div>
                </template>
            </el-table-column>
            <el-table-column label="启用状态" min-width="20" prop="status" sortable="custom">
                <template slot-scope="statusscope">
                    <div>
                    <i class="el-icon-check" v-if="statusscope.row.status"></i>
                    <i class="el-icon-close" v-else></i>
                    </div>
                </template>
            </el-table-column>
            <el-table-column fixed="right" label="操作" width="200">
                <template slot-scope="clickscope">
                    <el-button @click="editRssId(clickscope.row)" size="small" type="primary" icon="el-icon-edit">编辑</el-button>
                    <el-button @click="deleteRssId(clickscope.row)" size="small" type="danger" icon="el-icon-delete">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <el-dialog title="添加源地址" :visible.sync="dialogVisible">
            <el-form  :model="form" label-width="80px" ref="addsource">
                <el-form-item label="标题">
                    <el-input v-model="form.xmltitle"></el-input>
                </el-form-item>
                <el-form-item label="源地址">
                    <el-input v-model="form.xmllink"></el-input>
                </el-form-item>
                <el-form-item label="描述">
                    <el-input v-model="form.xmldescription"></el-input>
                </el-form-item>
                <el-form-item label="使用状态">
                    <el-switch v-model="form.status" active-color="#13ce66"  inactive-color="#ff4949"></el-switch>
                </el-form-item>
                <el-form-item label="type">
                    <el-select v-model="form.xmltype" placeholder="请选择类型">
                        <el-option label="rss-xml" value="rss-xml"></el-option>
                        <el-option label="atom-xml" value="atom-xml"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="更新周期(分钟)">
                    <el-input v-model="form.cycletime"></el-input>
                </el-form-item>
            </el-form>
            <div class="dialog-footer" slot="footer">
                <el-button @click="enterDialog" type="primary">确定</el-button>
            </div>
        </el-dialog>
    </div>
</template>
<script>
// 获取列表内容封装在mixins内部  getTableData方法 初始化已封装完成 条件搜索时候 请把条件安好后台定制的结构体字段 放到 this.searchInfo 中即可实现条件搜索

import {
    getRssDataList,
    getRssDataListById,
    addRssDataList,
    deleteRssDataList,
    updateRssDataList,
    loadRssDataList,
} from "@/api/rss";
export default {
    name:"RssManager",
    data(){
        return {
            dialogVisible: false,
            dialogTitle:"新增rss source",
            rssDatas:[],
            rssids:[],
            deleteVisible:false,
            searchRss: {
                Id: "",
                Title: "",
                Description: "",
                Link:"",
            },
            form:{
                xmltype:"",
                xmltitle:"",
                xmldescription: "",
                xmllink:"",
                status:"",
                cycletime:""
            }
        }
    },
    methods: {
        async readXML(){
            let filepath = this.$refs.uploadxml.files[0]
            let reader = new FileReader();
            reader.readAsText(filepath, "UTF-8");
            reader.onload = function(evt){
                var fileString = evt.target.result;
                var xmlDoc = null;
                var loadRssList = [];
                var parser = new DOMParser();
                xmlDoc = parser.parseFromString(fileString,"text/xml");
                var xmlnode = xmlDoc.getElementsByTagName("outline");
                for (var i=0; i<xmlnode.length;i++){
                    var outline = xmlnode[i];
                    loadRssList.push({
                        title: outline.attributes.title.nodeValue,
                        type: outline.attributes.type.nodeValue,
                        xmlUrl: outline.attributes.xmlUrl.nodeValue,
                        htmlUrl: outline.attributes.htmlUrl.nodeValue,
                    });
                }
                console.log(loadRssList)
                loadRssDataList({ loadRssList })
            };            
        },
        //选中rss
        handleSelectionChange(val){
            this.rssids = val;
        },
        async onDelete(){
            const ids = this.rssids.map(item => item.id)
            const res = await deleteRssDataList({ids})
            if (res.Code==0){
                this.$message({
                    type: "success",
                    message: res.Msg
                })
                this.deleteVisible = false
                this.getRssData()
            } else {
                this.$message({
                    type: "warning",
                    message: res.Msg
                })
            }
        },
        openDialog(type){
            switch(type){
                case "addRsssource":
                    this.dialogTitle="新增rss source";
                    break;
                default:
                    break;
            }
            this.type = type;
            this.dialogVisible = true;
        },
        initForm(){
            this.$refs.addsource.resetFields();
            this.form = {
                Type:"",
                Title:"",
                Description: "",
                Link:"",
                Cycletime:""
            }
        },
        closeDialog(){
            this.initForm();
            this.dialogVisible=false;
        },
        async editRssId(row){
            const res = await getRssDataListById({id: row.id});
            this.form = res.Data;
            this.openDialog("editRsssource")
        },
        async getRssData(){
            const res = await getRssDataList();
            if (res.Code == 0){
                this.rssDatas = res.Data.rssDataList
            }else{
                this.$message({type:'warning',message:"获取rss数据失败"})
            }
        },
        async deleteRssId(row){
            this.$confirm("此操作将永久删除源及其历史数据，是否继续？","提示",{
                confirmButtonText:"确定",
                cancelButtonText:"取消",
                type: "warnging"
            })
            .then(
                async () => {
                    let ids = [] 
                    ids.push(row.id)
                    const res = await deleteRssDataList({ids});
                    if (res.Code==0){
                        this.$message({
                            type: "success",
                            message: "删除成功"
                        });
                        
                    }
                    this.getRssData();
                }
            ).catch(() =>{
                this.$message({
                    type: "info",
                    message: "已取消删除"
                });
            });
        },
        async enterDialog(){
            switch (this.type){
                case "addRsssource":
                    {
                        const res = addRssDataList(this.form);
                        if (res.Code == 0){
                            this.$message({
                                type: "success",
                                message: "添加成功",
                                showClose: true
                            });
                        }
 
                        this.getRssData();
                        this.closeDialog();
                    }
                    break;
                case "editRsssource":
                    {
                        const res = updateRssDataList(this.form);
                        if (res.Code == 0){
                            this.$message({
                                type: "success",
                                message: "修改成功",
                                showClose: true
                            });
                        }
 
                        this.getRssData();
                        this.closeDialog();
                    }
                    break;
            }
        }
    },
    created(){
        this.getRssData()
    }
}
</script>