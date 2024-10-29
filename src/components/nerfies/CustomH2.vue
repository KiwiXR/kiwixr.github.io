<template>
  <section class="section">
    <div class="container is-max-desktop">
      <!-- Abstract. -->
      <div class="columns is-centered has-text-centered">
        <div class="column is-four-fifths">
          <h2 v-bind="parsedH2Attrs" class="title is-3"><slot></slot></h2>
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
  attr_h2: {
    type: String,
    default: ""
  }
});

// Computed properties to get parsed attributes
const parsedH2Attrs = computed(() => parseAttributes(props.attr_h2));
</script>

<style scoped>
.section {
  padding-bottom: 0;
}
h2 {
  margin-bottom: 1.5rem;
}
.column {
  padding-bottom: 0;
}
</style>