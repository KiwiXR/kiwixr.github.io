import { loadStyles } from '@/utils/loadStyles'
import { loadScript } from "@/utils/loadScript";

async function loadAssets() {
    try {
        // Load your CDN styles and script
        await Promise.all([
            // Styles
            loadStyles('https://fonts.googleapis.com/css?family=Google+Sans|Noto+Sans|Castoro'), // google fonts
            loadStyles('https://cdn.jsdelivr.net/npm/bulma@0.9.1/css/bulma.min.css'), // bulma
            loadStyles('https://cdn.jsdelivr.net/npm/bulma-carousel@4.0.24/dist/css/bulma-carousel.min.css'), // bulma-carousel
            loadStyles('https://cdn.jsdelivr.net/npm/bulma-slider@2.0.5/dist/css/bulma-slider.min.css'), // bulma-slider
            loadStyles('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css'), // font-awesome
            loadStyles('https://cdn.jsdelivr.net/gh/jpswalsh/academicons@1/css/academicons.min.css'), // academicons
            // loadStyles('https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/github.min.css'), // github style
            //, favicon.svg
            // Script
            // loadScript('https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'), // jquery should load globally
            loadScript('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js'), // font-awesome
            loadScript('https://cdn.jsdelivr.net/npm/bulma-carousel@4.0.24/dist/js/bulma-carousel.min.js'), // bulma-carousel
            loadScript('https://cdn.jsdelivr.net/npm/bulma-slider@2.0.5/dist/js/bulma-slider.min.js'), // bulma-slider
            // loadScript('https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/highlight.min.js'), // highlight
        ]);

        // 初始化 highlight.js
        // window.hljs?.highlightAll();

        // Now load your index.css
        await import('@assets/nerfies/css/index.css');
        // await import('@assets/nerfies/js/index.js');
        console.log('index.css loaded after CDN styles');
    } catch (error) {
        console.error(error);
    }
}


// Function to apply body styles
const applyBodyStyles = () => {
    document.body.style.fontFamily = "'Noto Sans', sans-serif"; // Example style
};

loadAssets();

applyBodyStyles();

// Initialize Bulma Carousel after all scripts are loaded
const carousels = bulmaCarousel.attach('.carousel', {
    slidesToScroll: 1,
    slidesToShow: 3,
    loop: true,
    infinite: true,
    autoplay: false,
    autoplaySpeed: 3000,
});
// window.$ = window.jQuery = require('jquery');

