<template>
    <div>
        <div class="clearflex">
            <el-button class="fl-right" size="small" type="primary">确 定
            </el-button>
        </div>
        <el-tree
            :data="menuTreeData"
            :default-check-keys="menuTreeIds"
            :props="menuDefaultProps"
            @check="nodeChange"
            show-checkbox
            >
        </el-tree>
    </div>
</template>