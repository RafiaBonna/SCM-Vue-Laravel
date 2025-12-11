// src/router/modules/admin.js

import AdminDashboard from '../../views/Admin/DashboardView.vue';
import UserList from '../../views/Admin/UserManagement/UserList.vue';
import UserCreate from '../../views/Admin/UserManagement/UserCreate.vue';
import UserEdit from '../../views/Admin/UserManagement/UserEdit.vue';

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
];

export default adminRoutes;