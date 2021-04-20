<template>
    <div>
        <div class="clearflex">
            <el-button @click="relation" class="fl-right" size="small" type="primary">确 定
            </el-button>
        </div>
        <el-tree
            :data="menuTreeData"
            :default-check-keys="menuTreeIds"
            :props="menuDefaultProps"
            @check="nodeChange"
            show-checkbox
            ref="menuTree"
            node-key="ID"
            >
            <span class="custom-tree-node" slot-scope="{ node }">
                <span>{{ node.label }}</span>
            </span>
        </el-tree>
    </div>
</template>

<script>
import { getBaseMenuTree, getMenuAuthority, addMenuAuthority } from '@/api/menu'
export default {
    name: 'Menus',
    props: {
        row:{
            default: function(){
                return {}
            },
            type: Object
        }
    },
    data(){
        return {
            menuTreeData: [],
            menuTreeIds: [],
            needConfirm: false,
            menuDefaultProps: {
                children: 'children',
                label: function(data){
                    return data.meta.title
                }
            }
        }
    },
    methods: {
        nodeChange(){
            this.needConfirm = true
        },
        // 关联树  确认方法
        async relation(){
            const checkArr = this.$refs.menuTree.getCheckedNodes(false, true)
            const res = await addMenuAuthority({
                menus: checkArr,
                authorityId: this.row.authorityId
            })
            if (res.code == 0){
                this.$message({
                    type: 'success',
                    message: '菜单设置成功!'
                })
            }
        }
    },
    async created() {
        const res = await getBaseMenuTree()
        console.log(res)
        this.menuTreeData = res.Data.menus
        const res1 = await getMenuAuthority({ authorityId: this.row.authorityId })
        const menus = res1.Data.menus
        const arr = []
        if (menus){
            menus.map(item => {
            //防止直接选中父级造成全选
            if (!menus.some(same => same.parentId === item.menuId)){
                arr.push(Number(item.menuId))
            }
        })
        }
        
        this.menuTreeIds = arr
    }
}
</script>
