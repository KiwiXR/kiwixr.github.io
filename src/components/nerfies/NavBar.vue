<template>
  <nav class="navbar" role="navigation" aria-label="main navigation">
    <div class="navbar-brand">
      <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false">
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
      </a>
    </div>
    <div class="navbar-menu">
      <div class="navbar-start" style="flex-grow: 1; justify-content: center;">
        <a class="navbar-item" :href="homeLink">
          <span class="icon">
            <i class="fas fa-home"></i>
          </span>
        </a>

        <div class="navbar-item has-dropdown is-hoverable">
          <a class="navbar-link">More Research</a>
          <div class="navbar-dropdown">
            <a
                class="navbar-item"
                v-for="(item, index) in dropdownItems"
                :key="index"
                :href="item.link"
            >
              {{ item.text }}
            </a>
          </div>
        </div>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { onMounted } from 'vue';

// Define props
const props = defineProps({
  homeLink: {
    type: String,
    required: true,
  },
  dropdownItems: {
    type: Array,
    required: true,
  },
});

// Methods
const toggleMenu = () => {
  $(".navbar-burger").toggleClass("is-active");
  $(".navbar-menu").toggleClass("is-active");
};

// jQuery for handling navbar burger toggle
onMounted(() => {
  $(".navbar-burger").click(toggleMenu);
});
</script>

<style scoped>
/* Add any additional styles here if needed */
</style>
