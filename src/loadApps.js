// src/loadApps.js
export function loadApps() {
    const context = require.context('./components', true, /.*\.vue$/); // Match any component file
    const appNames = new Set(); // Use a Set to avoid duplicates

    // Gather app names by iterating through component keys
    context.keys().forEach(key => {
        const appName = key.split('/')[1]; // Extract the app name from the path
        appNames.add(appName); // Add it to the set
    });

    // Log all app names that were found
    console.log("Found app names:", Array.from(appNames));

    return Array.from(appNames); // Convert Set to Array
}
