<template>
  <section class="section">
    <div class="container is-max-desktop content">
      <pre v-bind="parsedPreAttrs"><code v-bind="parsedCodeAttrs" class="custom-code"><slot></slot></code></pre>
    </div>
    </section>
</template>

<script setup>
import { defineProps, computed } from 'vue';
import { parseAttributes } from "@/utils/parseAttrs";

// Define props for the attributes
const props = defineProps({
  attr_pre: {
    type: String,
    default: ""
  },
  attr_code: {
    type: String,
    default: ""
  }
});

// Computed properties to get parsed attributes
const parsedPreAttrs = computed(() => parseAttributes(props.attr_pre));
const parsedCodeAttrs = computed(() => parseAttributes(props.attr_code)); // Use the same attributes for code if needed
</script>

<style scoped>
.custom-code {
  font-family: monospace; /* Ensure it inherits font-family from body */
}
.section {
  padding-bottom: 24px;
  padding-top: 24px;
}
</style>