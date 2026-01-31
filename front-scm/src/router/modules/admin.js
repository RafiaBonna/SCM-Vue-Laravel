// src/router/modules/admin.js (সম্পূর্ণ আপডেট করা ফাইল)

import AdminDashboard from '../../views/Admin/DashboardView.vue';
// User Management Imports
import UserList from '../../views/Admin/UserManagement/UserList.vue';
import UserCreate from '../../views/Admin/UserManagement/UserCreate.vue';
import UserEdit from '../../views/Admin/UserManagement/UserEdit.vue';

// 🏢 Depo Management Imports
import DepoList from '../../views/Admin/DepoManagement/DepoList.vue'
import DepoCreate from '../../views/Admin/DepoManagement/DepoCreate.vue'
import DepoEdit from '../../views/Admin/DepoManagement/DepoEdit.vue'

// 🤝 Supplier Management Imports (নতুন)
import SupplierList from '../../views/Admin/SupplierManagement/SupplierList.vue'
import SupplierCreate from '../../views/Admin/SupplierManagement/SupplierCreate.vue'
import SupplierEdit from '../../views/Admin/SupplierManagement/SupplierEdit.vue'

// ✅ NEW: Unit Management Imports
import UnitList from '../../views/Admin/UnitManagement/UnitList.vue';
import UnitCreate from '../../views/Admin/UnitManagement/UnitCreate.vue';
import UnitEdit from '../../views/Admin/UnitManagement/UnitEdit.vue';


const adminRoutes = [
    { 
        path: 'admin', 
        name: 'admin-dashboard',
        component: AdminDashboard, 
        meta: { requiresAuth: true, roles: ['admin'] } 
    },
    // User Management Routes
    { 
        path: 'admin/users', 
        name: 'user-list', 
        component: UserList, 
        meta: { requiresAuth: true, roles: ['admin'] } 
    },
    { 
        path: 'admin/users/create', 
        name: 'user-create', 
        component: UserCreate, 
        meta: { requiresAuth: true, roles: ['admin'] } 
    },
    { 
        path: 'admin/users/:id/edit', 
        name: 'user-edit', 
        component: UserEdit, 
        meta: { requiresAuth: true, roles: ['admin'] } 
    },
    
    // 🏢 Depo Management Routes
    {
        path: 'admin/depos',
        name: 'depo-list',
        component: DepoList,
        meta: { requiresAuth: true, roles: ['admin'] }
    },
    {
        path: 'admin/depos/create',
        name: 'depo-create',
        component: DepoCreate,
        meta: { requiresAuth: true, roles: ['admin'] }
    },
    {
        path: 'admin/depos/:id/edit',
        name: 'depo-edit',
        component: DepoEdit,
        meta: { requiresAuth: true, roles: ['admin'] }
    },
    
    // 🤝 Supplier Management Routes (এই রুটগুলি সমস্যা সমাধান করবে)
    {
        path: 'admin/suppliers',
        name: 'supplier-list',
        component: SupplierList, // এই কম্পোনেন্টটি এখন আমাদের তৈরি করতে হবে
        meta: { requiresAuth: true, roles: ['admin'] }
    },
    {
        path: 'admin/suppliers/create',
        name: 'supplier-create',
        component: SupplierCreate,
        meta: { requiresAuth: true, roles: ['admin'] }
    },
    {
        path: 'admin/suppliers/:id/edit',
        name: 'supplier-edit',
        component: SupplierEdit,
        meta: { requiresAuth: true, roles: ['admin'] }
    },
    // ✅ NEW: Unit Management Routes
    {
        path: 'admin/units',
        name: 'unit-list',
        component: UnitList, 
        meta: { requiresAuth: true, roles: ['admin'] }
    },
    {
        path: 'admin/units/create',
        name: 'unit-create',
        component: UnitCreate,
        meta: { requiresAuth: true, roles: ['admin'] }
    },
    {
        path: 'admin/units/:id/edit',
        name: 'unit-edit',
        component: UnitEdit,
        meta: { requiresAuth: true, roles: ['admin'] }
    },
];



export default adminRoutes;