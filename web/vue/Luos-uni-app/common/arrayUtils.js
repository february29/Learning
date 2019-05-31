// Array.prototype.bIndexOf = function(item,searchKey){
// 	var index = -1;
// 	for (var i = 0;i<this.length;i++) {
// 		
// 		var idxValue = Object.getOwnPropertyDescriptor(this[i],searchKey)
// 		var itemValue = Object.getOwnPropertyDescriptor(item,searchKey)
// 		if (idxValue == itemValue) {
// 			index = i;
// 			break;
// 		}
// 	}
// 	return index;
// }




var utils = {
    
    bIndexOf: function(array,item,searchKey){
		
       	var index = -1;
		var itemValue = item[searchKey]
       	for (var i = 0;i<array.length;i++) {
			var it = array[i]
       		var idxValue = it[searchKey]
       		if (idxValue == itemValue) {
       			index = i;
       			break;
       		}
       	}
		
       	return index;
    }
}
export default utils