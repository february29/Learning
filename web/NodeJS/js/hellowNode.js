var http = require('http');
var querystring = require('querystring');
var util = require('util');

http.createServer(function (request, response) {

	var postBody = "";
	//接收到请求数据 可能尚未完成比如上传文件时
	request.on('data',function(data){
		postBody+=data;

    });
    

    //请求完成
    request.on('end',function(){
    	//将请求格式化
    	postBody =  querystring.parse(postBody);
    	console.log(util.inspect(postBody));



	    //=======处理请求===========
	    // 发送 HTTP 头部 
	    // HTTP 状态值: 200 : OK
	    // 内容类型: text/plain
	    response.writeHead(200, {'Content-Type': 'text/plain'});

	    // 发送响应数据 "Hello World"
	    response.end('Hello World\n');


    });

    request.on('error',function(){
    	console.log('error');
    });

   
}).listen(8888);

// 终端打印如下信息
console.log('Server running at http://127.0.0.1:8888/');

//=================================//

//事件
var EventEmitter = require('events').EventEmitter; 
var event = new EventEmitter(); 

//监听myevent事件
event.on('myevent',function(){
console.log('myevent happen'); 
});
//1000号秒后发送myevent事件
setTimeout(function () {
	event.emit("myevent");
}, 1000);


//buffer

const buf = Buffer.from([0x1, 0x2, 0x3, 0x4, 0x5]);
const json = JSON.stringify(buf);

console.log(json);

const copy = JSON.parse(json, (key, value) => {
  return value && value.type === 'Buffer' ?
    Buffer.from(value.data) :
    value;
});

console.log(copy);


//模块  nodejs 中每个文件可视作一个模块

//引入外面模块
var hellowModel = require('./hellowNodeJS');
// hellowModel.sayHellow();


var bai = new hellowModel();
bai.setName("bai");
bai.sayHellow2();


