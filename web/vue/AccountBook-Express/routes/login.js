var express = require('express');
var router = express.Router();

var db = require('../libs/mysqlconect.js');


/* login */
router.all('/', function(req, res, next) {
    console.log('login');

    var par = req.body;

    console.log(par);
    if (par.username === undefined || par.username.length<=0) {
        console.log('用户名不能为空');
        res.json({code:1,msg:'用户名不能为空'});
        return;

    }

    if (par.password === undefined ||par.password.length<=0) {
        console.log('密码不能为空');
        res.json({code:2,msg:'密码不能为空'});
        return;
    }




    //查询数据库user信息
   var sql = {
        sql: 'SELECT * FROM `user` WHERE `username` = ? and `password` = ?',
        timeout: 40000, // 40s
        values: [par.username,par.password]
    }
    // var sql    = 'SELECT * FROM user ;'
    console.log('sql : ', sql);

    db.query(sql, function(err, rows, fields){
        if (err) {
            console.log('数据库操作错误');
            console.log(err);
            res.json({code:4,msg:'数据库操作错误'});

        }else{
            // console.log('rows : ', rows,typeof(rows));
            var results = JSON.stringify(rows)//转化成JSON字符串去掉了RowDataPacket
            // console.log('results : ', results,typeof(results));
            results = JSON.parse(results);//把results字符串转为json对象
            console.log('results : ', results,typeof(results));
            if (  results.length > 0) {
                var dbUser = results[0];
                console.log('登录成功');
                // req.session.user=results;
                res.json({code:0,msg:'登录成功',userinfo:dbUser});
            }else{
                console.log('用户名或密码不正确');
                res.json({code:3,msg:'用户名或密码不正确'});
            }
        }
    });



});


module.exports = router;