<template>
  <section class="section">
    <div class="container is-max-desktop">
      <!-- Abstract. -->
      <div :class="['columns', 'is-centered', columnTextH3]">
        <div :class="['column', columnWidthH3]">
          <h3 v-bind="parsedH3AttrsPlain" class="title is-4"><slot></slot></h3>
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
  attr_h3: {
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

const loc_map = {
  'c': 'has-text-centered', 'center': 'has-text-centered', 'centered': 'has-text-centered', 'middle': 'has-text-centered', 'm': 'has-text-centered',
  'l': 'has-text-left', 'left': 'has-text-left',
  'r': 'has-text-right', 'right': 'has-text-right',
}

const width_map = {
  '1': 'is-full-width', '1.0': 'is-full-width', '': 'is-full-width',
  '4/5': 'is-four-fifths', '0.8': 'is-four-fifths', '.8': 'is-four-fifths'
}

// Computed properties to get parsed attributes
const parsedH3Attrs = computed(() => parseAttributes(props.attr_h3));

const parsedH3AttrsPlain = { ...parsedH3Attrs.value };
let columnTextH3 = props.loc
if ('loc' in parsedH3AttrsPlain) {
  columnTextH3 = parsedH3AttrsPlain['loc']
  delete parsedH3AttrsPlain['loc']
}
columnTextH3 = loc_map[columnTextH3]
// console.log('loc:', columnTextH3)

let columnWidthH3 = props.width
if ('width' in parsedH3AttrsPlain) {
  columnWidthH3 = parsedH3AttrsPlain['width']
  delete parsedH3AttrsPlain['width']
}
columnWidthH3 = width_map[columnWidthH3]
// console.log(parsedH3AttrsPlain)
</script>

<style scoped>
.section {
  padding-top: 12px;
  padding-bottom: 0;
}
h3 {
  margin-bottom: 1rem;
}
.column {
  padding-bottom: 0;
}
</style>