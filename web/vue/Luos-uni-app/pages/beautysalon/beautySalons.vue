<template>
	<div class = "container">
		<view class="list-cell" v-for="(item,index) in dataList" :key="index" @click="onitemclick(item)" >
			<view class="name-container text-container">
				<text class="name-text">{{item.name}}</text>
			</view>
			<view class="address-container text-container">
				<text class="ts ">地址：</text>
				<text class="info-text">{{item.address}}</text>
			</view>
			<view class="phone-contaier text-container">
				<text class="ts ">电话：</text>
				<text class="info-text">{{item.telphone}}</text>
			</view>
			
			
		</view>
		
	</div>
</template>


<script>
	export default {
		
		
		data(){
			return{
				baseUrl:this.api.baseUrl,
				dataList: [],
				
			}
		},
		onLoad() {
			this.loadData()
		},
		methods:{
			onitemclick(item){
				
				
				this.$eventHub.$emit('selectedBlock',item);
				
				uni.navigateBack();
			},
			
			loadData(){
					uni.request({
						url:this.api.getShopList,
						success: (res) =>  {
							console.log(res.data);
							var result = res.data;
							if(result){
								this.dataList = result.shopList	
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

<style lang="scss">
	
	page{
		background:$bg-color-gray;
	}
	.container{
		padding-left: $uni-spacing-col-base;
		padding-right: $uni-spacing-col-base;
		padding-bottom: $uni-spacing-col-base;
		
	}
	.list-cell{
		margin-top: $uni-spacing-col-base;
		padding: $uni-spacing-col-base;
		background: white;
		border-radius: 10upx;
		
		.text-container{
			display: flex;
			flex-flow: row nowrap;
			align-items: baseline;
			
			
			
			.ts{
				color:$font-color-base ;
				font-size: $font-sm;
				
			}
			
			.name-text{
				font-size: $font-base ;
				line-height: 2;
			}
			.info-text{
				
				flex: 1;
				font-size: $font-sm - 2;
				color:$font-color-base ;
				
				white-space: normal;
				word-wrap: break-word;
				word-break: break-all;
				line-height: 1.2;
			}
			
		}
	}
	
</style>
