<template>
  <section class="section">
    <div class="container is-max-desktop">
      <!-- Abstract. -->
      <div class="columns is-centered has-text-centered">
        <div :class="['column', column_width_p]">
          <div class="content has-text-justified">
            <p v-bind="parsedPAttrs"><slot></slot></p>
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
  attr_p: {
    type: String,
    default: ""
  },
  column_width_p: {
    type: String,
    // default: "is-four-fifths"
    default: "is-full-width"
  }
});

// Computed properties to get parsed attributes
const parsedPAttrs = computed(() => parseAttributes(props.attr_p));
</script>

<style scoped>
.section {
  padding-top: 0;
  padding-bottom: 0;
}
p {
  margin-bottom: 1em;
}
.column {
  padding-bottom: 0;
}
</style>