<template>
  <section class="section">
    <div class="container is-max-desktop">
      <div :class="['columns', 'is-centered', columnTextLoc]">
        <div :class="['column', columnWidth]">
          <table v-bind="parsedAttrsPlain" class="table is-narrow">
            <slot></slot>
          </table>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import { computed } from 'vue';
import { parseAttributes } from "@/utils/parseAttrs";
import { loc_map, width_map } from "@/utils/mappings";

// Define props for the attributes
const props = defineProps({
  attr_table: {
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
const parsedAttrs = computed(() => parseAttributes(props.attr_table));

const parsedAttrsPlain = { ...parsedAttrs.value };
let columnTextLoc = props.loc
if ('loc' in parsedAttrsPlain) {
  columnTextLoc = parsedAttrsPlain['loc']
  delete parsedAttrsPlain['loc']
}
columnTextLoc = loc_map[columnTextLoc]
// console.log('loc:', columnTextLoc)

let columnWidth = props.width
if ('width' in parsedAttrsPlain) {
  columnWidth = parsedAttrsPlain['width']
  delete parsedAttrsPlain['width']
}
columnWidth = width_map[columnWidth]
</script>

<style scoped>
.section {
  padding-top: 0;
  padding-bottom: 1.5rem;
}
table {
  margin-left: auto;
  margin-right: auto;
}
</style>