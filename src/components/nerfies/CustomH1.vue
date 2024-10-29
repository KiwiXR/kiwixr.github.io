<template>
  <section class="section">
    <div class="container is-max-desktop">
      <!-- Abstract. -->
      <div class="columns is-centered has-text-centered">
        <div class="column is-four-fifths">
          <h1 v-bind="parsedH1Attrs" class="title is-3 e-h1-warn">Refuse to render {<em><slot></slot></em>}: # or &lt;h1&gt; not supported</h1>
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
const parsedH1Attrs = computed(() => parseAttributes(props.attr_h1));
</script>

<style scoped>
.e-h1-warn {
  //background: violet;
  color: mediumvioletred;
}
</style>