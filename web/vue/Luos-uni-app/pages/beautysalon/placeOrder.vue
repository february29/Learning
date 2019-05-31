<template>
	<view class="container">
	<!-- 套餐信息-->
	<view class="service-info-container list-item-bg-white padding-left-right">
		<image :src="mealFirstPic" class="info-image" mode="aspectFill"></image>
		<view class="info-container">
			<text class="info-name">{{mealDetail.name}}</text>
			<text class="info-desc">{{mealDetail.gjz}}</text>
			
			<view class="info-price">
				<text class="info-price-text" >{{mealDetail.price * mealDetail.rate}}</text>
				<text class="info-price-text2" v-if="mealDetail.rate < 1">{{mealDetail.price }}</text>
			</view>
			
		</view>
	</view>
	<!-- 价格信息 -->
	<view class="price-info-container list-item-bg-white padding-left-right">
			<view class="price-info-item list-item-bg-white border-bottom-view">
				<text class="price-info-item-left">套餐金额</text>
				<text class="price-info-item-right">{{noTimeDiscountTotleMoney}}</text>
			</view>
			
			<view class="price-info-item list-item-bg-white border-bottom-view">
				<text class="price-info-item-left" v-if="allTimeDiscountMoney <= 0">时段加成</text>
				<text class="price-info-item-left" v-if="allTimeDiscountMoney > 0">时段优惠</text>
				<text class="price-info-item-right">{{(Math.abs(allTimeDiscountMoney)) }}</text>
			</view>
			
		
	</view>
	<!-- 客服信息 -->
	<view class="customer-view list-item-bg-white padding-left-right price-info-item">
		<text class="price-info-item-left">联系客服</text>
	</view>
</view>

</template>

<script>
	 export default {
		 data() {
            return {
				baseUrl:this.api.baseUrl,
				
				mealDetail:{},
				//{typeid:1,data:[],pageNow:0 }
                
				totleMoney:0,
				selectedTimes:[],
				
            };
        },
		computed: {
			timeAdditons(){
				var timeAdditons = 0;
				for ( var i = 0 ;i < this.selectedTimes.length;i++) {
					var timeItme =  this.selectedTimes[i];
					
					timeAdditons += timeItme.addition;
				}
				
				return timeAdditons;
			},
			// 没有时段优惠的总价格
			noTimeDiscountTotleMoney(){
				 
				return this.mealDetail.price * this.mealDetail.rate * this.selectedTimes.length;
			},
			//时段总优惠的价格
			allTimeDiscountMoney(){
				 
				return this.mealDetail.price * this.mealDetail.rate * this.selectedTimes.length - this.totleMoney;
			},
			mealFirstPic(){
				 
				return this.baseUrl+'meal/' + this.mealDetail.pic.split(',')[0];
			},
			
			
			
			
			
		},
		onLoad(opotions) {
			
			this.mealDetail = JSON.parse(opotions.mealDetail);
			this.selectedTimes = JSON.parse(opotions.selectedTimes);
			this.totleMoney = JSON.parse(opotions.totleMoney);
			console.log("selectedTimes:"+this.selectedTimes);
			console.log("totleMoney:"+this.totleMoney);
		},
		
	 }
	
	
</script>

<style lang="scss" >
	page{
		background:$bg-color-gray;
	}
	
	view{
		box-sizing:border-box;
	}
	.list-item-bg-white{
		background: white;
	}
	
	.price-info-item{
				width: 100%;
				display: flex;
				flex-flow: row nowrap;
				justify-content: space-between;
				line-height:80upx;
				
				
	}
	
	.price-info-item-left{
		font-size: $font-base - 2upx;
		color: $font-color-base;
	}
	.price-info-item-right{
		font-size: $font-base - 2upx;
		color: $font-color-pink;
	}
	.price-info-item-right:before{
		content: "¥";
	}
	
	.container{
		
		display: flex;
		flex-flow: column nowrap;
		align-items: flex-start;
		// width: 100%;
		
		//套餐信息
		.service-info-container{
			
			display: flex;
			flex-flow: row nowrap;
			justify-content: center;
			align-items: flex-start;
			width: 100%;
			margin-top: $uni-spacing-col-base;
			.info-image{
				width: 168.75upx;
				height: 168.75upx;
			}
			.info-container{
				flex: 1;
				margin-left: 10upx;
				padding-top: 10upx;
				padding-bottom: 10upx;
				.info-name{
					// width: 100%;
					font-size: $font-base - 2upx;
					color: $font-color-base;
				}
				.info-desc{
					// width: 100%;
					font-size: $font-sm - 2upx;
					white-space: normal;
					word-wrap: break-word;
					word-break: break-all;
					line-height: 1.5;
					color: $uni-text-color-placeholder;
					
				}
				.info-price{
					display: flex;
					flex-flow: row nowrap;
					align-items: center;
					.info-price-text{
						// width: 100%;
						font-size: $font-base;
						color: $font-color-pink;
					}
					.info-price-text2{
					
					font-size: $font-sm - 2upx;
					color: $uni-text-color-placeholder;
					text-decoration: line-through;
					}
					.info-price-text:before{
						content: "¥";
					}
					.info-price-text2:before{
						content: "¥";
					}
				}
				
			}
		}
		//价格信息
		.price-info-container{
			display: flex;
			flex-flow: column nowrap;
			width: 100%;
			margin-top: $uni-spacing-col-base;
			
		}
		
		//客服信息
		.customer-view{
			width: 100%;
			margin-top: $uni-spacing-col-base;
		}
		
		
	}
	
	
	
</style>
