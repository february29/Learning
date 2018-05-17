## express

### 安装
两种方式 
1. 全局安装 
2. 本地安装
**本地安装**
1.cd到app目录 
2.npm init  
通过 npm init 命令为你的应用创建一个 package.json 文件。 欲了解 package.json 是如何起作用的，请参考 Specifics of npm’s package.json handling。

3.npm express --save  
如果指定了 --save 参数，那么此模块将被添加到 package.json 文件中 dependencies 依赖列表中。 然后通过 npm install 命令即可自动安装依赖列表中所列出的所有模块。
安装到当前目录

**全局安装**
npm express

### Express 应用生成器

创建app
express --ejs app
express 默认为 jade  这里创建ejs模版的。 两者各有千秋。ejs模版类似于html方便阅读。

[Express 应用生成器](http://www.expressjs.com.cn/starter/generator.html)





### 常见问题：
##### 端口号占用
lsof -i:端口号
kill  pid
