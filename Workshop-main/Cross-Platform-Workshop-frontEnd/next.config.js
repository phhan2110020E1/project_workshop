/** @type {import('next').NextConfig} */
const nextConfig = {
    reactStrictMode: false,
    images: {
        domains: ['firebasestorage.googleapis.com','drive.google.com','example.com'],
   
    },
    swcMinify: true,
    fastRefresh: true,
    concurrentFeatures: true,
    productionBrowserSourceMaps: false, // Disable source maps in development
    optimizeFonts: false, // Disable font optimization
    minify: false,
};

module.exports = nextConfig
