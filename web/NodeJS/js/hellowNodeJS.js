

// 通过 exports 对象把 sayHellow 作为模块的访问接口
// exports.sayHellow = function () {
// 	console.log("Hello World");

// }；


//把一个对象封装到模块中
module.exports = function People() {
	var name;
	this.setName = function (theName) {
		name = theName;
	};
	this.sayHellow2 = function () {
		console.log("Hello ,my name is "+name);
	}
	
};


