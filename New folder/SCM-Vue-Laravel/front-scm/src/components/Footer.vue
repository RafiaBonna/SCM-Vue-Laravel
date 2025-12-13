<template>
  <footer class="main-footer custom-footer text-center py-3">
    <strong>
      Copyright &copy; {{ new Date().getFullYear() }}
    </strong>
    <br />
    All rights reserved by Rafia Hawlader.
  </footer>
</template>

<script>
export default {
  name: "Footer",
};
</script>

<style scoped>
/* ==============================
   FOOTER – LAVENDER THEME (Navbar Match)
   ============================== */

.custom-footer {
  background-color: #e6e1ff; /* Same lavender as navbar */
  color: #3f2b96; /* Indigo text */
  border-top: 1px solid #d6cfff; /* Matching navbar border */
}

/* Hover effect (optional, if footer has links) */
.custom-footer a {
  color: #3f2b96;
  text-decoration: none;
}

.custom-footer a:hover {
  color: #2c1a7a;
}
</style>
