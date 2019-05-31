<template>
	<view class="list-item" @click="itemClick(mealItem)">
		<view class="item-img-contener">
			<image class="item-img" :src="baseUrl+'meal/'+mealItem.pic" mode="aspectFill"></image>
		</view>
		<text class="item-name">{{mealItem.name}}</text>
		<text class="item-desc">{{mealItem.gjz}}</text>
		<view class="item-price-contener">
			<text class="item-price">{{'¥'+ ( mealItem.price * mealItem.rate + '/' +mealItem.unit)}}</text>
			<text class="item-price item-price2"  >{{ mealItem.rate < 1? ('¥'+ mealItem.price  + '/' +mealItem.unit):''}}</text>
		</view>
					
	</view>
	<!-- <text>{{this.mealitem}}</text> -->
</template>

<script>
	export default {
		
		
		props:{
			mealItem:Object
		},
		
		methods:{
			itemClick(mealItem){
				// console.log("item click")
				this.$emit("itemClick",mealItem.id)
			}
		}
// 		data(){
// 			return{
// 				item:mealItem
// 			}	
// 		},
// 		onLoad() {
// 			console.log("dfadf",item)
// 		}
	}
	
	
</script>

<style lang="scss">
	
	
				
	
		text{
			overflow:hidden;
			display: block;
			// text-overflow:ellipsis;
			white-space:nowrap;
			margin-left: 5upx;
			margin-right: 5upx;
		}
		.item-img-contener{
			width: 100%;
			height: 0upx;
			padding-bottom: 100%;
			position: relative;
		}
		.item-img{
// 				width: 240upx;
// 				height: 240upx;
			width: 100%;
			height: 100%;
			position: absolute;
			border-radius: 6upx;
		}
		.item-name{
			font-size: $font-base - 2upx;
			margin-top: 10upx
			
			
		}
		.item-desc{
// 				display: inline-block;
// 				height: 22upx;
// 				width: 100%;
			font-size: $font-sm - 4upx;
			color: $uni-text-color-placeholder;
			
		}
		.item-price-contener{
			// vertical-align: text-top;
			// display: inline;
			// position: absolute;
			margin-top: -7upx;
			
		}
		.item-price{
			// vertical-align: text-bottom;
			display: inline;
			font-size: $font-base;
			color: $font-color-pink;
			line-height: 1;
			// position: absolute;
			
		}
		.item-price2{
			
			// vertical-align: text-bottom;
			font-size: $font-sm - 2upx;
			color: $uni-text-color-placeholder;
			text-decoration: line-through;
		}
		
			
	
</style>
