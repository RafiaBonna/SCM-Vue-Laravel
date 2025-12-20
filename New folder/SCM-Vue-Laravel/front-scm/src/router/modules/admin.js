// ================================
// Dashboard & User Management
// ================================
import AdminDashboard from '../../views/Admin/DashboardView.vue';
import UserList from '../../views/Admin/UserManagement/UserList.vue';
import UserCreate from '../../views/Admin/UserManagement/UserCreate.vue';
import UserEdit from '../../views/Admin/UserManagement/UserEdit.vue';

// ================================
// Settings (Depo, Supplier, Unit)
// ================================
import DepoList from '../../views/Admin/DepoManagement/DepoList.vue';
import DepoCreate from '../../views/Admin/DepoManagement/DepoCreate.vue';
import DepoEdit from '../../views/Admin/DepoManagement/DepoEdit.vue';
import SupplierList from '../../views/Admin/SupplierManagement/SupplierList.vue';
import SupplierCreate from '../../views/Admin/SupplierManagement/SupplierCreate.vue';
import SupplierEdit from '../../views/Admin/SupplierManagement/SupplierEdit.vue';
import UnitList from '../../views/Admin/UnitManagement/UnitList.vue';
import UnitCreate from '../../views/Admin/UnitManagement/UnitCreate.vue';
import UnitEdit from '../../views/Admin/UnitManagement/UnitEdit.vue';

// ================================
// Raw Material Management
// ================================
import RawMaterialList from '../../views/Admin/RawMaterialManagement/RawMaterialList.vue';
import RawMaterialCreate from '../../views/Admin/RawMaterialManagement/RawMaterialCreate.vue';
import RawMaterialEdit from '../../views/Admin/RawMaterialManagement/RawMaterialEdit.vue';
import StockInList from '../../views/Admin/RawMaterialStock/StockInList.vue';
import StockInCreate from '../../views/Admin/RawMaterialStock/StockInCreate.vue';
import StockInView from '../../views/Admin/RawMaterialStock/StockInView.vue';
import MaterialIssueList from '../../views/Admin/MaterialIssue/MaterialIssueList.vue';
import MaterialIssueCreate from '../../views/Admin/MaterialIssue/MaterialIssueCreate.vue';
import MaterialIssueView from '../../views/Admin/MaterialIssue/MaterialIssueView.vue';

// ================================
// Finished Goods / Product Management
// ================================
import ProductList from '../../views/Admin/ProductManagement/ProductList.vue';
import ProductCreate from '../../views/Admin/ProductManagement/ProductCreate.vue';
import ProductReceiveList from '../../views/Admin/ProductManagement/ProductReceiveList.vue';
import ProductReceiveCreate from '../../views/Admin/ProductManagement/ProductReceiveCreate.vue';
import ProductReceiveView from '../../views/Admin/ProductManagement/ProductReceiveView.vue';
import ProductReceiveReturnList from '../../views/Admin/ProductManagement/ProductReceiveReturnList.vue';
import ProductWastageList from '../../views/Admin/ProductManagement/ProductWastageList.vue';

// ================================
// Admin Master Stock
// ================================
import AdminStockList from '../../views/Admin/stock/AdminStockList.vue';

const adminRoutes = [
    // Dashboard
    { path: '/admin', name: 'admin-dashboard', component: AdminDashboard, meta: { requiresAuth: true, roles: ['admin'] } },

    // User Management
    { path: '/admin/users', name: 'user-list', component: UserList, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/users/create', name: 'user-create', component: UserCreate, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/users/:id/edit', name: 'user-edit', component: UserEdit, meta: { requiresAuth: true, roles: ['admin'] }},

    // Depo, Supplier, Unit
    { path: '/admin/depos', name: 'depo-list', component: DepoList, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/suppliers', name: 'supplier-list', component: SupplierList, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/units', name: 'unit-list', component: UnitList, meta: { requiresAuth: true, roles: ['admin'] }},

    // Raw Material Management
    { path: '/admin/raw-material', name: 'raw-material-list', component: RawMaterialList, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/raw-material/create', name: 'raw-material-create', component: RawMaterialCreate, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/raw-material/:id/edit', name: 'raw-material-edit', component: RawMaterialEdit, meta: { requiresAuth: true, roles: ['admin'] }},

    // Raw Material Stock In
    { path: '/admin/stock-in', name: 'stock-in-list', component: StockInList, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/stock-in/create', name: 'stock-in-create', component: StockInCreate, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/stock-in/view/:id', name: 'stock-in-view', component: StockInView, meta: { requiresAuth: true, roles: ['admin'] }},

    // Material Issue
    { path: '/admin/material-issues', name: 'material-issue-list', component: MaterialIssueList, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/material-issues/create', name: 'material-issue-create', component: MaterialIssueCreate, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/material-issues/view/:id', name: 'material-issue-view', component: MaterialIssueView, meta: { requiresAuth: true, roles: ['admin'] }},

    // Finished Goods / Product Management
    { path: '/admin/products', name: 'product-list', component: ProductList, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/products/create', name: 'product-create', component: ProductCreate, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/product-receives', name: 'product-receive-list', component: ProductReceiveList, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/product-receives/create', name: 'product-receive-create', component: ProductReceiveCreate, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/product-receives/view/:id', name: 'product-receive-view', component: ProductReceiveView, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/product-returns', name: 'product-return-list', component: ProductReceiveReturnList, meta: { requiresAuth: true, roles: ['admin'] }},
    { path: '/admin/product-wastages', name: 'product-wastage-list', component: ProductWastageList, meta: { requiresAuth: true, roles: ['admin'] }},

    // Master Stock
    { path: '/admin/master-stock', name: 'admin-master-stock', component: AdminStockList, meta: { requiresAuth: true, roles: ['admin'] }},
];

export default adminRoutes;