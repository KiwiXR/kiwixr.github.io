<template>
  <section class="section">
    <div class="container is-max-desktop">
      <div class="columns is-centered has-text-centered">
        <div :class="['column', columnWidth]">
          <div :class="['content', columnTextLoc]">
            <p v-bind="parsedAttrsPlain"><slot></slot></p>
          </div>
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

// Computed properties to get parsed attributes
const parsedAttrs = computed(() => parseAttributes(props.attr_p));
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
  padding-top: 12px;
  padding-bottom: 12px;
}
p {
  //margin-bottom: 12px;
}
.column {
  //padding-bottom: 0;
}
</style>