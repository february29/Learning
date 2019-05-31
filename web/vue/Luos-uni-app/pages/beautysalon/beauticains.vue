<template>
	<div>
		<!-- #ifdef MP || H5 -->
		<!-- <uni-nav-bar  title = "美容师" left-icon="back" @click-left="back" fixed = "true" statusBar = "true"></uni-nav-bar> -->
		<!-- #endif -->
		
		<segmented-control class = "segmentedControl" topfixedval='0px' :topfixed=true @clickitem="clickitem" :data = "tabBars" :currentIndex = 'currentIndex'>	</segmented-control>
		
		
		<swiper class="product-list-contener" :current="currentIndex" @change="changeTab"  :style="{height:contentHeigth + 'px'}" >
			<swiper-item class="product-list-conterner-item" v-for="(typeItem,typeIndex) in productItemList":key="typeIndex">
				
				<scroll-view class="product-list" scroll-y="true" @scrolltolower="loadMoreData(typeItem,typeIndex)" >
					<view class = "list-item" v-for="(item,index) in typeItem.data" :key="index" @click="buauticainsClick(item)"  :class="index%2==0?'list-item-bg-white':''">
						<image class = "list-item-img" :src="baseUrl+'beau_head/'+item.photo" mode="aspectFill"></image>
						<view class="list-item-info">
							<view class="list-item-top">
								<text class = "list-item-name">{{item.name}}</text>
								<text class = "list-item-sex">{{item.sex == 1 ? "♂":item.sex == 0?"♀":""}}</text>
								<text class = "list-item-age">{{item.age}}</text>
								<view class = "list-item-level">{{item.jobTitle}}</view>
								<view class = "list-item-disable" v-if="!item.hasTime" >客人已满</view>
							</view>
							<text class = "list-item-desc">{{item.profile}}</text>
						</view>
						
						
					</view>
					
				</scroll-view>
				
			</swiper-item>
		</swiper>
		
	</div>
</template>

<script>
	
	import segmentedControl from '../../components/segmented-control.vue';
	export default {
		components:{
			segmentedControl
		},
		data() {
		    return {
				baseUrl:this.api.baseUrl,
				
				productItemList:[],
				//{typeid:1,data:[],pageNow:0 }
		        tabBars:[],
				
				shopId:0,
				mealId:0,
				type:0,
				
				contentHeigth:0,
				currentIndex:0,
		    };
		},
		onLoad(options) {
								
			
			this.tabBars = [];
			this.contentHeigth = uni.getSystemInfoSync().windowHeight - 60;
			this.shopId = options.shopId;
			this.type = options.type;
			this.mealId = options.mealId;
			// this.getTypeItem();
			
			
			let _this = this;
			this.getTypeItem(function(tabBars){
				for(var i = 0;i<tabBars.length;i++){
					//{typeid:1,data:[],pageNow:0 }
					var item = {
						jobTitleId:tabBars[i].id,
						data:[],
						pageNow:1,
						hasLoad:false,
						hasMore:true,
						}
					_this.productItemList.push(item)
				}
				_this.loadData(true,_this.currentIndex);
			})
	
				
		},
		methods:{
			
			
			back(){
				uni.navigateBack();
				
			},
			//底部segment切换事件。（滑动切换，或者点击顶部改变currentIndex导致的切换）
			async changeTab(e) {
				let index = e.target.current;
				if(this.productItemList[index].hasLoad == false ){
					this.loadData(false,index)
				}
				this.currentIndex = index
			
			},
			//顶部segment点击事件
			clickitem(idx){
				this.currentIndex = idx;
			},
			buauticainsClick(item){
				console.log(item);
				if (!this.shopId ){
					//从主页更多跳转进来 查看详情
					uni.navigateTo({
						url: '/pages/beautysalon/beauticainDetail?id='+item.id
					})
				}else{
					//从详情页选择美容师跳转进来 选择美容师返回上一页
					this.$eventHub.$emit('selectedBlock',item);
					
					uni.navigateBack();
				}
			},
			
			
			loadMoreData(typeItem,typeIndex){
				if (typeItem.hasMore == true){
					this.loadData(false,typeIndex);
				}
				
			},
			
			loadData(isRefresh,tapIndex) {
				var item =  this.productItemList[tapIndex];
				var pageSize = 10;
				uni.request({
					url:this.api.beauticianlList,
					data:{
						job_title:item.jobTitleId,//美容师等级
						shopId:this.shopId,//店面
						mealId:this.mealId,//套餐ID
						type:this.type,//美容师类型
						pageSize:pageSize,
						pageNow:item.pageNow
					},
					success: (res) =>  {
						var result = res.data;
						if(result){
							item.pageNow++;
							item.hasLoad = true;
							if (isRefresh){
								//清空数据
								item.data = [];
								item.hasMore = true;
							}else{
								if (result.benauticianlList.length<pageSize){
									item.hasMore = false;
								}
								
							}
							//添加数据
							for (var i = 0;i<result.benauticianlList.length;i++) {
								//增加是否有时间字段
								var it = result.benauticianlList[i];
								var itTimes = it.serverTimeList;
								it.hasTime = false;
								for (var j = 0;j<itTimes.length;j++) {
									if (itTimes[j].isMake == 0){
										it.hasTime = true;
										break;
									}
								}
								item.data.push(it);
							
								console.log(it);
							}
							
							// console.log(this.productItemList)
							// console.log(this.productList)
							
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
			},
			
			getTypeItem(callback){
				uni.request({
					url: this.api.getJobTitleList,
					method: 'GET',
					
					success: (res) =>  {
						var result = res.data;
						if(result){
							
							
							this.tabBars =[];
							
							var all = {id: 0, job_title: "全部", pri: 0, hidden: 0}
							this.tabBars.push(all)
							for (var i = 0 ;i< result.jobTitleList.length;i++) {
								this.tabBars.push(result.jobTitleList[i]);
							}
							
							
							if (callback) {
								callback(this.tabBars);
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
					},
					complete: () => {}
				});
			}
			
			
			
			
		},
		
		
	}
	
</script>

<style lang="scss">
	
	page{
		background:$bg-color-gray;
	}
	
	.product-list-contener{
			
			white-space:nowrap;
			height:calc(100% - 100upx);
	
	// 		display: flex;
	//         /*height: 100%;*/
	//         flex: 1;
			.product-list-conterner-item{
				// height: calc(100%  -  60upx);
			}
			
		}
		.product-list {
	        // display: inline-block;
			display: flex;
	        width: 100%;
			height: 100%;
	        flex-wrap: wrap;
			white-space:normal;
	        // flex-direction: row;
			
			.list-item{
				display: flex;
				flex-flow: row nowrap;
				align-items: center;
				width: 100%;
				height: 200upx;
				.list-item-img{
					margin-left: 20upx;
					width: 120upx;
					height: 120upx;
					border-radius: 50%;
				}
				.list-item-info{
					padding: 0upx 15upx;
					flex: 1;
					height: 100%;
					display: flex;
					flex-flow: column nowrap;
					// align-items: center;
					justify-content: center;
					
					.list-item-top{
						width: 100%;
						display: flex;
						align-items: center;
						.list-item-name{
							font-size: $font-base;
						}
						.list-item-sex{
							margin-left: 10upx;
							font-size: $font-lg;
							color: $font-color-pink;
						}
						.list-item-age{
							margin-left: 10upx;
							font-size: $font-base - 2upx;
							color: $font-color-base;
						}
						.list-item-level{
							color: white;
							margin-left: 10upx;
							font-size: $font-sm - 6upx;
							padding: 0upx 15upx;
							border-radius: 5upx;
							background: $font-color-pink;
							
						}
						.list-item-disable{
							color: white;
							background: $font-color-disabled;
							margin-left: 10upx;
							font-size: $font-sm - 6upx;
							padding: 0upx 15upx;
							border-radius: 5upx;
							
						}
					}
					.list-item-desc{
						
						
						padding-top: 15upx;
						
						color: $font-color-base;
						font-size:  $font-sm - 2upx;
						
						//只显示两行
						white-space: normal;
						word-break:break-all;
						word-wrap: break-word;
						display:-webkit-box;
						-webkit-line-clamp:2;
						-webkit-box-orient:vertical;
						overflow:hidden;
				
						
					}
				}
			}
			.list-item-bg-white{
				background: white;
			}
	    }
	
</style>
