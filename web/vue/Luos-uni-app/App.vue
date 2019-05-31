<script>
	// import api from "components/api.js"
	
	export default {
		onLaunch: function () {
			console.log('App Launch')
			// console.log('base url'+api.baseUrl);
		},
		onShow: function () {
			console.log('App Show')
		},
		onHide: function () {
			console.log('App Hide')
		}
	}
</script>




<style lang="scss">
	/*每个页面公共css */
	::-webkit-scrollbar{
		display:none;
		width: 0;
		height: 0;
		color: transparent;
	}
	
	
	.flex-row-nowarp{
		display: flex;
		flex-flow: row nowrap;
	}
	.flex-row-warp{
		display: flex;
		flex-flow: row wrap;
	}
	.flex-column-nowarp{
		display: flex;
		flex-flow: column nowrap;
	}
	
	
	.border-top-view{
		border-top: 1px solid $border-color-base;
	}
	.border-bottom-view{
		border-bottom: 1px solid $border-color-light;
	}
	.margin-left-right{
		margin-left: $uni-spacing-col-base;
		margin-right: $uni-spacing-col-base;
	}
	.padding-left-right{
		padding-left: $uni-spacing-col-base;
		padding-right: $uni-spacing-col-base;
		
	}
	.padding-top-bottom{
		padding-top: $uni-spacing-col-base;
		padding-bottom: $uni-spacing-col-base;
		
	}
	
// 	page{
// 		    overflow-x: hidden;     
// 		     overflow-y: hidden;     
// 	}
// 	body{     
//     overflow-x: hidden;     
//     overflow-y: hidden;     
// }     
	
// 	html{     
//     overflow-x: hidden;     
//     overflow-y: hidden;     
// 	}     
	
</style>
