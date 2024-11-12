<template>
  <section class="section">
    <div class="container is-max-desktop">
      <!-- Abstract. -->
      <div :class="['columns', 'is-centered', columnTextH2]">
        <div :class="['column', columnWidthH2]">
          <h2 v-bind="parsedH2AttrsPlain" class="title is-3"><slot></slot></h2>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { defineProps, computed } from 'vue';
import { parseAttributes } from "@/utils/parseAttrs";
import { loc_map, width_map } from "@/utils/mappings";

// Define props for the attributes
const props = defineProps({
  attr_h2: {
    type: String,
    default: ""
  },
  loc: {
    type: String,
    default: "c"
  },
  width: {
    type: String,
    default: "1"
  }
});

// Computed properties to get parsed attributes
const parsedH2Attrs = computed(() => parseAttributes(props.attr_h2));

const parsedH2AttrsPlain = { ...parsedH2Attrs.value };
let columnTextH2 = props.loc
if ('loc' in parsedH2AttrsPlain) {
  columnTextH2 = parsedH2AttrsPlain['loc']
  delete parsedH2AttrsPlain['loc']
}
columnTextH2 = loc_map[columnTextH2]
// console.log('loc:', columnTextH2)

let columnWidthH2 = props.width
if ('width' in parsedH2AttrsPlain) {
  columnWidthH2 = parsedH2AttrsPlain['width']
  delete parsedH2AttrsPlain['width']
}
columnWidthH2 = width_map[columnWidthH2]
// console.log(parsedH2AttrsPlain)
</script>

<style scoped>
.section {
  padding-top: 3rem;
  padding-bottom: 0;
}
h2 {
  margin-bottom: 1.5rem;
}
.column {
  padding-bottom: 0;
}
</style>