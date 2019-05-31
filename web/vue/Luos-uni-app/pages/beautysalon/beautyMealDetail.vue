<template>
	<view class="container">
		
		
		
		<scroll-view scroll-y class="scroll-container">
			
			<!-- #ifdef MP || H5 -->
			<uni-nav-bar  title = ""  left-icon="back" @click-left="back" fixed = "true" statusBar = "true" backgroundColor = "#00000000" :shadow = "false" :border="false"></uni-nav-bar>
			<!-- #endif -->
			
			 <!-- 头部轮播 -->
			<view class="carousel-section">
			
				<swiper class="carousel" circular @animationfinish="swiperChange" autoplay="true" interval="3000" duration="500">
					<swiper-item v-for="(item, index) in carouselList" :key="index" class="carousel-item" @click="swiperClick(item,index)">
						<image :src="item" mode="aspectFill" />
					</swiper-item>
				</swiper>
			
			</view>
			
			<!-- 价格信息 -->
			<view class="info-container padding-left-right padding-top-bottom">
				<view class="info-pirce">
					<text class="info-price-text">{{'¥' + (detail.price * detail.rate)}}</text>
					<text class="info-price-unit">{{detail.unit}}</text>
					<text class="info-price-text2" v-if="detail.rate < 1">{{detail.price + ''+ detail.unit}}</text>
					
				</view>
				<text class="info-name">{{detail.name}}</text>
				<text class="info-desc">{{detail.gjz}}</text>
			</view>
			
			<!-- 选择信息 -->
			<view class="pick-container padding-left-right">
				<view class="list-cell  border-bottom-view " @click="navToBeautySalonsList" hover-class="cell-hover" :hover-stay-time="50">
					<text class="cell-text">选择美容院</text>
					<text class="cell-more text-align-right">{{selectedSalons.name}}</text>
					<uni-icon class = "cell-icon" color = "#DCDFE6" type = "forward" size = "20px"></uni-icon>
				</view>
				<view class="list-cell  border-bottom-view " @click="navToBeauticainList" hover-class="cell-hover" :hover-stay-time="50">
					<text class="cell-text">选择美容师</text>
					<text class="cell-more text-align-right ">{{selectedBeauticain.name}}</text>
					<uni-icon class = "cell-icon" color = "#DCDFE6" type = "forward" size = "20px"></uni-icon>
				</view>
				<view class="list-cell" @click="showTimePopup" hover-class="cell-hover" :hover-stay-time="50">
					<text class="cell-text">选择时间</text>
					<text class="cell-more text-align-right">{{selectedTimesString}}</text>
					<uni-icon class = "cell-icon" color = "#DCDFE6" type = "forward" size = "20px"></uni-icon>
				</view>
				
			</view>
			
			<!-- 详细信息 -->
			<view class="detail-container padding-left-right">
				<view class="list-cell  border-bottom-view " hover-class="cell-hover" :hover-stay-time="50">
					<text class="cell-text">时长</text>
					<text class="cell-more">{{detail.server_long_time}}</text>
				</view>
				<view class="list-cell border-bottom-view "  hover-class="cell-hover" :hover-stay-time="50">
					<text class="cell-text">套餐内容</text>
					<text class="cell-more">{{detail.meal_info}}</text>
				</view>
			</view>
			
			
			<!-- 图文详情 -->
			<view class="image-detial-container padding-top-bottom">
				<image v-for="(item,index) in imageDetailList" :key="index" :src="item" mode="widthFix"></image>
			</view>
		</scroll-view>
		
		
		
		<!-- 底部bar -->
		<view class="bottom-bar-container border-top-view">
			<image class="bottom-bar-icon" src="../../static/icon_cart_detail.png" mode="aspectFill"></image>
			<text class="bottom-bar-price">{{"¥"+_totleMoney}}</text>
			<view class="bottom-bar-btn"  @click="navToPlaceOrder">
				<text class = "bottom-bar-btn-text">立即预约</text>
			</view>
		</view>
		
		
		<!-- 弹出框  -->
		<animation-popup ref="popup"  popanimationin="slideInUp fast" popanimationout="slideOutDown fast" postion="bottom">
		   <scroll-view class="pop-time-container flex-column-nowarp" scroll-y="true">
			 <view class="pop-time-tilte">美容师</view>
			 <view class="pop-time-info-container flex-row-nowarp">
			 	<image class="pop-time-info-img" :src="baseUrl+'beau_head/'+selectedBeauticain.photo" mode="aspectFill"></image>
				<view class="pop-time-info-detial flex-column-nowarp">
					<view class="pop-time-info-detial-info flex-row-nowarp">
						<text class = "pop-time-info-detial-name">{{selectedBeauticain.name}}</text>
						<text class = "pop-time-info-detial-sex">{{selectedBeauticain.sex == 1 ? "♂":selectedBeauticain.sex == 0?"♀":""}}</text>
						<text class = "pop-time-info-detial-age">{{selectedBeauticain.age}}</text>
					</view>
					<text class = "pop-time-info-detial-level">{{selectedBeauticain.jobTitle}}</text>
				</view>
			 </view>
			 <view class="pop-time-tilte">预约时间</view>
			 <view class="pop-time-time flex-row-warp">
			 	<beauty-service-time  v-for = "(item,idx) in serverTimeList" :key="idx" :replaceClass="idx%4==0" :data = "item" v-on:itemClick = "itemTimeClick" ></beauty-service-time>
			 </view>
		   </scroll-view>
		   <view class="bottom-bar-container border-top-view">
		   	<image class="bottom-bar-icon" src="../../static/icon_cart_detail.png" mode="aspectFill"></image>
		   	<text class="bottom-bar-price">{{ "¥"+ _totleMoney}}</text>
		   	<view class="bottom-bar-btn" @click="navToPlaceOrder">
		   		<text class = "bottom-bar-btn-text">立即预约</text>
		   	</view>
		   </view>
		</animation-popup>
		
	
	</view>
</template>

<script>
	
	import uniNavBar from "../../components/uni-nav-bar.vue"
	import animationPopup from '../../components/animatino-popup/animation-popup.vue';
	import beautyServiceTime from '../../components/beauty-service-time.vue';
	import ArrayUtils from '../../common/arrayUtils.js'
	
	// import {formatDate} from '../common/date-tool.js'
	
	export default {
		
		components:{
			uniNavBar,
			animationPopup,
			beautyServiceTime,
			
			// uniIcon,
		},
		data(){
			return{
				baseUrl:this.api.baseUrl,
				carouselList: [],//滚动视图数据
				imageDetailList:[],//图文详情
				serverTimeList:[],//美容师服务时间
				selectedSalons:{},
				selectedBeauticain:{},
				selectedTimes:[],
				detail:{},
			}
		},
		
		
		computed: {
			_imageDetailList(){
				var list = [];
				for (var i = 0;i<this.carouselList.length;i++){
					var item = this.carouselList[i];
					list.push(item.picture)
				}
				return list;
			},
			_totleMoney(){
				var tolteMoney = 0;
				for ( var i = 0 ;i < this.selectedTimes.length;i++) {
					var timeItme =  this.selectedTimes[i];
					
					tolteMoney += (this.detail.price*this.detail.rate * timeItme.rate + timeItme.addition);
				}
				
				return tolteMoney;
			},
			
			// noDiscountMoney(){
			// 	var tolteMoney = 0;
			// 	for ( var i = 0 ;i < this.selectedTimes.length;i++) {
			// 		var timeItme =  this.selectedTimes[i];
			// 		
			// 		tolteMoney += this.detail.price;
			// 	}
			// 	
			// 	return tolteMoney;
			// },
			
			selectedTimesString(){
				var str = '';
				for (var i = 0 ; i<this.selectedTimes.length;i++) {
					var item = this.selectedTimes[i];
					str+= item.showTime;
					if (i != this.selectedTimes.length-1) {
						str+='\n';
						
					} 
				}
				return str;
			}
		},
		
		onLoad(options) {
			this.id = options.id;
			
			this.loadData()
		},
		methods:{
			back(){
				uni.navigateBack();
	
			},
			swiperClick(item,index){
				// 预览图片
				uni.previewImage({
					indicator:"number",
					current:item,
					urls: this.carouselList
				});
			},
			// 跳转美容院列表
			navToBeautySalonsList(){
				
				//监听事件
				let _this = this;
				this.$eventHub.$on('selectedBlock', function(data) {
					_this.selectedSalons = data;
					
					console.log(_this.selectedSalons);
					//清除监听，不清除会消耗资源
					_this.$eventHub.$off('selectedBlock');
				});
				
				uni.navigateTo({
					url: './beautySalons'
				})
				
	
			},
			// 跳转美容师列表
			navToBeauticainList(){
				console.log(this.selectedSalons.id)
				if(!this.selectedSalons.id){
					uni.showToast({
						icon:"none",
						title:'请选择美容院'
					})
					return;
				}
				
				//监听事件
				let _this = this;
				this.$eventHub.$on('selectedBlock', function(data) {
					_this.selectedBeauticain = data;
					
					console.log(_this.selectedBeauticain);
					//清除监听，不清除会消耗资源
					_this.$eventHub.$off('selectedBlock');
				});
				
				
				uni.navigateTo({
					url: './beauticains'+'?shopId='+this.selectedSalons.id + '&mealId='+this.detail.id
				})
			},
			// 跳转下单页面
			navToPlaceOrder(){
				if (this.selectedTimes.length<1){
					uni.showToast({
						icon:"none",
						title:'请选择服务时间'
					})
					return;
				}
				uni.navigateTo({
					url: './placeOrder'+'?mealDetail='+JSON.stringify(this.detail) + '&totleMoney='+ this._totleMoney +  '&selectedTimes='+ JSON.stringify(this.selectedTimes)
				})
			},
			showTimePopup(){
				if(!this.selectedBeauticain.id){
					uni.showToast({
						icon:"none",
						title:'请选择美容师'
					})
					return;
				}
				this.selectedTimes = [];
				this.getServiceTime(this.selectedBeauticain.id)
				
				this.$refs.popup.show();
			},
			
			itemTimeClick(item){
				
				
// 				if(item.isMake == 0){
// 					item.isMake = 2;
// 					
// 				}else if(item.isMake == 2){
// 					item.isMake = 0;
// 					
// 				}
				
				
				//通过ID判断是否添加
				var index = ArrayUtils.bIndexOf(this.selectedTimes,item,"id");
						
				if(item.isMake == 0){
					if(index == -1){
						//selectedTimes中不存在时
						this.selectedTimes.push(item);
					}else{
						//selectedTimes中存在时
					}
					item.isMake = 2;
					
					
				}else if(item.isMake == 2){
					if(index != -1){
						this.selectedTimes.splice(index,1);
					}
					item.isMake = 0;
					
				}
				//
				// var index = this.selectedTimes.indexOf(item)
				
				
				
			},
			
			getServiceTime(beauId){
				
				uni.request({
					url: this.api.getBeauticianlUsableTime,
					method: 'GET',
					data: {
						id:beauId,
						mealId:this.detail.id
						
					},
					success: res => {
						var result= res.data
						if(result){
							this.serverTimeList = result.beauticianl.serverTimeList;
						
						}else{
							uni.showToast({
								icon:"none",
								title:'数据异常'
							})
						}
					},
					fail: (error) => {
						uni.showToast({
							icon:"none",
							title:'网络异常'
						})
					},
					complete: () => {}
				});
			},
			//获取套餐详情
			loadData(){
				uni.request({
					url:this.api.showMeal,
					data:{
						id:this.id
					},
					success: (res) =>  {
						var result = res.data;
						if(result){
							this.detail = result.meal
							// console.log(this.detail.content);
							//顶部图片
							if (this.detail.pic){
								// this.carouselList = this.detail.pic.split(',')
								this.carouselList = [];
								var ar = this.detail.pic.split(',')
								for(var i = 0;i<ar.length;i++){
									this.carouselList.push(this.baseUrl+'meal/'+ar[i]); 
								}
								
								
							}
// 							console.log('ddd:',this.detail.pic);
// 							console.log('ddd:',this.carouselList[0]);
							//图文图片
							if (this.detail.content){
								this.imageDetailList = [];
								var ar = this.detail.content.split(',')
								for(var i = 0;i<ar.length;i++){
									this.imageDetailList.push(this.baseUrl+'meal/'+ar[i]); 
								}
								
							}
							
							
						}else{
							uni.showToast({
								icon:"none",
								title:'数据异常'
							})
						}
					},
					fail:(error)=> {
						console.log("error :",error.errMsg);
						uni.showToast({
							icon:"none",
							title:'网络异常'
						})
					}
				})
			}
		}
		
		
	}
	
</script>

<style lang="scss" >
	::-webkit-scrollbar{
		width: 0;
		height: 0;
		color: transparent;
	}
	
	page{
		background:$bg-color-gray;
	}
	
	
	
	
	.scroll-container{
		margin-bottom: 100upx;
		width: 100%;
	}
	
	// <!-- 底部bar -->
	.bottom-bar-container{
		display: flex;
		align-items: center;
		
		background: white;
		position: fixed;
		z-index: 998;
		width: 100%;
		height: 100upx;
		bottom: 0upx;
		.bottom-bar-icon{
			width: 80upx;
			height: 80upx;
			margin-left: $uni-spacing-col-base;
		}
		.bottom-bar-price{
			margin-left: $uni-spacing-col-base;
			flex: 1;
			font-size: $font-lg;
			color: $font-color-pink;
		}
		.bottom-bar-btn{
			margin-left: $uni-spacing-col-base;
			// margin-right: $uni-spacing-col-base;
			background: $font-color-pink;
			display: flex;
			justify-content: center;
			align-items: center;
			height: 100%;
			width: 187upx;
			.bottom-bar-btn-text{
				color: white;
				font-size: $font-base;
			}
		}
		
	}
	
	
	/* 头部 轮播图 */
	.carousel-section {
		display: block;
		// position: relative;
		// margin-top: - var(--status-bar-height) ;
		margin-top: -176upx;
		.carousel {
			width: 100%;
			height: 650upx;
		
			.carousel-item {
				width: 100%;
				height: 100%;
				padding: 0px;
				overflow: hidden;
			}
		
			image {
				width: 100%;
				height: 100%;
		
				// border-radius: 0px;
			}
		}
		
	}
	
	
	//<!-- 价格信息 -->
	.info-container{
		background: white;
		 
		.info-pirce{
			display: flex;
			flex-flow: row nowrap;
			align-items: center;
			
			.info-price-text{
				color: $font-color-pink;
				font-size: $font-lg + 10upx;
			}
			.info-price-unit{
				color: $uni-text-color-placeholder;
				font-size: $font-base - 4upx;
			}
			.info-price-text2{
				
				font-size: $font-sm - 2upx;
				color: $uni-text-color-placeholder;
				text-decoration: line-through;
			}
			
		}
		.info-name{
			margin-top: 5upx;
			font-size: $font-lg - 2upx;
		}
		.info-desc{
			margin-top: 5upx;
			color: $uni-text-color-placeholder;
			font-size: $font-sm - 2upx;
		}
	}
	
	
	// 详细信息
	.detail-container{
		background: white;
		margin-top: $uni-spacing-col-base;
	}
	//选择信息 
	.pick-container{
		background: white;
		margin-top: $uni-spacing-col-base;
	}
	
	//  <!-- 详细信息 --> <!-- 选择信息 -->
	.list-cell{
		
		display:flex;
		align-items:baseline;
		line-height:80upx;
		position:relative;
		justify-content: center;
		
		
		.text-align-right{
			text-align: right;
		}
		
		.cell-text{
			font-size: $font-base - 2upx;
			color: $font-color-base;
			margin-right:10upx;
		}
		
		.cell-more{
			// flex-wrap: wrap;
			white-space: normal;
			word-wrap: break-word;
			word-break: break-all;
			line-height: 1.5;
			
			flex: 1;
			align-self: baseline;
			font-size:$font-base - 2upx;
			margin-left:10upx;
			
		}
		.cell-icon{
			margin-right: 10upx;
		}
		
	
		
	}
	// <!-- 图文详情 -->
	
	.image-detial-container{
		display: flex;
		flex-flow: row wrap;
		justify-content: center;
		align-items: center;
		image{
			width: 100%
		}
	}
	
	
	//底部弹出框
	.pop-time-container{
		width: 720upx;//720屏幕宽度 好奇怪
		height: 600upx;
		background: white;
		padding-left: $page-row-spacing;
		padding-right: $page-row-spacing;
		padding-bottom: $page-row-spacing;
		padding-top: $page-row-spacing;
		margin-bottom: 100upx;
		.pop-time-tilte{
			
			color: $font-color-pink;
			font-size: $font-lg;
		}
		.pop-time-info-container{
			align-items: center;
			.pop-time-info-img{
				width: 120upx;
				height: 120upx;
				margin-top: 20upx;
				border-radius: 50%;
				margin-bottom: 20upx;
			}
			.pop-time-info-detial{
				flex: 1;
				justify-content: center;
				margin-left: 10upx;
				.pop-time-info-detial-info{
					
					.pop-time-info-detial-name{
						font-size: $font-base;
					}
					.pop-time-info-detial-sex{
						margin-left: 10upx;
						font-size: $font-lg;
						color: $font-color-pink;
					}
					.pop-time-info-detial-age{
						margin-left: 10upx;
						font-size: $font-base - 2upx;
						color: $font-color-base;
					}
				}
				.pop-time-info-detial-level{
					color: white;
					font-size: $font-sm - 6upx;
					padding: 0upx 15upx;
					border-radius: 5upx;
					background: $font-color-pink;
					width:35upx;
					text-align: center;
				}
			}
		}
		.pop-time-time{
			width: 100%;
			display: flex;
			flex-direction: row;
			flex-wrap: wrap;
			
// 			 margin-left: - $page-row-spacing / 2;
// 			 margin-right: - $page-row-spacing / 2; 
			.beauty-service-time-item{
				
				height: 135upx;
				
				width: 168.75upx;
				margin-top: $page-row-spacing; 
				margin-left: $page-row-spacing;
				 

			}
			.beauty-service-time-item2{
				
				height: 135upx;
				
				width: 168.75upx;
				margin-top: $page-row-spacing; 
				margin-left: 0upx;
			
			}
			
			
		}
	}
	

	.aaa{
		width: 100%
		
	}
	
	
	
</style>
