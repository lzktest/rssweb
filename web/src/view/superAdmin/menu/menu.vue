<template>
    <div>
        <div class="button-box clearflex">
            <el-button @click="addMenu('0')" type="primary"> 新增根菜单</el-button>
        </div>
        <!-- 由于此处菜单跟左侧列表一一对应所以不需要分页 pageSize默认999 -->
        <el-table :data="tableData" border row-key="ID" stripe>
            <el-table-column label="ID" min-width="100" prop="ID"></el-table-column>
            <el-table-column label="路由Name" min-width="160" prop="name"></el-table-column>
            <el-table-column label="路由Path" min-width="160" prop="path"></el-table-column>
            <el-table-column label="是否隐藏" min-width="100" prop="hidden">
                <template slot-scope="scope">
                    <span>{{scope.row.hidden?"隐藏":"显示"}}</span>
                </template>
            </el-table-column>
            <el-table-column label="父节点" min-width="90" prop="parentId"></el-table-column>
            <el-table-column label="排序" min-width="70" prop="Sort"></el-table-column>
            <el-table-column label="文件路径" min-width="360" prop="component"></el-table-column>
            <el-table-column label="展示名称" min-width="120" prop="authorityName">
                <template slot-scope="scope">
                    <span> {{scope.row.meta.title}}</span>
                </template>
            </el-table-column>
            <el-table-column label="图标" min-width="140" prop="authorityName">
                <template slot-scope="scope">
                    <i :class="`el-icon-${scope.row.meta.icon}`"></i>
                    <span>{{scope.row.meta.icon}}</span>
                </template>
            </el-table-column>
            <el-table-column fixed="right" label="操作" width="300">
                <template slot-scope="scope">
                    <el-button 
                      size="small" 
                      type="primary" 
                      icon="el-icon-edit"
                    >添加子菜单</el-button>
                    <el-button
                        size="small"
                        type="primary"
                        icon="el-icon-edit"
                        >编辑</el-button>
                    <el-button
                        size="small"
                        type="danger"
                        icon="el-icon-delete"
                        >删除</el-button>
                </template>
            </el-table-column>
        </el-table>
        <el-dialog :title="dialogTitle">
            <el-form
              :inline="true"
              :moel="form"
              label-position="top"
              label-width="85px"
              ref="menuForm">
              <el-form-item label="路由name" prop="path" style="width:30%">
                  <el-input
                    autocomplete="off"
                    placeholder="唯一英文字符串"
                    v-model="form.name"></el-input>
              </el-form-item>
              <el-form-item prop="path" style="width:30%">
                  <div style="display:inline-block" slot="label">
                      路由path
                      <el-checkbox style="float:right;margin-left:20px;" v-model="checkFlag">添加参数</el-checkbox>
                  </div>
                  <el-input
                    autocomplete="off"
                    placeholder="建议只在后方拼接参数"
                    v-model="form.path"></el-input>
              </el-form-item>
              <el-form-item label="是否隐藏" style="width:30%">
                  <el-select placeholder="是否在列表隐藏" v-model="form.hidden">
                      <el-option :value="false" label="否"></el-option>
                      <el-option :value="true" label="是"></el-option>
                  </el-select>
              </el-form-item>
              <el-form-item label="父节点Id" style="width:30%">
                  <el-cascader
                    :disabled="!this.isEdit"
                    :options="menuOption"
                    :props="{ checkStrictly: true,label:'title',value:'ID',disabled:'disabled',emitPath:false}"
                    :show-all-levels="false"
                    filterable
                    v-model="form.parentId"></el-cascader>
              </el-form-item>
              <el-form-item label="文件路径" prop="component" style="width:60%">
                  <el-input autocomplete="off" v-model="form.component"></el-input>
                  <span style="font-size:12px;margin-right:12px;">如果菜单包含子菜单，请创建router-view二级路由页面或</span>
                  <el-button size="mini" >点我设置</el-button>
              </el-form-item>
              <el-form-item label="展示名称" prop="meta.title" style="width:30%">
                  <el-input autocomplete="off" v-model="form.meta.title"></el-input>
              </el-form-item>
              <el-form-item label="图标" prop="meta.icon" style="width:30%">
                  <icon :meta="form.meta">
                      <template slot="prepend">el-icon-</template>
                  </icon>
              </el-form-item>
              <el-form-item label="排序标记" prop="Sort" style="width:30%">
                  <el-input autocomplete="off" v-model.number="form.Sort"></el-input>
              </el-form-item>
              <el-form-item label="keepAlive" prop="meta.keepAlive" style="width:30%">
                  <el-select placeholder="是否keepAlive缓存页面" v-model="form.meta.keepAlive">
                      <el-option :value="false" label="否"> </el-option>
                      <el-option :value="true" label="是"> </el-option>
                  </el-select>
              </el-form-item>
              <el-form-item label="closeTab" prop="meta.closeTab" style="width:30%">
                  <el-select placeholder="是否自动关闭tab" v-model="form.meta.closeTab">
                      <el-option :value="false" label="否"></el-option>
                      <el-option :value="true" label="是"></el-option>
                  </el-select>
              </el-form-item>
            </el-form>
        </el-dialog>
    </div>
</template>
<script>
import { 
    getMenuList,
} from "@/api/menu";
import infoList from "@/mixins/infoList";
export default {
    name: "Menus",
    mixins: [infoList],
    data(){
        return {
            checkFlag: false,
            listApi: getMenuList,
            dialogFormVisible: false,
            dialogTitle: "新增菜单",
            menuOption:[
                {
                    ID: "0",
                    title: "根菜单"
                }
            ],
            form: {
                ID: 0,
                path: "",
                name:"",
                hidden: "",
                parentId: "",
                component:"",
                meta: {
                    title: "",
                    icon: "",
                    defaultMenu: false,
                    closeTab: false,
                    keepAlive: false
                },
                parameters: []
            },
            isEdit: false
        }
    },
    methods: {
        setOptions(){
            this.menuOption = [
                {
                    ID: "0",
                    title: "根目录"
                }
            ];
        },
        addMenu(id){
            this.dialogTitle = "新增菜单";
            this.form.parentId = String(id);
            this.isEdit = false;
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