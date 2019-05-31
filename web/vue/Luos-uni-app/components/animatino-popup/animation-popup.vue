<template>
	<!--  -->
	<view v-show="ifshow" @tap="close" class="popup-container animated faster " :class="[showanimation ? 'fadeIn function-ease-out':'fadeOut function-ease-in',_popanimationduration]" :style="{background:_background}" >
		<view class="postion-content":style="_postion">
			<view ref="popRef" class="popup-content animated" @tap.stop="stopEvent" :class="showanimation?_popanimationin:_popanimationout"  >
				<slot></slot>
			</view>
		</view>
		
	</view>
</template>

<script>
	
	// https://github.com/daneden/animate.css
	//https://daneden.github.io/animate.css/
	import './animate.min.css'
	export default {
		name: 'animation-popup',
		props: {
// 			direction: {
// 				type: String,
// 				default: 'top', // 方向  top，bottom，left，right 
// 			},
			background:{
				type:String,
				default:"#00000055",
			},
			postion:{
				type: String,
				default: 'center', // 位置 center top，bottom，left，right custom
			},
			
			//slow	2s slower	3s fast	800ms faster	500ms
// 			popanimationduration:{
// 				type:String,
// 				default:"fast",  
// 			},
			
			popanimationin:{
				type:String,
				default:"",
			},
			
			popanimationout:{
				type:String,
				default:"" ,
			},
		},
		data() {
			return {
				ifshow: false, // 是否展示,
				timer: null,
				iftoggle: false,
				showanimation:false,

			};
		},
		computed: {
			_background(){
				return this.background;
			},
			_popanimationduration(){
				return this.popanimationduration;
			},
			_popanimationin(){
				return this.popanimationin;
			},
			_popanimationout(){
				return this.popanimationout;
			},
			_postion(){
				const positionValue = {
					'top': 'flex-flow: row nowrap;justify-content: center;',
					'left': 'flex-flow: column nowrap;justify-content: center;',
					'bottom': 'flex-flow: column-reverse nowrap;align-items: center;',
					'right': 'flex-flow: row-reverse nowrap;align-items: center;',
					'center':'flex-flow: row nowrap;justify-content: center;align-items: center;'
				};
				return positionValue[this.postion];
			}
			
		},
		methods: {
			show() {
				this.ifshow = true;
				
				this.showanimation = true;
				
				let _open = setTimeout(() => {
					_open = null;
				}, 100)
				let _toggle = setTimeout(() => {
					this.iftoggle = true;
					_toggle = null;
				}, 500);
			},
			close() {
				if (this.timer !== null || !this.iftoggle) {
					return;
				}
				this.showanimation = false;
				this.timer = setTimeout(() => {
					this.ifshow = false;
					this.timer = null;
					this.iftoggle = false;
				}, 500);
			},
			stopEvent(event) {},
			
		}
	}
</script>

<style lang="scss">
	.popup-container {
		position: fixed;
		z-index: 999999;
		height: 100%;
		width: 100%;
		top: 0px;
		left: 0px;
		
	}
	.postion-content{
		position: fixed;
		z-index: 1000000;
		display: flex;
		width: 100%;
		height: 100%
	}
	.popup-content {
		position: fixed;
		z-index: 1000000;
		
		
// 		//top
// 		flex-flow: row nowrap;
// 		justify-content: center;
// 		//left
// 		flex-flow: column nowrap;
// 		justify-content: center;
// 		//bottom
// 		flex-flow: column-reverse nowrap;
// 		align-items: center;
// 		//rigth
// 		flex-flow: row-reverse nowrap;
// 		align-items: center;
// 		//center
// 		flex-flow: row nowrap;
// 		justify-content: center;
// 		align-items: center;
		
		
// 		background: #FFFFFF;
// 		transition: all .3s ease;
	}
	
	
	//======================================动画相关=====================================
	
	.function-linear{
		-webkit-animation-timing-function:linear;
		animation-timing-function: linear;
	}
	// 动画以低速开始，然后加快，在结束前变慢。
	.function-ease{
		-webkit-animation-timing-function:ease;
		animation-timing-function: ease;
	}
	//动画以低速开始。
	.function-ease-in{
		-webkit-animation-timing-function:ease-in;
		animation-timing-function: ease-in;
	}
	
	//动画以低速结束。
	.function-ease-out{
		-webkit-animation-timing-function:ease-out;
		animation-timing-function: ease-out;
	}
	//动画以低速开始和结束。
	.function-ease-in-out{
		-webkit-animation-timing-function:ease-in-out;
		animation-timing-function: ease-in-out;
	}
	//cubic-bezier(0.215, 0.61, 0.355, 1);
	
	//----------------------------------------------------------------------
	
	
</style>
