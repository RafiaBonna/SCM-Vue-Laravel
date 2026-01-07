<template>
  <aside class="main-sidebar sidebar-light-indigo elevation-4">
    <router-link to="/" class="brand-link">
      <img
        src="/dist/img/vue.png"
        alt="Logo"
        class="brand-image img-circle elevation-3"
        style="opacity: .8"
      />
      <span class="brand-text font-weight-light">
        <b>SCM PANEL</b>
      </span>
    </router-link>

    <div class="sidebar">
      <nav class="mt-2">
        <ul
          class="nav nav-pills nav-sidebar flex-column"
          data-widget="treeview"
          role="menu"
          data-accordion="false"
        >

          <!-- Dashboard -->
          <li class="nav-item" v-if="userRole">
            <router-link :to="dashboardLink" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>{{ dashboardTitle }}</p>
            </router-link>
          </li>

          <!-- ================= ADMIN ================= -->
          <template v-if="userRole === 'admin'">

            <!-- User Management -->
            <li class="nav-item">
              <router-link :to="{ name: 'user-list' }" class="nav-link">
                <i class="nav-icon fas fa-users"></i>
                <p>User Management</p>
              </router-link>
            </li>

            <!-- ================= RAW MATERIALS ================= -->
            <li class="nav-item has-treeview">
              <a href="#" class="nav-link">
                <i class="nav-icon fas fa-boxes"></i>
                <p>
                  Raw Materials
                  <i class="right fas fa-angle-left"></i>
                </p>
              </a>

              <ul class="nav nav-treeview">
                <li class="nav-item">
                  <router-link :to="{ name: 'raw-material-list' }" class="nav-link">
                    <i class="fas fa-list-ul nav-icon"></i>
                    <p>Raw Material List</p>
                  </router-link>
                </li>

                <li class="nav-item">
                  <router-link :to="{ name: 'stock-in-list' }" class="nav-link">
                    <i class="fas fa-file-import nav-icon"></i>
                    <p>Stock In (Purchase)</p>
                  </router-link>
                </li>

                <li class="nav-item">
                  <router-link :to="{ name: 'material-issue-list' }" class="nav-link">
                    <i class="fas fa-file-export nav-icon"></i>
                    <p>Material Issue (Out)</p>
                  </router-link>
                </li>
              </ul>
            </li>

            <!-- ================= FINISHED GOODS ================= -->
            <li class="nav-item has-treeview">
              <a href="#" class="nav-link">
                <i class="nav-icon fas fa-boxes"></i>
                <p>
                  Finished Goods
                  <i class="right fas fa-angle-left"></i>
                </p>
              </a>

              <ul class="nav nav-treeview">
                <li class="nav-item">
                  <router-link :to="{ name: 'product-list' }" class="nav-link">
                    <i class="fas fa-list-ul nav-icon"></i>
                    <p>Product List</p>
                  </router-link>
                </li>

                <li class="nav-item">
                  <router-link :to="{ name: 'admin-master-stock' }" class="nav-link">
                    <i class="fas fa-dolly-flatbed nav-icon"></i>
                    <p>Stock</p>
                  </router-link>
                </li>

                <li class="nav-item">
                  <router-link :to="{ name: 'product-receive-list' }" class="nav-link">
                    <i class="fas fa-download nav-icon"></i>
                    <p>Product Receive (In)</p>
                  </router-link>
                </li>

                <li class="nav-item">
                  <router-link :to="{ name: 'product-return-list' }" class="nav-link">
                    <i class="fas fa-undo nav-icon"></i>
                    <p>Product Return (In)</p>
                  </router-link>
                </li>

                <li class="nav-item">
                  <router-link :to="{ name: 'product-wastage-list' }" class="nav-link">
                    <i class="fas fa-trash-alt nav-icon"></i>
                    <p>Product Wastage</p>
                  </router-link>
                </li>

                <li class="nav-item">
                  <router-link :to="{ name: 'product-sale-list' }" class="nav-link">
                    <i class="nav-icon fas fa-shipping-fast"></i>
                    <p>Product Sales</p>
                  </router-link>
                </li>
              </ul>
            </li>

            <!-- ================= SETTINGS ================= -->
            <li class="nav-item has-treeview">
              <a href="#" class="nav-link">
                <i class="nav-icon fas fa-cogs"></i>
                <p>
                  Settings
                  <i class="right fas fa-angle-left"></i>
                </p>
              </a>

              <ul class="nav nav-treeview">
                <li class="nav-item">
                  <router-link :to="{ name: 'depo-list' }" class="nav-link">
                    <i class="fas fa-warehouse nav-icon"></i>
                    <p>Depo List</p>
                  </router-link>
                </li>

                <li class="nav-item">
                  <router-link :to="{ name: 'supplier-list' }" class="nav-link">
                    <i class="fas fa-truck-moving nav-icon"></i>
                    <p>Supplier List</p>
                  </router-link>
                </li>
              </ul>
            </li>
          </template>

          <!-- ================= DEPO ================= -->
          <template v-if="userRole === 'depo'">
  <li class="nav-header">DEPO MANAGEMENT</li>

  <li class="nav-item has-treeview">
    <a href="#" class="nav-link">
      <i class="nav-icon fas fa-users"></i>
      <p>
        User Management
        <i class="right fas fa-angle-left"></i>
      </p>
    </a>
    <ul class="nav nav-treeview">
      <li class="nav-item">
        <router-link :to="{ name: 'DistributorList' }" class="nav-link">
          <i class="fas fa-user-friends nav-icon"></i>
          <p>Distributors</p>
        </router-link>
      </li>
      <li class="nav-item">
        <router-link :to="{ name: 'user-list' }" class="nav-link">
          <i class="fas fa-user-shield nav-icon"></i>
          <p>Customers</p>
        </router-link>
      </li>
    </ul>
  </li>

  <li class="nav-item has-treeview">
    <a href="#" class="nav-link">
      <i class="nav-icon fas fa-boxes"></i>
      <p>
        Finished Goods
        <i class="right fas fa-angle-left"></i>
      </p>
    </a>

    <ul class="nav nav-treeview">
      <li class="nav-item">
        <router-link :to="{ name: 'product-list' }" class="nav-link">
          <i class="fas fa-list-ul nav-icon"></i>
          <p>Product List</p>
        </router-link>
      </li>

      <li class="nav-item">
        <router-link :to="{ name: 'depo-stock-list' }" class="nav-link">
          <i class="fas fa-boxes nav-icon"></i>
          <p>Current Stock</p>
        </router-link>
      </li>

      <li class="nav-item">
        <router-link :to="{ name: 'depo-product-receive-list' }" class="nav-link">
          <i class="fas fa-download nav-icon"></i>
          <p>Product Receive (In)</p>
        </router-link>
      </li>

      <li class="nav-item">
        <router-link :to="{ name: 'product-return-list' }" class="nav-link">
          <i class="fas fa-undo nav-icon"></i>
          <p>Product Return</p>
        </router-link>
      </li>

      <li class="nav-item">
        <router-link :to="{ name: 'product-wastage-list' }" class="nav-link">
          <i class="fas fa-trash-alt nav-icon"></i>
          <p>Product Wastage</p>
        </router-link>
      </li>

      <li class="nav-item">
        <router-link :to="{ name: 'product-sale-list' }" class="nav-link">
          <i class="nav-icon fas fa-shipping-fast"></i>
          <p>Product Sales</p>
        </router-link>
      </li>
    </ul>
  </li>

  <li class="nav-item has-treeview">
    <a href="#" class="nav-link">
      <i class="nav-icon fas fa-cogs"></i>
      <p>
        Settings
        <i class="right fas fa-angle-left"></i>
      </p>
    </a>

    <ul class="nav nav-treeview">
      <li class="nav-item">
        <router-link :to="{ name: 'depo-list' }" class="nav-link">
          <i class="fas fa-warehouse nav-icon"></i>
          <p>Depo List</p>
        </router-link>
      </li>

      <li class="nav-item">
        <router-link :to="{ name: 'supplier-list' }" class="nav-link">
          <i class="fas fa-truck-moving nav-icon"></i>
          <p>Supplier List</p>
        </router-link>
      </li>
    </ul>
  </li>
</template>

          <!-- ================= DISTRIBUTOR ================= -->
          <template v-if="userRole === 'distributor'">
            <li class="nav-header">DISTRIBUTOR PANEL</li>

            <li class="nav-item">
              <a href="#" class="nav-link">
                <i class="nav-icon fas fa-shopping-basket"></i>
                <p>My Orders</p>
              </a>
            </li>
          </template>

          <!-- ================= LOGOUT ================= -->
          <li class="nav-item mt-4" v-if="userRole">
            <a
              href="#"
              @click.prevent="handleLogout"
              class="nav-link text-danger border-top"
            >
              <i class="nav-icon fas fa-sign-out-alt"></i>
              <p>Logout</p>
            </a>
          </li>

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
      if (this.userRole === "admin") return { name: "admin-dashboard" };
      if (this.userRole === "depo") return { name: "depo-dashboard" };
      if (this.userRole === "distributor") return { name: "distributor-dashboard" };
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

<style scoped>
.main-sidebar {
  background-color: #f2efff !important;
}

.main-sidebar .brand-link {
  background-color: #e6e1ff !important;
  color: #3f2b96 !important;
}

.nav-sidebar .nav-link {
  color: #3f2b96 !important;
}

.nav-sidebar .nav-link:hover {
  background-color: #ddd6ff !important;
}

.nav-sidebar .router-link-active {
  background-color: #6a5acd !important;
  color: #ffffff !important;
}
</style>
