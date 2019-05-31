import Vue from 'vue'
import App from './App.vue'

//导入组件第三方组件
import VueRouter from 'vue-router';
import vueRource from 'vue-resource';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';

//挂载组件
Vue.use(VueRouter)
Vue.use(vueRource)
Vue.use(ElementUI);

//导入自己的组件
import Login from './components/Login.vue'
import Home from './components/Home.vue'
import Customer from './components/Home/Customer.vue'
import Order from './components/Home/Order.vue'
import StoreHouse from './components/Home/StoreHouse.vue'



// 2. 定义路由
// 每个路由应该映射一个组件。 其中"component" 可以是
// 通过 Vue.extend() 创建的组件构造器，
// 或者，只是一个组件配置对象。
// 我们晚点再讨论嵌套路由。
const routes = [
    { path: '/', component: Login },

    { path: '/login', component: Login },


    { path: '/home', component: Home,
      children:[
          { path: 'customer', component: Customer },//注意没有/
          { path: 'order', component: Order },
          { path: 'storeHouse', component: StoreHouse },
      ]

    }
]

// 3. 创建 router 实例，然后传 `routes` 配置
// 你还可以传别的配置参数, 不过先这么简单着吧。
const router = new VueRouter({
  routes // (缩写) 相当于 routes: routes
})

Vue.config.productionTip = false

new Vue({
   render: h => h(App),
  router
}).$mount('#app')
