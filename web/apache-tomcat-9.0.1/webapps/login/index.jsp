
<!DOCTYPE html>



<%@ page language="java"  pageEncoding="UTF-8"    contentType="text/html;charset=utf-8" %>

<html lang="en" class="no-js">



    <head>


        <title>管理系统</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- CSS -->
        <link rel='stylesheet' href='http://fonts.googleapis.com/css?family=PT+Sans:400,700'>
        <link rel="stylesheet" href="css/reset.css">
        <link rel="stylesheet" href="css/supersized.css">
        <link rel="stylesheet" href="css/style.css">

        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <!-- Javascript -->
        <script src="js/jquery-1.12.4.min.js"></script>
        <script src="js/supersized.3.2.7.min.js"></script>
        <script src="js/supersized-init.js"></script>
        <script src="js/scripts.js"></script>

        <script type="text/javascript">
            
            function login(loginform){
            if(loginform.username.value==""){
                alert("请输入用户名！");
                loginform.username.focus();
                return false;
            
            }
            if(loginform.password.value==""){
                alert("请输入密码！");
                loginform.password.focus();
                return false;
            }   

            //     $.ajax({
            //     url:"${APP_PATH}/emps",
            //     data:"pn="+pn,
            //     type:"GET",
            //     success:function(result){
            //         //console.log(result);
            //         //1、解析并显示员工数据
            //         build_emps_table(result);
            //         //2、解析并显示分页信息
            //         build_page_info(result);
            //         //3、解析显示分页条数据
            //         build_page_nav(result);
            //     }
            // });
            }
            
        </script>

    </head>

    <body>

        <div class="page-container">
            <h1>登录</h1>
            <form action="" method="post">
                <input type="text" name="username" class="username" placeholder="账号">
                <input type="password" name="password" class="password" placeholder="密码">
                <button type="submit" onclick="login(this.form)">登录</button>
                <div class="error"><span>+</span></div>
            </form>


        </div>


        <a href="#" title="new user guide"><span class="fa fa-bolt"></span></a>
       
        

    </body>

</html>
