<template>
  <section class="section">
    <div class="container is-max-desktop">
      <div :class="['columns', 'is-centered', columnTextLoc]">
        <div :class="['column', columnWidth]">
          <dl v-bind="parsedAttrsPlain">
            <slot></slot>
          </dl>
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
  attr_dl: {
    type: String,
    default: ""
  },
  text_loc: {
    type: String,
    default: "l"
  },
  width: {
    type: String,
    default: "1"
  }
});

// Computed properties to get parsed attributes
const parsedAttrs = computed(() => parseAttributes(props.attr_dl));

const parsedAttrsPlain = { ...parsedAttrs.value };
let columnTextLoc = props.text_loc
if ('loc' in parsedAttrsPlain) {
  columnTextLoc = parsedAttrsPlain['loc']
  delete parsedAttrsPlain['loc']
}
columnTextLoc = loc_map[columnTextLoc]

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
  padding-bottom: 0;
}
dl {
  margin-left: 0;
  padding-left: 20px;
  display: grid;
  grid-template-columns: max-content auto;
  gap: 16px;
}
:slotted(dt) {
  font-weight: bold;
  grid-column-start: 1;
}
:slotted(dd) {
  margin: 0;
  padding: 0 0 0.5em 0;
  grid-column-start: 2;
}
</style>