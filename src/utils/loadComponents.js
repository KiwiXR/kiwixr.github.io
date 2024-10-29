// src/utils/loadComponents.js
export function loadComponents(appName) {
    const components = {};

    // Ensure the path is absolute to the components folder
    const context = require.context('@/components', true, /\.vue$/); // Recursively find .vue files

    console.log(`Loading components for app: ${appName}`);

    // Iterate over the keys to find specific app components
    context.keys().forEach(key => {
        if (key.includes(`/${appName}/`)) { // Only load components for the specified app
            // console.log("Found component path:", key)
            const componentName = key.split('/').pop().replace('.vue', ''); // Get component name
            components[componentName] = context(key).default; // Load and store the component

            console.log(`Loaded component: ${componentName}`);
        }
    });

    return components; // Return the object containing all components for the app
}
