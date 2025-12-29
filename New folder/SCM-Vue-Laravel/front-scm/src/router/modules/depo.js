import ProductReceiveList from '../../views/Depo/ProductManagement/ProductReceiveList.vue';
// আপনার বর্তমান লোকেশন (src/router/modules/) থেকে views ফোল্ডারে যাওয়ার সঠিক পাথ
import DistributorList from '../../views/Depo/usermanagement/distributor/List.vue';
import DistributorCreate from '../../views/Depo/usermanagement/distributor/Create.vue';
import DistributorEdit from '../../views/Depo/usermanagement/distributor/Edit.vue';// এডিট ফাইল ইম্পোর্ট

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
    // Distributor Management
    { 
        path: 'depo/distributors', 
        name: 'DistributorList',
        component: DistributorList,
        meta: { requiresAuth: true, roles: ['depo'] }
    },
    { 
        path: 'depo/distributors/create', 
        name: 'DistributorCreate',
        component: DistributorCreate,
        meta: { requiresAuth: true, roles: ['depo'] }
    },
    { 
        path: 'depo/distributors/edit/:id', 
        name: 'DistributorEdit',
        component: DistributorEdit,
        meta: { requiresAuth: true, roles: ['depo'] }
    },
];

export default depoRoutes;