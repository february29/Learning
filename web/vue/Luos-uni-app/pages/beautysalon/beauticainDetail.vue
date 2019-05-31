<template>
	<view class="contener">
		<!-- #ifdef MP|| H5 -->
		<!-- <uni-nav-bar  title = "美容师详情" left-icon="back" @click-left="back" fixed = "true" statusBar = "true"></uni-nav-bar> -->
		<!-- #endif -->
		<view class="top-content" >
			<image class="top-content-bg" src="../../static/bg_profile.png" >	
			</image>
			<view class="top-info">
				
				<image class="top-info-img" :src="baseUrl + 'beau_head/'+detail.photo" mode="aspectFill"></image>
				<text class="top-info-name">{{detail.name}}</text>
				<text class="top-info-level">{{detail.jobTitle}}</text>
				<view class="top-info-age">
					<text class="top-info-age-text">{{ detail.sex == 1 ? "♂":detail.sex == 0?"♀":""}}</text>
					<text class="top-info-age-text">{{ detail.age }}</text>
				</view>
				
			</view>
			
			
		</view>
		<view class="introduce">
			<view class="title-view">
				<image class="title-view-image" src="../../static/icon-brief-introduction-of-characters.png" ></image>
				<text class="title-view-title" >人物简介</text>
				<view class="title-view-line"></view>
			</view>
			
			<text class="introduce-detail">{{detail.profile}}</text>
		</view>
		<view class="service-time">
			<view class="title-view">
				<image class="title-view-image" src="../../static/icon-service-time.png" ></image>
				<text class="title-view-title" >服务时间</text>
				<view class="title-view-line"></view>
			</view>
			<view class="service-time-container">
				
				
				<beauty-service-time class = "beauty-service-time-item" v-for = "(item,idx) in detail.serverTimeList" :key="idx" :data = "item" :shouldReversal="true"></beauty-service-time>
			</view>
		</view>
		
	</view>
</template>

<script>
	import beautyServiceTime from '../../components/beauty-service-time.vue';
	
	export default {
		components:{
			beautyServiceTime,
		},
		data(){
			return{
				baseUrl:this.api.baseUrl,
				id:'',
				detail:{},
				
			};
		},
		onLoad(options) {
			this.id = options.id;
			this.loadData();
		},
		methods:{
			back(){
				uni.navigateBack();
				
			},
			loadData(){
				uni.request({
					url:this.api.showBeauticianl,
					data:{
						id:this.id,
						
					},
					success: (res) =>  {
						console.log(res.data);
						var result = res.data;
						if(result){
							this.detail = result.beauticianl;
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
	
	.contener{
		display: flex;
		flex-direction: column;
		// flex-wrap: nowrap;
		
		.top-content{
			// background: url("../../static/bg_profile.png");
			width: 100%;
			display: flex;
			flex-direction:column;
			justify-content: flex-end;
			// align-content: end;
			
			
			.top-content-bg{
				width: 100%;
				height: 333upx;
				
			}
			
			.top-info{
				display: flex;
				position: absolute;
				flex-direction:row;
				align-items: center;
				padding-bottom: $page-row-spacing;
				
				.top-info-img{
					width: 168upx;
					height: 168upx;
					margin-left: $page-row-spacing;
					border-radius: 10upx;
				}
				
				text{
					color: white;
					padding-left: $page-row-spacing;
					padding-right: $page-row-spacing;
					line-height:1.7;
					border-radius: 5upx;
					
				}
				.top-info-name{
					margin-left: $page-row-spacing;
					font-size: $font-base;
					
				}
				.top-info-level{
					background-color: $font-color-pink;
					margin-left: $page-row-spacing;
					font-size: $font-sm - 4upx;
				}
				.top-info-age{
					background-color: aqua;
					margin-left: $page-row-spacing;
					display: flex;
					border-radius: 5upx;
					padding: 0upx 12upx;
					
					.top-info-age-text{
						padding: 0upx;
						font-size: $font-sm - 4upx;
					}
					
				}
				
			}
			// height: 
		}
		.introduce{
			width: 100%;
			white-space: normal;
			
			
			.introduce-detail{
				margin: $page-row-spacing;
				font-size: $font-sm - 2upx;
				color:$uni-text-color-placeholder; 
				white-space: normal;
			}
			
		}
		.service-time{
			width: 750upx;
			display: flex;
			flex-direction: column;
			
			
			.service-time-container{
				width: 100%;
				display: flex;
				flex-direction: row;
				flex-wrap: wrap;
				// margin: $page-row-spacing;
				
				// height: 200upx;
			
				// padding: $page-row-spacing;
// 				padding-left: $page-row-spacing;
// 				padding-right: $page-row-spacing;

				margin-left:$page-row-spacing / 2; 
				margin-right:$page-row-spacing / 2; 
				
				.beauty-service-time-item{
					width: 168.75upx;
					height: 135upx;
					margin-top: $page-row-spacing; 
					margin-left: $page-row-spacing / 2;
					margin-right:$page-row-spacing / 2; 
				}
			}
			
			
		}
		
		.title-view{
			display: flex;
			flex-direction: row;
			// justify-content: center;
			align-items: center;
			margin: $page-row-spacing;
			
			
			.title-view-image{
				color: $font-color-pink;
				width: 30upx;
				height: 30upx;
				font-size: $font-base;
				
			}
			.title-view-title{
				margin-left: $page-row-spacing;
				margin-right: $page-row-spacing;
				color: $font-color-pink;
				font-size: $font-base;
			}
			
			.title-view-line{
				flex: 1;
				height: 2upx;
				background: $border-color-base;
			}
		}
		
	}
	
	
	
	
	
</style>
