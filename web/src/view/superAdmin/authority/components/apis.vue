<template>
    <div>
        <div class="clearflex">
            <el-button @click="authApiEnter" class="fl-right" size="small" type="primary">确 定</el-button>
        </div>
        <el-tree
            :data="apiTreeData"
            :default-checked-keys="apiTreeIds"
            :props="apiDefaultProps"
            @check="nodeChange"
            show-checkbox
            ref="apiTree"
            node-key="onlyId">
        </el-tree>
    </div>
</template>
<script>
import { getAllApis } from '@/api/api'
import { getPolicyPathByAuthorityId,UpdateCasbin } from '@/api/casbin'
export default {
    name: 'Apis',
    props: {
        row: {
            default: function(){
                return{}
            },
            type: Object
        }
    },
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
            apis && apis.map(item => {
                item.onlyId = "p:"+item.path+"m:"+item.method
                    if(Object.prototype.hasOwnProperty.call(apiObj,item.apiGroup)){
                        apiObj[item.apiGroup].push(item)
                    } else {
                        Object.assign(apiObj, { [item.apiGroup]: [item] })
                    }
            })
            const apiTree = []
            for (const key in apiObj){
                const treeNode = {
                    ID: key,
                    description: key + "组",
                    children: apiObj[key]
                }
                apiTree.push(treeNode)
            }
            return apiTree
        },
        // 关联关系确定
        async authApiEnter(){
            const checkArr = this.$refs.apiTree.getCheckedNodes(true)
            var casbinInfos = []
            checkArr&& checkArr.map(item => {
                var casbinInfo = {
                    path: item.path,
                    method: item.method
                }
                casbinInfos.push(casbinInfo)
            })
            const res = await UpdateCasbin({
                authorityId: this.activeUserId,
                casbinInfos
            })
            if (res.Code == 0){
                this.$message({ type: 'success', message: "api设置成功" })
            }
        },
    },    
    async created(){
        // 获取api并整理成树结构
        const res2 = await getAllApis()
        const apis = res2.Data.Apis
        //console.log(apis)
        this.apiTreeData = this.buildApiTree(apis)
        const res = await getPolicyPathByAuthorityId({
            authorityId: this.row.authorityId
        })
        //console.log(this.row.authorityId)
        this.activeUserId = this.row.authorityId
        this.apiTreeIds = []
        //console.log(res)
        res.Data.paths&&res.Data.paths.map(item => {
            this.apiTreeIds.push("p:"+item.path+"m:"+item.method)
        })
        //console.log(this.apiTreeIds)
    }
}
</script>