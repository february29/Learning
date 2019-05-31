var createError = require('http-errors');
var express = require('express');
var path = require('path');
// var cookieParser = require('cookie-parser');
var session = require('express-session')
var logger = require('morgan');

var bodyParser = require('body-parser');

//引入自己定义的模块
// var mydb = require('./libs/mysqlconect.js')


//引入路由文件
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
// var home = require('./routes/login');
var loginRouter = require('./routes/login');


//==================================================================================

//  mosca
var mosca = require('mosca');


var ascoltatore = {
  //using ascoltatore
  //type: 'mongo',
  //url: 'mongodb://localhost:27017/mqtt',
  //pubsubCollection: 'ascoltatori',
  //mongo: {}
};

var settings = {

  port: 1883,
  logger: {
        level: 'info'
  },
  // backend: ascoltatore
};

var server = new mosca.Server(settings);



server.on('clientConnected', function(client) {
    console.log('client connected', client.id);
});

// fired when a message is received
server.on('published', function(packet, client) {
    console.log('Published', packet.payload);
});

// fired when the mqtt server is ready
server.on('ready', function setup() {
    console.log('Mosca server is up and running');
});


//==================================================================================

// EXPRESS
var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

//内置中间件
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
//'february29'加密字符串
// app.use(cookieParser('february29'));
// parse application/x-www-form-urlencoded
app.set('trust proxy', 1); // trust first proxy
app.use(session({
  secret: 'keyboard cat',
  resave: false,
  saveUninitialized: true,
  // cookie: { secure: true }
}));

app.use(bodyParser.urlencoded({ extended: false }))

// parse application/json
app.use(bodyParser.json())


// app.use(mydb)


//托管静态页面
app.use(express.static(path.join(__dirname, 'public')));

//设置允许跨域访问该服务. 注意书写位置
app.all('*', function (req, res, next) {
  res.header('Access-Control-Allow-Origin', '*');
  //Access-Control-Allow-Headers ,可根据浏览器的F12查看,把对应的粘贴在这里就行
  res.header('Access-Control-Allow-Headers', 'Content-Type');
  res.header('Access-Control-Allow-Methods', '*');
  res.header('Content-Type', 'application/json;charset=utf-8');
  //header头信息设置结束后，结束程序往下执行，返回
  if(req.method.toLocaleLowerCase() === 'options'){
    res.status(204);
    return res.json({});   //直接返回空数据，结束此次请求
  }else{
    next();
  }
});

//配置路由文件
app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/login', loginRouter);





//
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  console.log(err);
  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
