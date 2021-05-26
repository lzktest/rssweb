<template>
    <div style="margin-left:10%;margin-right:10%;">
        <el-table :data="rssDatas" stripe>
            <el-table-column prop="xmltitle" label="标题" min-width="20"></el-table-column>
            <el-table-column prop="xmllink" label="源地址" min-width="40"></el-table-column>
            <el-table-column prop="id" label="生成rss地址" min-width="80">
                <template slot-scope="iditem">http://{{domain}}/v1/rss/getRssListXml?uuid={{iditem.row.id}}</template>
            </el-table-column>
        </el-table>
    </div>
</template>
<script>
import {
    getRssDataList
} from "@/api/rss";
export default {
    name:"rssview",
    data(){
        return{
            rssDatas:[],
            domain: window.location.host
        }
    },
    methods: {
        async getRssData(){
            const res = await getRssDataList();
            if (res.Code == 0){
                this.rssDatas = res.Data.rssDataList
            }else{
                this.$message({type:'warning',message:"获取rss数据失败"})
            }
        },
        async addRssData(){

        }
    },
    created(){
        this.getRssData()
    }
}
</script>
