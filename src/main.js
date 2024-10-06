import { defineCustomElement } from 'vue'
import HelloWorld from './components/HelloWorld.ce.vue'

console.log(HelloWorld.styles) // ["/* 内联 css */"]

// // 转换为自定义元素构造器
// const HelloWorldElement = defineCustomElement(HelloWorld)

// 注册
customElements.define('hello-world', defineCustomElement(HelloWorld))