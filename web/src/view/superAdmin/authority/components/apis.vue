<template>
    <div>
        <div class="clearflex">
            <el-button class="fl-right" size="small" type="primary">确 定</el-button>
        </div>
        <el-tree
            :data="apiTreeData"
            :default-checked-keys="apiTreeIds"
            :props="apiDefaultProps"
            @check="nodeChange"
            show-checkbox
            ref="menuTree"
            node-key="ID">
        </el-tree>
    </div>
</template>
<script>
import { getAllApis } from '@/api/api'
export default {
    name: 'Apis',
    data(){
        return {
            apiTreeData: [],
            apiTreeIds: [],
            needConfirm: false,
            apiDefaultProps: {
                children: 'children',
                label: 'description'
            }
        }
    },
    methods: {
        nodeChange(){
            this.needConfirm = true
        },
        buildApiTree(apis) {
            const apiObj = new Object()
        }
    },
    async created(){
        const res2 = await getAllApis()
        console.log(res2)
        //const apis = res2.data.apis
        //this.apiTreeData = this.buildApiTree(apis)
        //const res = await getPolicyPathByAuthorityId({
        //    authorityId: this.row.authorityId
        //})
        
    }
}
</script>