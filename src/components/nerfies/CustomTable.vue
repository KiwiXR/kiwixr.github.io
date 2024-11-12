<template>
  <section class="section">
    <div class="container is-max-desktop">
      <div :class="['columns', 'is-centered', columnTextTable]">
        <div :class="['column', columnWidthTable]">
          <table class="table is-narrow">
            <slot></slot>
          </table>
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
const parsedTableAttrs = computed(() => parseAttributes(props.attr_table));

const parsedTableAttrsPlain = { ...parsedTableAttrs.value };
let columnTextTable = props.loc
if ('loc' in parsedTableAttrsPlain) {
  columnTextTable = parsedTableAttrsPlain['loc']
  delete parsedTableAttrsPlain['loc']
}
columnTextTable = loc_map[columnTextTable]
// console.log('loc:', columnTextH3)

let columnWidthTable = props.width
if ('width' in parsedTableAttrsPlain) {
  columnWidthTable = parsedTableAttrsPlain['width']
  delete parsedTableAttrsPlain['width']
}
columnWidthTable = width_map[columnWidthTable]
</script>

<style scoped>
.section {
  padding-top: 0;
  padding-bottom: 1.5rem;
}
</style>