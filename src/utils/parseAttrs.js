// Function to parse the attributes string into an object
export const parseAttributes = (attrString) => {
    const attrs = {};
    const regex = /(\w+)=["']?([^"']*)["']?/g;
    let match;

    while ((match = regex.exec(attrString)) !== null) {
        attrs[match[1]] = match[2];
    }

    return attrs;
};