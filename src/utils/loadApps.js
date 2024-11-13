export function loadApps() {
    // Use require.context to load all app directories
    const context = require.context('@/components', true, /main\.js$/); // Match all main.js files in app directories
    const appNames = [];

    // console.log(context.keys())

    // Iterate over the keys to gather app names
    context.keys().forEach(path => {
        // console.log("Found app path:", path)
        const appName = path.split('/')[1]; // Extract the app name from the path
        appNames.push(appName);
    });

    // Log all app names that were found
    // console.log("Found app names:", appNames);

    return appNames; // Return the array of app names
}
