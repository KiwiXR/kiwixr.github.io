<template>
  <section class="section">
    <div class="container is-max-desktop">
      <!-- Abstract. -->
      <div class="columns is-centered has-text-centered">
        <div :class="['column', columnWidthP]">
          <div :class="['content', columnTextP]">
            <p v-bind="parsedPAttrsPlain"><slot></slot></p>
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
  width: {
    type: String,
    default: "1"
  },
  loc: {
    type: String,
    default: "j"
  }
});

const width_map = {
  '1': 'is-full-width', '1.0': 'is-full-width', '': 'is-full-width',
  '4/5': 'is-four-fifths', '0.8': 'is-four-fifths', '.8': 'is-four-fifths'
}

const loc_map = {
  'j': 'has-text-justified', 'justify': 'has-text-justified', 'justified': 'has-text-justified',
  'c': 'has-text-centered', 'center': 'has-text-centered', 'centered': 'has-text-centered', 'middle': 'has-text-centered', 'm': 'has-text-centered',
  'l': 'has-text-left', 'left': 'has-text-left',
  'r': 'has-text-right', 'right': 'has-text-right',
}

// Computed properties to get parsed attributes
const parsedPAttrs = computed(() => parseAttributes(props.attr_p));
const parsedPAttrsPlain = { ...parsedPAttrs.value };
let columnTextP = props.loc
if ('loc' in parsedPAttrsPlain) {
  columnTextP = parsedPAttrsPlain['loc']
  delete parsedPAttrsPlain['loc']
}
columnTextP = loc_map[columnTextP]
// console.log('loc:', columnTextH2)

let columnWidthP = props.width
if ('width' in parsedPAttrsPlain) {
  columnWidthP = parsedPAttrsPlain['width']
  delete parsedPAttrsPlain['width']
}
columnWidthP = width_map[columnWidthP]
</script>

<style scoped>
.section {
  padding-top: 12px;
  padding-bottom: 0;
}
p {
  margin-bottom: 1em;
}
.column {
  padding-bottom: 0;
}
</style>