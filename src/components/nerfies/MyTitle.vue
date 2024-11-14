<template>
  <section class="hero">
    <div class="hero-body">
      <div class="container is-max-desktop">
        <div class="columns is-centered">
          <div class="column has-text-centered">
            <h1 class="title is-1 publication-title"><slot></slot></h1>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { defineProps, computed } from 'vue';
import { parseAttributes } from "@/utils/parseAttrs";

// Define props for the attributes
const props = defineProps({
  attr_h1: {
    type: String,
    default: ""
  }
});

// Computed properties to get parsed attributes
const parsedAttrs = computed(() => parseAttributes(props.attr_h1));
</script>

<style scoped>
.hero-body {
  padding-bottom: 1.5rem;
}
h1 {
  //margin-bottom: 1.5rem;
}
.column {
  //padding-bottom: 0;
}
</style>