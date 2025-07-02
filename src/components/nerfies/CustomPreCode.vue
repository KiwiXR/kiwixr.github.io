<template>
  <section class="section">
    <div class="container is-max-desktop content">
      <pre v-bind="parsedPreAttrs" class="custom-pre" ref="preElement"><code v-bind="parsedCodeAttrs" class="custom-code"><slot></slot></code></pre>
      <button class="copy-button" @click="copyCode" :title="copyButtonText">
        {{ copyButtonText }}
      </button>
    </div>
  </section>
</template>

<script setup>
import { computed, ref } from 'vue';
import { parseAttributes } from "@/utils/parseAttrs";

// Define props for the attributes
const props = defineProps({
  attr_pre: {
    type: String,
    default: ""
  },
  attr_code: {
    type: String,
    default: ""
  },
  // language: {
  //   type: String,
  //   default: "" // 手动指定语言（如 "ruby"）
  // }
});

const preElement = ref(null);
const copyButtonText = ref("Copy");

// Computed properties to get parsed attributes
const parsedPreAttrs = computed(() => parseAttributes(props.attr_pre));
const parsedCodeAttrs = computed(() => parseAttributes(props.attr_code)); // Use the same attributes for code if needed

// const languageClass = computed(() => {
//   if (props.language) return `language-${props.language}`;
//   // 从父元素类名中自动检测
//   let parent = preElement.value?.parentElement;
//   for (let i = 0; i < 5 && parent; i++) {
//     const match = parent.className.match(/language-(\w+)/);
//     if (match) return `language-${match[1]}`;
//     parent = parent.parentElement;
//   }
//   return "";
// });

const copyCode = async () => {
  try {
    // 克隆整个代码块
    const clone = preElement.value.cloneNode(true);
    const codeElement = clone.querySelector('.custom-code');

    // 处理缩进字符
    const indentChars = codeElement.querySelectorAll('.indent-char');
    indentChars.forEach(el => {
      // 保留缩进，使用实际空格替换
      const space = document.createTextNode(' ');
      el.parentNode.insertBefore(space, el);
      el.remove();
    });

    // 处理换行
    const lineBreaks = codeElement.querySelectorAll('.line-break');
    lineBreaks.forEach(el => {
      // 保留换行，使用实际换行符替换
      const newline = document.createTextNode('\n');
      el.parentNode.insertBefore(newline, el);
      el.remove();
    });

    // 获取处理后的文本内容
    const textContent = codeElement.textContent;

    await navigator.clipboard.writeText(textContent);
    copyButtonText.value = "Copied!";
    setTimeout(() => {
      copyButtonText.value = "Copy";
    }, 2000);
  } catch (err) {
    console.error('Failed to copy text: ', err);
    copyButtonText.value = "Error";
    setTimeout(() => {
      copyButtonText.value = "Copy";
    }, 2000);
  }
};
</script>

<style scoped>
.copy-button {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
  padding: 0.25rem 0.5rem;
  background-color: #f5f5f5;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 0.8rem;
  cursor: pointer;
  transition: all 0.2s ease;
  opacity: 0.7;
}
.copy-button:hover {
  background-color: #e0e0e0;
  opacity: 1;
}
.custom-pre {
  display: block;
  white-space: pre !important;
  font-family: monospace;
  line-height: 1.5;
}
.custom-pre > * {
  display: inline !important;
}
.indent-container {
  display: inline-block;
  letter-spacing: 0.5em;
}
.indent-char {
  display: inline !important;
  width: 0.5em;
}
.indent-char::after {
  content: "";
  display: inline;
  width: 0.5em;
  letter-spacing: normal !important;
}
.line-break {
  display: block;
  height: 0;
}
.line-break::before {
  content: "\A"; /* CSS换行符 */
  white-space: pre;
}
.section {
  padding-bottom: 24px;
  padding-top: 24px;
}
</style>