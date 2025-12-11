<template>
  <aside class="main-sidebar sidebar-light-indigo elevation-4">
    <router-link to="/" class="brand-link">
      <img src="/dist/img/AdminLTELogo.png" 
           alt="AdminLTE Logo" 
           class="brand-image img-circle elevation-3" 
           style="opacity: .8">
      <span class="brand-text font-weight-light">SCM PANEL</span>
    </router-link>

    <div class="sidebar">
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" 
            data-widget="treeview" 
            role="menu" 
            data-accordion="false">

          <!-- Dashboard Link -->
          <li class="nav-item" v-if="userRole">
            <router-link :to="dashboardLink" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>{{ dashboardTitle }}</p>
            </router-link>
          </li>

          <!-- Admin Menu -->
          <li class="nav-item" v-if="userRole === 'admin'">
            <router-link :to="{ name: 'user-list' }" class="nav-link">
              <i class="nav-icon fas fa-users"></i>
              <p>User Management</p>
            </router-link>
          </li>

          <!-- Depo Menu -->
          <li class="nav-item" v-if="userRole === 'depo'">
            <router-link to="/dashboard/depo/inventory" class="nav-link">
              <i class="nav-icon fas fa-warehouse"></i>
              <p>Inventory</p>
            </router-link>
          </li>

          <!-- Distributor Menu -->
          <li class="nav-item" v-if="userRole === 'distributor'">
            <router-link to="/dashboard/distributor/orders" class="nav-link">
              <i class="nav-icon fas fa-shopping-cart"></i>
              <p>Place Order</p>
            </router-link>
          </li>

          <!-- Logout -->
          <!-- <li class="nav-item mt-3">
            <a @click="handleLogout" class="nav-link" style="cursor:pointer;">
              <i class="nav-icon fas fa-sign-out-alt text-danger"></i>
              <p class="text-danger">Logout</p>
            </a>
          </li> -->

        </ul>
      </nav>
    </div>
  </aside>
</template>

<script>
import axios from "axios";
import router from "../router";

export default {
  name: "Sidebar",

  data() {
    return {
      userRole: localStorage.getItem("user_role"),
    };
  },

  watch: {
    $route() {
      this.userRole = localStorage.getItem("user_role");
    },
  },

  computed: {
    dashboardLink() {
      if (this.userRole === "admin") {
        return { name: "admin-dashboard" };
      }
      if (this.userRole === "depo") {
        return { name: "depo-dashboard" };
      }
      if (this.userRole === "distributor") {
        return { name: "distributor-dashboard" };
      }
      return { name: "login" };
    },

    dashboardTitle() {
      if (this.userRole === "admin") return "Admin Dashboard";
      if (this.userRole === "depo") return "Depo Dashboard";
      if (this.userRole === "distributor") return "Distributor Dashboard";
      return "Dashboard";
    },
  },

  methods: {
    async handleLogout() {
      if (!confirm("Are you sure you want to logout?")) return;

      try {
        await axios.post("logout");
      } catch (error) {
        console.warn("Logout API failed, proceeding anyway.");
      }

      localStorage.removeItem("auth_token");
      localStorage.removeItem("user_role");

      router.push({ name: "login" });
    },
  },
};
</script>
