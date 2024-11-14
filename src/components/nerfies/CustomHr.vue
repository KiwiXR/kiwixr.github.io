<template>
  <section class="section">
    <div class="container is-max-desktop">
      <div :class="['columns', 'is-centered', columnTextLoc]">
        <div :class="['column', columnWidth]">
          <hr v-bind="parsedAttrsPlain" class="title is-3">
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
  attr_hr: {
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
const parsedAttrs = computed(() => parseAttributes(props.attr_hr));

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
// console.log(parsedAttrsPlain)
</script>

<style scoped>
.section {
  padding-top: 0;
  padding-bottom: 0;
}
hr {
  overflow: visible; /* For IE */
  padding: 0;
  border: none;
  border-top: medium double #333;
  color: #333;
  text-align: center;
}
hr:after {
  content: "\266B";
  display: inline-block;
  position: relative;
  top: -1.5rem;
  font-size: 1.5rem;
  padding: 0 0.25rem;
  background: white;
}
.column {
  //padding-bottom: 0;
}
</style>