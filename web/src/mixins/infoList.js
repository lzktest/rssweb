import { getDict } from "@/utils/dictionary"
export default {
    data(){
        return {
            page: 1,
            total: 10,
            pageSize: 10,
            tableData: [],
            searchInfo: {}
        }
    },
    methods: {
        async getDict(type){
            const dicts = await getDict(type)
            this[type + "Options"] = dicts
            return dicts
        },
        handleSizeChange(val){
            this.pageSize = val
            this.getTableData()
        },
        handleCurrentChange(val){
            this.page = val
            this.getTableData()
        },
        async getTableData(page = this.page, pageSize = this.pageSize){
            const table =await this.listApi({ page, pageSize, ...this.searchInfo })
            if (table.Code == 0 ){
                this.tableData = table.Data.list
                this.total = table.Data.total
                this.page = table.Data.page
                this.pageSize = table.Data.pageSize
            }
        }
    }
}