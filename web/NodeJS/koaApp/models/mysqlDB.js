// var mongoose = require('mongoose');
// mongoose.connect('mongodb://localhost/nodejs');
// exports.mongoose = mongoose;

var mysql  = require('mysql');  
 
var connection = mysql.createConnection({     
  host     : 'localhost',       
  user     : 'root',              
  password : '123456',       
  port: '3306',                   
  database: 'koaApp', 
}); 
 
connection.connect();

exports.mysql = mysql;

