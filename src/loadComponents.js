// src/loadComponents.js
export function loadComponents(appName) {
    const components = {};

    // Use require.context to load all .vue files in the specified app directory
    const context = require.context('./components', true, /\.vue$/); // true for subdirectories

    // Log the current app name being loaded
    console.log(`Loading components for app: ${appName}`);

    // Iterate over the keys and dynamically load components for the specified app
    context.keys().forEach((key) => {
        if (key.includes(`/${appName}/`)) { // Check if the file belongs to the specified app
            const componentName = key.split('/').pop().replace('.vue', ''); // Get component name
            components[componentName] = context(key).default; // Load and store the component

            // Log the component name being loaded
            console.log(`Loaded component: ${componentName}`);
        }
    });

    return components; // Return the object containing all components for the app
}
