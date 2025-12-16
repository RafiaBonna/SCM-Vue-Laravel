// ================================
// Admin Dashboard
// ================================
import AdminDashboard from '../../views/Admin/DashboardView.vue';

// ================================
// User Management Imports
// ================================
import UserList from '../../views/Admin/UserManagement/UserList.vue';
import UserCreate from '../../views/Admin/UserManagement/UserCreate.vue';
import UserEdit from '../../views/Admin/UserManagement/UserEdit.vue';

// ================================
// Depo Management Imports
// ================================
import DepoList from '../../views/Admin/DepoManagement/DepoList.vue';
import DepoCreate from '../../views/Admin/DepoManagement/DepoCreate.vue';
import DepoEdit from '../../views/Admin/DepoManagement/DepoEdit.vue';

// ================================
// Supplier Management Imports
// ================================
import SupplierList from '../../views/Admin/SupplierManagement/SupplierList.vue';
import SupplierCreate from '../../views/Admin/SupplierManagement/SupplierCreate.vue';
import SupplierEdit from '../../views/Admin/SupplierManagement/SupplierEdit.vue';

// ================================
// Unit Management Imports
// ================================
import UnitList from '../../views/Admin/UnitManagement/UnitList.vue';
import UnitCreate from '../../views/Admin/UnitManagement/UnitCreate.vue';
import UnitEdit from '../../views/Admin/UnitManagement/UnitEdit.vue';

// ================================
// Raw Material Management Imports
// ================================
import RawMaterialList from '../../views/Admin/RawMaterialManagement/RawMaterialList.vue';
import RawMaterialCreate from '../../views/Admin/RawMaterialManagement/RawMaterialCreate.vue';
import RawMaterialEdit from '../../views/Admin/RawMaterialManagement/RawMaterialEdit.vue';


// ==================================================
// Admin Routes
// ==================================================
const adminRoutes = [

    // -------------------------------
    // Dashboard
    // -------------------------------
    {
        path: 'admin',
        name: 'admin-dashboard',
        component: AdminDashboard,
        meta: { requiresAuth: true, roles: ['admin'] }
    },

    // -------------------------------
    // User Management
    // -------------------------------
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

    // -------------------------------
    // Depo Management
    // -------------------------------
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

    // -------------------------------
    // Supplier Management
    // -------------------------------
    {
        path: 'admin/suppliers',
        name: 'supplier-list',
        component: SupplierList,
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

    // -------------------------------
    // Unit Management
    // -------------------------------
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

    // -------------------------------
    // Raw Material Management
    // -------------------------------
    {
        path: 'admin/raw-materials',
        name: 'raw-material-list',
        component: RawMaterialList,
        meta: { requiresAuth: true, roles: ['admin'] }
    },
    {
        path: 'admin/raw-materials/create',
        name: 'raw-material-create',
        component: RawMaterialCreate,
        meta: { requiresAuth: true, roles: ['admin'] }
    },
    {
        path: 'admin/raw-materials/edit/:id',
        name: 'raw-material-edit',
        component: RawMaterialEdit,
        meta: { requiresAuth: true, roles: ['admin'] }
    },
];

export default adminRoutes;
