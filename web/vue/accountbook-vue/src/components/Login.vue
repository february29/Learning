<template>
    <div class="bg">
        <div class="formbg">
            <el-form  ref="form" :model="form"  class="form">
                <el-form-item  >
                    <el-input v-model="form.username" placeholder="请输入用户名"></el-input>
                </el-form-item>
                <el-form-item >
                    <el-input  v-model="form.password" placeholder="请输入密码"  class="input" show-password></el-input>
                </el-form-item>

                <el-button @click="mqttConect" type="primary" class="loginBtn">登录</el-button>



            </el-form>
        </div>





    </div>
    
</template>

<script>



    export default {
        name: "Login",
        data(){
            return{
                username:"",
                password:"",
                form:{username:'',password:''}


            }
        },
        created(){
            window.console.log("created");


        },
        methods:{
            doLogin() {
                window.console.log(this.form );

                this.$http.post('http://localhost:3000/login', this.form).then((rep) => {
                    window.console.log('successful');
                    window.console.log(rep);
                    if(rep.body.code==0){
                        this.$router.push('home')
                    }else{
                        window.alert(rep.body.msg)
                    }

                }, (error) => {
                    window.console.log('error');
                    window.console.log(error);
                    // alert(error.body);
                })


            },
            mqttConect(){

                window.console.log("mqttConect");
                var mqtt = require('mqtt');
                //mqtt 测试
                // var client  = mqtt.connect('mqtt://test.mosquitto.org')
                // var client  = mqtt.connect('mqtt://test.mosca.io')
                var client  = mqtt.connect('mqtt://10.10.4.20:1883')
                // var client  = mqtt.connect('tcp://10.10.4.20:1883')
                // var client  = mqtt.connect('mqtt://localhost:1883')


                client.on('connect', function () {
                    client.subscribe('presence', function (err) {
                        if (!err) {
                            client.publish('presence', 'Hello mqtt')
                        }
                    })
                })


                client.on('message', function (topic, message) {
                    // message is Buffer
                    window.console.log(message.toString())
                    client.end()
                })

                client.on





            },

        }
    }
</script>

<style scoped>



    .bg{
        width: 100%;
        height: 100vh;
        background-color: azure;
        display: flex;
        align-items: center;
        background: url(../assets/bg_login.jpg) no-repeat;
        /*background-size: 100% 100%;*/
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
    }
    .formbg{
        background-color: white;
        width: 400px;
        height: 400px;
        margin:0 auto;
        text-align:center;
        border:1px solid;
        border-color: #DCDFE6;
        border-radius: 5px;
        display: flex;
        align-items: center;
    }
    .form{
        width: 80%;
        padding-left: 10%;
        padding-right: 10%;
        margin-top: -10%;
    }
    .input{
        text-align: center;
    }
    .loginBtn{
        width: 100%;
    }






</style>