<template>
  <section class="section">
    <div class="container is-max-desktop content">
      <pre v-bind="parsedPreAttrs" class="custom-pre"><code v-bind="parsedCodeAttrs" class="custom-code"><slot></slot></code></pre>
    </div>
  </section>
</template>

<script setup>
import { computed } from 'vue';
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
.custom-pre {
  display: block;
  white-space: pre !important;
  font-family: monospace;
  line-height: 1.5;
}
.custom-pre > * {
  display: inline !important;
}
.indent-container {
  display: inline-block;
  letter-spacing: 0.5em;
}
.indent-char {
  display: inline !important;
  width: 0.5em;
}
.indent-char::after {
  content: " "; /* 可复制的真实空格 */
  display: inline;
  width: 0.5em;
  letter-spacing: normal !important;
}
.line-break {
  display: block;
  height: 0;
}
.line-break::before {
  content: "\A"; /* CSS换行符 */
  white-space: pre;
}
.section {
  padding-bottom: 24px;
  padding-top: 24px;
}
</style>