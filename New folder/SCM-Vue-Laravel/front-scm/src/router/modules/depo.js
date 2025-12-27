// আগের লাইনটি পরিবর্তন করে নিচেরটি দিন (ProductManagement ফোল্ডার সহ)
import ProductReceiveList from '../../views/Depo/ProductManagement/ProductReceiveList.vue';

const depoRoutes = [
    { 
        path: 'depo/dashboard', 
        name: 'depo-dashboard',
        component: () => import('../../views/Depo/DepoDashboard.vue'), 
        meta: { requiresAuth: true, roles: ['depo'] } 
    },
    { 
        path: 'depo/product-receives', 
        name: 'depo-product-receive-list',
        component: ProductReceiveList, 
        meta: { requiresAuth: true, roles: ['depo'] } 
    },

    {
    path: 'depo/current-stock',
    name: 'depo-stock-list',
    component: () => import('../../views/Depo/ProductManagement/DepoStockList.vue'),
    meta: { requiresAuth: true, roles: ['depo'] }
}
];

export default depoRoutes;