import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import Login from '@/pages/Login'
import Signup from '@/pages/Signup'
import Depot from '@/pages/Depot'
import Purchase from '@/pages/Purchase'
import Querysell from '@/pages/Querysell'
import Recordsell from '@/pages/Recordsell'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      redirect: '/depot'
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    },
    {
      path: '/depot',
      name: 'Depot',
      component: Depot
    },
    {
      path: '/purchase',
      name: 'Purchase',
      component: Purchase
    },
    {
      path: '/querysell',
      name: 'Querysell',
      component: Querysell
    },
    {
      path: '/recordsell',
      name: 'Recordsell',
      component: Recordsell
    },
  ]
})
