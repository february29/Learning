<!-- glance 滑动标签导航栏 -->
<template>
	<view class="mcontainer" :style="{background: bgcolor}" >
		<!-- 横向滚动菜单 -->
		<scroll-view class="glance-slidenav-tabbar" scroll-x="true" scroll-left="0" scroll-with-animation="true" :scroll-into-view="curscrollitem" @scroll="scollerChangePostion(e)">
			<!-- item -->
			<view class="glance-slidenav-tabbar-item" v-for="(item,index) in gettabbars" :id="item.id" :key="index" :style="{width:itemWidthPercent + '%'}" @click="clickitem(index,item)">
				
				<!-- 文字 -->
				<view class="glance-slidenav-tabbar-item-text" :class="[index == activeitemindex? 'glance-slidenav-tabbar-item-text-magnify':'']" 
				 :style="{color: [index == activeitemindex ? activetextcolor : textcolor],fontSize: fontsize }">
				 {{item.type?item.type:item.job_title}}
				</view>
				
				<!-- 下划线框 (itemWidthPercent * underlinewidthPersent)/100 + '%'-->
				<view  class="glance-slidenav-tabbar-item-line"  :style="{background: [index == activeitemindex ?underlinecolor:''],height:underlineheight, width:underlinewidthPersent + '%'}" >	
				</view>	 
				
				
			</view>
			
		</scroll-view>
		<!-- 下划线 -->
		<!-- <view class="glance-slidenav-tabbar-underline" ref = 'underline' :style="{background: underlinecolor,height:underlineheight, width:(itemWidthPercent * underlinewidthPersent)/100 + '%'}" ></view> -->
	</view>
</template>

<script>
	export default {
		name: 'glanceSlideNavTabBar',
		props: {
			//载入的标签数据
			data: Array,
			//组件背景颜色
			bgcolor:{
				type:String,
				default: '#FFFFFF'
			},
			
			//字体大小
			fontsize:{
				type: String,
				default: '13px'
			},
			//文字默认初始化颜色
			textcolor:{
				type:String,
				default:'#999999'
			},
			//活动的项目文字颜色
			activetextcolor:{
				type: String,
				default: '#000000'
			},
			//下划线颜色
			underlinecolor:{
				type: String,
				default: '#6495ED'
			},
			//下划线高度
			underlineheight:{
				type: String,
				default: '2rpx'
			},
			//下划线百分比
			underlinewidthPersent:{
				type: String,
				default: '90'
			},
			currentIndex:{
				type:Number,
				default:0
			}
		},
		data() {
			return {
				//当前活动的item
				// activeitemindex:0,
				// 滚动到点击的项目位置 初始化第一个
				// curscrollitem: 'glsntb-0',
				selfdata:[
					{
						textcontent:'',//文字内容
						activeviewid:''//当前活动的子标签id
					}
				]
			};
		},
	computed: {
		gettabbars(){
			//主组件需要:data = [{},{}]格式导入标签对象
			let tabitems = []
			this.data && this.data.forEach((item, index) => {
				tabitems.push(item)
				}
			)
			return tabitems
		},
		activeitemindex(){
			return this.currentIndex;
		},
		
		itemWidthPercent(){
			return this.data.length<=4 ? 100/this.data.length:25
		}
		
		
	},
	methods:{
		// 点击项目事件处理
		clickitem(idx,val){
			// 设置当前点击的项目id
			// this.curscrollitem = 'glsntb-' + idx
			// 设置当前活动的项目索引值
			this.currentIndex = idx
			// 父组件通信事件
			this.$emit('clickitem',idx,val)
		},
		
		scollerChangePostion(e){
			// this.$refs.underline.
			// event.detail = {scrollLeft, scrollTop, scrollHeight, scrollWidth, deltaX, deltaY}
			console.log(e)
		}
	}
}
</script>

<style lang="scss">
	.mcontainer{
		width: 100%;
		height: 70upx;
	}
	.glance-slidenav-tabbar{
		height: 100%;
		white-space:nowrap;
		// display: inline-block;
		
// 		display: flex;
// 		flex-flow: row nowarp;
// 		justify-content: flex-start;
// 		align-items: center;

// 		flex-direction: row;
// 		flex-wrap: nowarp;
		
		
		// z-index: 1;
		
		
	}
	.glance-slidenav-tabbar-item{
		// height: 100%;

		display: inline-block;
		
// 		vertical-align: middle;
// 		display: table-cell;
		text-align: center;
		// text-align: center;
		// vertical-align: middle;
// 		display: flex;
// 		flex-direction: column;
// 		justify-content: space-between;
// 		align-items: center;
		// float: left;
		
		// flex-wrap: nowrap;
		
		// margin: auto;
		// vertical-align: top;
		.glance-slidenav-tabbar-item-text{
			
			// flex: 1;
			
			width: 100%;
			// height: 59upx;
			text-align: center;
			
			line-height: 2.6;
			// display: inline-block;
			// line-height: 45upx;
			// padding-bottom: 5upx;
			// vertical-align: bottom;
				
		}
		
		.glance-slidenav-tabbar-item-text-magnify{
			-webkit-transform: scale(1.1);
			transform: scale(1.1);
			
			
		}
		
		.glance-slidenav-tabbar-item-line{
			padding-bottom: 0upx;
			margin: auto;
			// margin-top: 10upx;
			
			// width: 100%
			// border-bottom: 2upx solid red;
		}
		
		
		
			
		
	}
	
	
// 	.glance-slidenav-tabbar-itme-underline{
// 		border-radius:10upx;
// 		width: 100%;
// 		height: 2upx;
// 		-webkit-border-radius:10upx; 
// 		-moz-border-radius:10upx;
// 		}
</style>
