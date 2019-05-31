import Vue from 'vue'
import App from './App'
// import api from '/components/api.vue'
import api from './components/api.js'
import store from "./store/store.js"
import uniNavBar from './components/uni-nav-bar.vue'
import uniIcon from './components/uni-icon.vue' 

Vue.config.productionTip = false
Vue.component('uni-nav-bar',uniNavBar)
Vue.component('uni-icon',uniIcon)

App.mpType = 'app'

Vue.prototype.$eventHub = new Vue();
Vue.prototype.api = api;
Vue.prototype.store = store;
const app = new Vue({
    ...App
})
app.$mount()
