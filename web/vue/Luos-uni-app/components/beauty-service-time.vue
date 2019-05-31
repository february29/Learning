<template>
	<view :class="_replaceClass? 'beauty-service-time-item2':'beauty-service-time-item'" @click="itemClick(showData)">
		<view class="top" :class="'top-'+showData.state">
			<text class="top-date" :class="'top-date-'+showData.state" >{{showData.date}}</text>
			<text class="top-week" :class="'top-week-'+showData.state" >{{showData.week}}</text>
		</view>
		<view class="bottom" :class="'bottom-'+showData.state">
			<text class="bottom-time" :class="'bottom-time-'+showData.state" >{{showData.time}}</text>
		</view>
		
	</view>
</template>

<script>
	
	import {formatDate} from '../common/dateUtils.js'
	export default {
		
		props:{
			data:{
				type:Object,
				default:{}
			},
			//是否需要反转， 美容师详情页和套餐详情页弹出框模式不一样，美容师详情需要反转
			shouldReversal:{
				type:Boolean,
				default:false
			},
			replaceClass:{
				type:Boolean,
				default:false
			},
			
		},
		
		
		
		computed:{
			_replaceClass(){
				return this.replaceClass;
			},
			showData(){
				var d = {};
				if (this.data.id == -1){
					d.date = "～ ～ ～ ～";
					d.week = "任意时段";
					d.time = "^_^";
					// 0未被预约可点击未选中 ， 1已被预约不可点击  2可点击已经选中
					d.showTime =  d.week ;
				}else{
					var startTime = new Date(this.data.start_time);
					var endTime = new Date(this.data.end_time);
					d.date = formatDate(startTime,'yyyy-MM-dd') 
					d.week = formatDate(startTime,'EEE') 
					d.time = formatDate(startTime,'HH:mm')+'~'+ formatDate(endTime,'HH:mm');
					d.showTime = d.date + ' ' + d.time;
				}
				if (this.shouldReversal){
					if (this.data.isMake == 0) {
						d.state = 2;
					} else{
						d.state = 1;
					}
					
				}else{
					d.state = this.data.isMake;
				}
				
				
				return d;
			}
		},
		
		methods:{
			
			itemClick(showData){
				
// 				if(!this.shouldReversal){
// 					//表示套餐详情页面，此时需要改变显示状态
// 					if(this.data.isMake == 0){
// 						this.data.isMake = 2;
// 					}else if(this.data.isMake == 2){
// 						this.data.isMake = 0;
// 					}
// 				}
				
				//设置 需要显示在详情页面上的字符串
				this.data.showTime = showData.showTime;
				// console.log("item click",showData)
				this.$emit("itemClick",this.data)
			}
			
			
			

		}
		
		
	}
	
</script>

<style lang="scss">
	
	.top{
		display: flex;
		flex-direction: column;
		justify-content: center;
		background: $font-color-pink;
		width: 100%;
		height: 55%;
		border-radius:8upx 8upx 0upx 0upx;

		.top-date{
			color: white;
			text-align: center;
			font-size:$font-sm - 4upx;
		}
		.top-week{
			color: white;
			text-align: center;
			font-size:$font-sm - 2upx;
		}
	}
	
	
	
	
	.bottom{
		display: flex;
		flex-direction: column;
		justify-content: center;
		background: $font-color-deeppink;
		width: 100%;
		height: 45%;
		border-radius:0upx 0upx 8upx 8upx;
		
		.bottom-time{
			color: white;
			text-align: center;
			font-size: $font-sm - 2upx;
		}
	}
	
	
	// 0未被预约可点击未选中 ， 1已被预约不可点击  2可点击已经选中
	
	//state 0
	.top-0{
		background:#cccccc;
		.top-date-0{
			color: $font-color-base
		}
		.top-week-0{
			color: $font-color-base
		}
	}
	.bottom-0{
		background: #b9b9b9;
		.bottom-time{
			color: $font-color-base;
		}
	}
	
	//state 1
	.top-1{
		background: #cccccc;
		.top-date-1{
			color: $font-color-light
		}
		.top-week-1{
			color: $font-color-light
		}
	}
	.bottom-1{
		background: #b9b9b9;;
		.bottom-time-1{
			color: $font-color-light;
		}
	}
	
	//state 2
	.top-2{
		background: $font-color-pink;
		.top-date-2{
			color: white
		}
		.top-week-2{
			color: white
		}
	}
	.bottom-2{
		background: $font-color-deeppink;
		.bottom-time-2{
			color: white;
		}
	}
	
	
</style>
