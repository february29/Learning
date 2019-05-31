
var mysql = require('mysql');

var db    = {};

var pool  = mysql.createPool({

    host            : 'localhost',
    user            : 'root',
    port            : '3306',
    password        : '123456',
    database        : 'accountboook'
});



db.query = function(sql, callback){

    if (!sql) {
        callback();
        return;
    }

    pool.query(sql, function(err, rows, fields) {
        if (err) {
            console.log(err);
            callback(err, null);
            return;
        };

        callback(null, rows, fields);
    });
}

db.query2 = pool.query;

module.exports = db;


