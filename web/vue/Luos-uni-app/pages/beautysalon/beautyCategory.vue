<template>
	
	<view class="contener">
		<!-- #ifdef MP || H5 -->
		<!-- <uni-nav-bar title = "套餐分类" left-icon="back" @click-left="back" fixed = "true" statusBar = "true"></uni-nav-bar> -->
		<!-- #endif -->
		
		<segmented-control class = "segmentedControl" topfixedval='0px' :topfixed=true @clickitem="clickitem" :data = "tabBars" :currentIndex = 'currentIndex'>	</segmented-control>
		
		
		<swiper class="product-list-contener" :current="currentIndex" @change="changeTab"  :style="{height:contentHeigth + 'px'}" >
			<swiper-item class="product-list-conterner-item" v-for="(productItem,typeIndex) in productItemList":key="typeIndex">
				
				<scroll-view class="product-list" scroll-y="true" @scrolltolower="loadMoreData(productItem,typeIndex)" >
					<beauty-meal-item-comp class = "list-item"  
					v-for="(mealItem,mealIndex) in productItem.data"  
					:key="index"
					v-bind:mealItem = "mealItem"
					v-on:itemClick="navToDetailPage">
					</beauty-meal-item-comp>
					
				</scroll-view>
				
			</swiper-item>
		</swiper>
		
		
	</view>
    
</template>

<script>
	
	import segmentedControl from '../../components/segmented-control.vue';
	import beautyMealItemComp from '../../components/beauty-meal-item-comp.vue'
	
    export default {
		
		components:{
			beautyMealItemComp,
			segmentedControl
			
		},
        data() {
            return {
				baseUrl:this.api.baseUrl,
				
				productItemList:[],
				//{typeid:1,data:[],pageNow:0 }
                tabBars:[],
				
				contentHeigth:0,
				currentIndex:0,
            };
        },
		
// 		computed:{
// 			productItemList() {
// 				
// 				var itemList = [];
// 				for(var i = 0;i<this.tabBars.length;i++){
// 					//{typeid:1,data:[],pageNow:0 }
// 					var item = {
// 						typeId:this.tabBars[i].id,
// 						data:[],
// 						pageNow:1,
// 						}
// 					itemList.push(item)
// 				}
// 				return itemList;
// 			}
// 		},
		
		 onLoad(opotions) {
			
			this.currentIndex = opotions.idx;
			this.tabBars = JSON.parse(opotions.typeList);
			this.contentHeigth = uni.getSystemInfoSync().windowHeight - 60;
			
			for(var i = 0;i<this.tabBars.length;i++){
				//{typeid:1,data:[],pageNow:0 }
				var item = {
					typeId:this.tabBars[i].id,
					data:[],
					pageNow:1,
					hasLoad:false,
					hasMore:true,
					}
				this.productItemList.push(item)
			}
			this.loadData(true,this.currentIndex);
			// this.refreshData(this.productItemList[this.currentIndex],this.currentIndex);

		 },
		
        methods: {
			back(){
				uni.navigateBack();
				
			},
			//套餐详情页
			navToDetailPage(id) {
				// console.log("navToDetailPage");
				uni.navigateTo({
					url: '/pages/beautysalon/beautyMealDetail?id='+id
				})
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
			loadMoreData(productItem,typeIndex){
				if (productItem.hasMore == true){
					this.loadData(false,typeIndex);
				}
				
			},
			
			

			loadData(isRefresh,tapIndex) {
				var item =  this.productItemList[tapIndex];
				var pageSize = 10;
				uni.request({
						url:this.api.mealList,
						data:{
							type:item.typeId,
							pageSize:pageSize,
							pageNow:item.pageNow
						},
						success: (res) =>  {
							console.log(res.data);
							var result = res.data;
							if(result){
								item.pageNow++;
								item.hasLoad = true;
								if (isRefresh){
									item.data = result.mealList;
									
									item.hasMore = true;
								}else{
									for (var i = 0;i<result.mealList.length;i++) {
										item.data.push(result.mealList[i]);
										
									}
									if (result.mealList.length<pageSize){
										item.hasMore = false;
									}
									
								}
								
								console.log(this.productItemList)
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
            }
        
		},
       
        onPullDownRefresh() {
// 			this.pageNow = 1;
//             this.loadData(true);
            // 实际开发中通常是网络请求，加载完数据后就停止。这里仅做演示，加延迟为了体现出效果。
//             setTimeout(() => {
//                 uni.stopPullDownRefresh();
//             }, 2000);
        },
        onReachBottom() {
            // this.loadData(false);
        }
    };
</script>

<style lang="scss">
    /* product */
    page {
        background: $page-color-base;
		
    }
	
	.contener{
		width: 100%;
		height: 100%;
	}
// 	.segmentedControl{
// 		width: 100%;
//         height: 30upx;
// 	}


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
			// width: 50%;
			line-height: 1.5;
			display: inline-block;
			vertical-align: top;
			width: 355upx;
			background: white;
			// height: 750upx;
			// margin-right: $page-row-spacing;
			margin-top: $page-row-spacing;
			margin-left: $page-row-spacing;
			// font-size: $font-sm+2upx;
			// padding-left: $page-row-spacing;
			// padding-top: $page-row-spacing;
		
			
		}
    }

    
</style>
