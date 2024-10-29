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
// Try 3: successful
// import { createApp } from 'vue';
// import { loadComponents } from './loadComponents';
// import { loadApps } from './loadApps';
//
// loadApps().forEach(appName => {
//     const app = createApp({}); // Create a new Vue application instance
//
//     // Load components dynamically
//     const components = loadComponents(appName);
//     console.log('Loaded components for', appName, components);
//
//     Object.entries(components).forEach(([name, component]) => {
//         app.component(name, component); // Register the component
//     });
//
//     // Mount the app to the corresponding HTML element
//     app.mount(`#${appName}`);
// });
// Try 4
import { loadApps } from '@/utils/loadApps';
import { loadComponents } from '@/utils/loadComponents';
import { createApp } from 'vue';
import { loadScript } from "@/utils/loadScript";

Promise.all([
    loadScript('https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'),
])
    .then(() => {
        // window.$ = window.jQuery = require('jquery');

        // Load all valid app names
        const appNames = loadApps();

        appNames.forEach(async appName => {
            // Load components for the current app
            const components = loadComponents(appName);

            // Attempt to import the local main.js for the current app
            try {
                await import(`@/components/${appName}/main.js`);
            } catch (err) {
                console.warn(`No local main.js found for app: ${appName}, skipping...`);
            }

            // Create a new Vue app instance
            const app = createApp({});

            app.config.compilerOptions.whitespace = 'preserve'

            // Register all components
            Object.entries(components).forEach(([name, module]) => {
                app.component(name, module);
            });

            // Mount the app to the corresponding div based on the app name
            app.mount(`#${appName}`);
        });
    })
