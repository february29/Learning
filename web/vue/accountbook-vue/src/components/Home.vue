<template>
    <div  class="homemain" >
        <div class="topnv">home</div>

        <div class="contener">
            <div class="left">
                <el-menu default-active="2" router>
                    <el-menu-item index="/home/storeHouse">
                        <i class="el-icon-menu"></i>
                        <span slot="title">库房</span>
                    </el-menu-item>
                    <el-menu-item index="/home/order" >
                        <i class="el-icon-document"></i>
                        <span slot="title">订单</span>
                    </el-menu-item>
                    <el-menu-item index="/home/customer">
                        <i class="el-icon-setting"></i>
                        <span slot="title">客户</span>
                    </el-menu-item>
                </el-menu>

                <!--<ul>-->
                    <!--<li>-->
                        <!--<router-link to="/home/storeHouse">库房</router-link>-->
                    <!--</li>-->
                    <!--<li>-->
                        <!--<router-link to="/home/order">订单</router-link>-->
                    <!--</li>-->
                    <!--<li>-->
                        <!--<router-link to="/home/customer">客户</router-link>-->
                    <!--</li>-->
                <!--</ul>-->
            </div>
            <div class="right">
                <router-view></router-view>
            </div>
        </div>


    </div>
    
</template>

<script>


    export default {
        name: "Home",
        components:{


        }
    }
</script>

<style scoped>
    .homemain{
        display: flex;
        flex-direction: column;
        height: 100%;
    }
    .topnv{
        width: 100%;
        height: 60px;
    }
    .contener{
        display: flex;
        /*height: 100%;*/
        flex: 1;
    }
    .left{
        /*border-right: 1px solid #DCDFE6;*/
        width: 200px;
        min-height: 400px;

    }
    .right{
        flex: 1;
    }





</style>