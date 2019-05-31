<template>
	<view class="content">
		<!-- 骨架组件 -->
		<!-- <skeleton v-if="showSkeleton" ref="skeleton" loading="chiaroscuro" selector="skeleton" bgcolor="#FFF"></skeleton>
		<view class="container skeleton"> -->
		<!-- #ifdef MP || H5 -->
		<!-- <uni-nav-bar fixed = "true" title = "美容院" statusBar = "true"></uni-nav-bar> -->
		<!-- #endif -->
		
        <!-- 头部轮播 -->
        <view class="carousel-section">
        	<!-- 标题栏和状态栏占位符 -->
        	<!-- <view class="titleNview-placing"></view> -->
        	<!-- 背景色区域 -->
        	<!-- <view class="titleNview-background" :style="{backgroundColor:titleNViewBackground}"></view> -->
        	<swiper class="carousel" circular @animationfinish="swiperChange" autoplay="true" interval="3000" duration="500">
        		<swiper-item v-for="(item, index) in carouselList" :key="index" class="carousel-item" @click="swiperClick(item,index)">
        			<image :src="baseUrl+'advs/'+item.picture"/>
        		</swiper-item>
        	</swiper>
        	<!-- 自定义swiper指示器 -->
        	<view class="swiper-dots">
        		<text class="num">{{swiperCurrent+1}}</text>
        		<text class="sign">/</text>
        		<text class="num">{{carouselList.length}}</text>
        	</view>
        </view>
		
		<!-- 菜单显示 -->
		<view class="cate-section">
			<view class="cate-item" v-for="(item,index) in menuList" :key="index" @click="navToMealTypePage(index)">
				<image :src="item.pic" mode="aspectFit"></image>
				<text>{{item.type}}</text>
			</view>
		</view>
		<!-- 热门套餐 -->
		<view class="hot-section">
			<view class="title-view">
				<text class="title-text" >热门套餐</text>
			</view>

			<scroll-view class="hot-list" scroll-x="true" scroll-y="false" >
				
				<!-- <view v-for="(tem,index) in hotList"   @click="navToDetailPage(tem.id)">
					<beauty-meal-item-comp class = "list-item" :mealItem = "tem" ></beauty-meal-item-comp>
				</view> -->
				
				<beauty-meal-item-comp class = "list-item" v-for="(tem,index) in hotList" :key="index" :mealItem = "tem" v-on:itemClick="navToDetailPage" >
				 </beauty-meal-item-comp>
			
			</scroll-view>
		</view>
		
		<!-- 美容师 艾灸师 -->
		<view class="beautician-section">
			
			
			<view class="beautician-item" v-for="(pitem,pindex) in beauticianls" :key="pindex">
				<view class="title-view">
					<text class="title-text" >{{pitem.typeName}}</text>
					<text class="title-btn" @click="navToBeauticainlistPage(pitem.typeId)">更多>></text>
				</view>
				<scroll-view class="beautician-item-list" scroll-x="false" scroll-y="false" >
					<!-- <view class="hot-list-warpper"> -->
						<view class="beautician-item-list-tiem" v-for="(item,index) in pitem.beauticialList" :key="index" @click="navToBeauticainDetailPage(item.id)" >
							<image class="beautician-item-img" :src="baseUrl+'beau_head/'+item.photo" mode="aspectFill"></image>
							<text class="beautician-item-name">{{item.name}}</text>
							<text class="beautician-item-desc">{{item.profile}}</text>
							
					
						</view>
					<!-- </view> -->
					
					
				</scroll-view>
				
			</view>
			
			
			
			
		</view>
		
		<!-- </view> -->
		
		
	</view>
</template>

<script>
	
	import beautyMealItemComp from '../../components/beauty-meal-item-comp.vue'
	// import v-mealItemComp from '../../components/beautiMealComp.vue'
	// import skeleton from "../../components/quick-skeleton.vue";

	export default {
		
		components:{
			beautyMealItemComp,
			// skeleton
		},
	
	
	
		data() {
			return {
				baseUrl:this.api.baseUrl,
				titleNViewBackground: '',
				swiperCurrent: 0,//滚动视图当前位置
				carouselList: [],//滚动视图数据
				typeList:[],//套餐分类
				menuList:[],//分类菜单 typeList+ 签到
				hotList: [],//热门套餐
				beauticianls:[],//热门热门美容师
				showSkeleton: true  //骨架屏显示隐藏
			};
		},
		
		computed:{
			_topPicList(){
				var list = [];
				for (var i = 0;i<this.carouselList.length;i++){
					var item = this.carouselList[i];
					list.push(this.api.baseUrl+'advs/'+item.picture)
				}
				console.log("list:",list)
				return list;
			}
		},
	
		onLoad() {
			//网络请求
			
			this.loadData();
		},
		
		onPullDownRefresh() {
			this.loadData();
		},
		methods: {
			/**
			 * 请求静态数据只是为了代码不那么乱
			 * 分次请求未作整合
			 */
			async loadData() {
				
				//主页滚动时图，热门套餐 美容师数据请求
				uni.request({
					url:this.api.beautyIndex,
					data:{},
// 					complete(error,result) {
// 						console.log('http:',this.api.beautyIndex);
// 					},
					success: (res) =>  {
						console.log(res.data);
						var result = res.data;
						if(result){
							this.carouselList = result.advList;
							this.hotList = result.hotMealList;
							this.beauticianls = result.beauticianl;
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
				
				//主页菜单请求
				uni.request({
					url:this.api.mealType,
					data:{},
// 					complete(error,result) {
// 						console.log('http:',this.api.mealType);
// 					},
					success: (res) =>  {
						console.log(res.data);
						var result = res.data;
						if(result){
							// this.menuList = result.typeList;
							// var typeList = [];
							this.typeList = result.typeList;
							this.menuList = [];
							for (var i=0;i< this.typeList.length;i++) {
								var item = this.typeList[i];
								if (item.id == 1) {
									item.pic = "/static/btn-face.png"
								}else if(item.id == 2){
									item.pic = "/static/btn-moxibustion.png"
								}else if(item.id == 3){
									item.pic = "/static/btn-vip.png"
								}else if(item.id == 4){
									item.pic = "/static/btn-foot-bath.png"
								}
								this.menuList.push(item)
							}
							//添加一个签到的按钮
							this.menuList.push({id: -1, type: "签到", hidden: 0,pic:"/static/btn-signarrive.png"})
							// console.log("menu:",this.menuList);
							
							
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
				
				
				
// 				let carouselList = await this.$api.json('carouselList');
// 				this.titleNViewBackground = carouselList[0].background;
// 				this.swiperLength = carouselList.length;
// 				this.carouselList = carouselList;
// 				
// 				let hotList = await this.$api.json('hotList');
// 				this.hotList = hotList;
			},
			//轮播图切换修改背景色
			swiperChange(e) {
				const index = e.detail.current;
				this.swiperCurrent = index;
				// this.titleNViewBackground = this.carouselList[index].background;
			},
			swiperClick(index){
				// 预览图片
				uni.previewImage({
					indicator:"number",
					current:this._topPicList[index],
					urls: this._topPicList
				});
			},
			//套餐详情页
			navToDetailPage(id) {
				// console.log("navToDetailPage");
				uni.navigateTo({
					url: '/pages/beautysalon/beautyMealDetail?id='+id
				})
			},
			//美容师列表
			navToBeauticainlistPage(typeId) {
				uni.navigateTo({
					url: '/pages/beautysalon/beauticains?type='+typeId 
				})
			},
			//美容师详情
			navToBeauticainDetailPage(id) {
				uni.navigateTo({
					url: '/pages/beautysalon/beauticainDetail?id='+id
				})
			},
			//套餐分类
			navToMealTypePage(idx) {
				uni.navigateTo({
					url: '/pages/beautysalon/beautyCategory?idx=' + idx + '&typeList='+ JSON.stringify(this.typeList)
				})
			},
			
		},
		// #ifndef MP
		// 标题栏input搜索框点击
// 		onNavigationBarSearchInputClicked: async function(e) {
// 			this.$api.msg('点击了搜索框');
// 		},
// 		//点击导航栏 buttons 时触发
// 		onNavigationBarButtonTap(e) {
// 			const index = e.index;
// 			if (index === 0) {
// 				this.$api.msg('点击了扫描');
// 			} else if (index === 1) {
// 				// #ifdef APP-PLUS
// 				const pages = getCurrentPages();
// 				const page = pages[pages.length - 1];
// 				const currentWebview = page.$getAppWebview();
// 				currentWebview.hideTitleNViewButtonRedDot({
// 					index
// 				});
// 				// #endif
// 				this.$api.msg('点击了消息, 红点新消息提示已清除');
// 			}
// 		}
		// #endif
	}
</script>

<style lang="scss">
	
	::-webkit-scrollbar{
		width: 0;
		height: 0;
		color: transparent;
	}
	
	/* 头部 轮播图 */
	.carousel-section {
		position: relative;
		padding-top: 0px;
		.carousel {
			width: 100%;
			height: 350upx;
		
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
		.swiper-dots {
			display: flex;
			position: absolute;
			left: 60upx;
			bottom: 15upx;
			width: 72upx;
			height: 36upx;
			background-image: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAABkCAYAAADDhn8LAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTMyIDc5LjE1OTI4NCwgMjAxNi8wNC8xOS0xMzoxMzo0MCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6OTk4MzlBNjE0NjU1MTFFOUExNjRFQ0I3RTQ0NEExQjMiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6OTk4MzlBNjA0NjU1MTFFOUExNjRFQ0I3RTQ0NEExQjMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTcgKFdpbmRvd3MpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6Q0E3RUNERkE0NjExMTFFOTg5NzI4MTM2Rjg0OUQwOEUiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6Q0E3RUNERkI0NjExMTFFOTg5NzI4MTM2Rjg0OUQwOEUiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz4Gh5BPAAACTUlEQVR42uzcQW7jQAwFUdN306l1uWwNww5kqdsmm6/2MwtVCp8CosQtP9vg/2+/gY+DRAMBgqnjIp2PaCxCLLldpPARRIiFj1yBbMV+cHZh9PURRLQNhY8kgWyL/WDtwujjI8hoE8rKLqb5CDJaRMJHokC6yKgSCR9JAukmokIknCQJpLOIrJFwMsBJELFcKHwM9BFkLBMKFxNcBCHlQ+FhoocgpVwwnv0Xn30QBJGMC0QcaBVJiAMiec/dcwKuL4j1QMsVCXFAJE4s4NQA3K/8Y6DzO4g40P7UcmIBJxbEesCKWBDg8wWxHrAiFgT4fEGsB/CwIhYE+AeBAAdPLOcV8HRmWRDAiQVcO7GcV8CLM8uCAE4sQCDAlHcQ7x+ABQEEAggEEAggEEAggEAAgQACASAQQCCAQACBAAIBBAIIBBAIIBBAIABe4e9iAe/xd7EAJxYgEGDeO4j3EODp/cOCAE4sYMyJ5cwCHs4rCwI4sYBxJ5YzC84rCwKcXxArAuthQYDzC2JF0H49LAhwYUGsCFqvx5EF2T07dMaJBetx4cRyaqFtHJ8EIhK0i8OJBQxcECuCVutxJhCRoE0cZwMRyRcFefa/ffZBVPogePihhyCnbBhcfMFFEFM+DD4m+ghSlgmDkwlOgpAl4+BkkJMgZdk4+EgaSCcpVX7bmY9kgXQQU+1TgE0c+QJZUUz1b2T4SBbIKmJW+3iMj2SBVBWz+leVfCQLpIqYbp8b85EskIxyfIOfK5Sf+wiCRJEsllQ+oqEkQfBxmD8BBgA5hVjXyrBNUQAAAABJRU5ErkJggg==);
			background-size: 100% 100%;
		
			.num {
				width: 36upx;
				height: 36upx;
				border-radius: 50px;
				font-size: 24upx;
				color: #fff;
				text-align: center;
				line-height: 36upx;
			}
		
			.sign {
				position: absolute;
				top: 0;
				left: 50%;
				line-height: 36upx;
				font-size: 12upx;
				color: #fff;
				transform: translateX(-50%);
			}
		}
		
	}
	
	/* 分类 */
	.cate-section {
		display: flex;
		justify-content: space-around;
		align-items: center;
		flex-wrap:wrap;
		padding: 30upx 15upx; 
		margin: 0upx $page-row-spacing;
		background: #fff;
		border-bottom:1px solid $border-color-base;
		.cate-item {
			display: flex;
			flex-direction: column;
			align-items: center;
			// width: 20%;
			font-size: $font-sm + 2upx;
			color: $font-color-dark;
		}
		
		image {
			width: 90upx;
			height: 90upx;
			margin-bottom: 14upx;
			// border-radius: 50%;
			// opacity: .7;
			// box-shadow: 4upx 4upx 20upx rgba(250, 67, 106, 0.3);
		}
		
	}
	
	
	// 热门
	.hot-section{
		margin: 0upx $page-row-spacing;
		padding-bottom: $page-row-spacing;
		border-bottom:1px solid $border-color-base;
		.hot-list{
			
			white-space:nowrap;
			// display: inline-block;
			


		}
		
		.list-item{
			line-height: 1.5;
			display: inline-block;
			vertical-align: top;
			width: 240upx;
			// height: 750upx;
			margin-right: $page-row-spacing;
			// font-size: $font-sm+2upx;
		
			
		}
	}
	//美容师
	.beautician-section{
		margin: 0upx $page-row-spacing;
		
		.beautician-item{
			padding-bottom: $page-row-spacing;
			border-bottom:1px solid $border-color-base;
			
		}
		.beautician-item-list{
			display:flex;
			flex-wrap:wrap;
			// padding: 0 30upx;
		}
		.beautician-item-list-tiem{
			display:flex;
			flex-direction: column;
			flex: 1;
			max-width: 25%;
			margin-top: $page-row-spacing;
			line-height: 1.5;
			display: inline-block;
			vertical-align: top;
						
			text{
				overflow:hidden;
				display: block;
				text-overflow:ellipsis;
				}
				.beautician-item-img{
					width: 168.75upx;
					height: 168.75upx;
					text-align: center;
					margin: auto;
					border-radius: 6upx;
				}
				.beautician-item-name{
					font-size: $font-base - 2upx;
					text-align: center;
					}
				.beautician-item-desc{
						font-size: $font-sm - 4upx;
						color: $uni-text-color-placeholder;
						white-space:nowrap;
							
						}
		}
		
		
	}
	
	
	
	//标题
	.title-view{
		margin: 10upx 0upx;
		display: flex;
		.title-text{
			// margin: 0upx $page-row-spacing;
			flex: 1;
			font-weight: bold;
			font-size: $font-lg
		}
		.title-btn{
			
			margin-right: $page-row-spacing;
			text-align: right;
			color: $font-color-pink;
			font-size: $font-sm ;
			float: right;
			width: 200upx;
			height: 100%;
		}
	}
	
	
	
	
	
</style>
