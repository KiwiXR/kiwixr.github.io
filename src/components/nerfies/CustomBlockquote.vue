<template>
  <section class="section">
    <div class="container is-max-desktop">
      <div class="columns is-centered has-text-centered">
        <div :class="['column', columnWidth]">
          <div :class="['content', columnTextLoc]">
            <blockquote v-bind="parsedAttrsPlain"><slot></slot></blockquote>
          </div>
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
  attr_blockquote: {
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
const parsedAttrs = computed(() => parseAttributes(props.attr_blockquote));
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
  padding-bottom: 0;
}
.content blockquote {
  margin: 20px 0;
  padding: 0 14px;
  border-inline-start: 5px solid rgb(148, 0, 211);
}
.column {
  padding: 0;
}
</style>