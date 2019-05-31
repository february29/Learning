import Vue from 'vue'
//base
const baseUrl = 'http://luo.fchsoft.com:9919/';  

// 美容院主页
const beautyIndex = baseUrl+'mobile/beautyIndex.json'; 
 //美容院列表
const getShopList = baseUrl+'mobile/getShopList.json'; 

//美容院套餐分类
const mealType = baseUrl+'mobile/getMealType.json';
//美容院套餐列表
const mealList = baseUrl+'mobile/mealList.json';  
//套餐详情
const showMeal = baseUrl+'mobile/showMeal.json'; 

//美容师分类
const getJobTitleList = baseUrl+'/mobile/getJobTitleList.json'; 
//美容师列表
const beauticianlList = baseUrl+'/mobile/beauticianlList.json'; 
//美容师详情
const showBeauticianl = baseUrl+'mobile/showBeauticianl.json';
//美容师详情
const getBeauticianlUsableTime = baseUrl+'mobile/getBeauticianlUsableTime.json';






export default {  
    baseUrl,  
    beautyIndex,
	getShopList,
	
	mealType,
	mealList,
	showMeal,
	
	getJobTitleList,
	beauticianlList,
	showBeauticianl,
	getBeauticianlUsableTime,
	
} 
