// Try 1
// import { defineCustomElement } from 'vue'
// import HelloWorld from './components/HelloWorld.ce.vue'
//
// console.log(HelloWorld.styles) // ["/* 内联 css */"]
//
// // // 转换为自定义元素构造器
// // const HelloWorldElement = defineCustomElement(HelloWorld)
//
// // 注册
// customElements.define('hello-world', defineCustomElement(HelloWorld))
//
// Try 2
// import { createApp } from 'vue';
// import MyElement from "./apps/app1/MyElement.vue";
// import MyElement2 from "./apps/app2/MyElement.vue";
//
// const app1 = createApp({});
// app1.component('my-element', MyElement);
// app1.mount('#app1');
//
// const app2 = createApp({});
// app2.component('my-element', MyElement2);
// app2.mount('#app2')

import { createApp } from 'vue';
import { loadComponents } from './loadComponents';
import { loadApps } from './loadApps';

loadApps().forEach(appName => {
    const app = createApp({}); // Create a new Vue application instance

    // Load components dynamically
    const components = loadComponents(appName);
    console.log('Loaded components for', appName, components);

    Object.entries(components).forEach(([name, component]) => {
        app.component(name, component); // Register the component
    });

    // Mount the app to the corresponding HTML element
    app.mount(`#${appName}`);
});
