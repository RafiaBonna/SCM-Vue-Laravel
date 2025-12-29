// আগের লাইনটি পরিবর্তন করে নিচেরটি দিন (ProductManagement ফোল্ডার সহ)
import ProductReceiveList from '../../views/Depo/ProductManagement/ProductReceiveList.vue';
import DistributorList from './components/depo/usermanagement/distributor/List.vue';
import DistributorCreate from './components/depo/usermanagement/distributor/Create.vue';

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
},
{
    path: 'product-receive/invoice/:id',
    name: 'depo-receive-invoice',
    component: () => import('../../views/Depo/ProductManagement/DepoReceiveInvoice.vue'),
    meta: { title: 'Receive Invoice' }
},
{ 
        path: '/depo/distributors', 
        name: 'DistributorList',
        component: DistributorList 
    },
    { 
        path: '/depo/distributors/create', 
        name: 'DistributorCreate',
        component: DistributorCreate 
    },

];

export default depoRoutes;