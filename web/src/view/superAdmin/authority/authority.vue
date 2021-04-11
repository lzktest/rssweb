<template>
    <div class="authority">
      <div class="button-box clearflex">
          <el-button @click="addAuthority('0')" type="primary">新增角色</el-button>
      </div>
      <el-table>
        <el-table-column label="角色id" min-width="180" prop="authorityId"></el-table-column>
        <el-table-column label="角色名称" min-width="180" prop="authorityName"></el-table-column>
        <el-table-column fixed="right" label="操作" width="400">
            <template slot-scope="scope">
                <el-button size="small" type="primary">设置权限</el-button>
                <el-button
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
    </div>
</template>