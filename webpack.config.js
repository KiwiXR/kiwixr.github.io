const { CleanWebpackPlugin } = require('clean-webpack-plugin')
const path = require('path')
const webpack = require('webpack') // eslint-disable-line
const HtmlWebpackPlugin = require('html-webpack-plugin')
const CopyWebpackPlugin = require('copy-webpack-plugin');
const { VueLoaderPlugin } = require('vue-loader')

module.exports = {
    entry: './src/main.js',
    output: {
        path: path.resolve(__dirname, './dist'),
        publicPath: '/dist/',
        filename: '[name].[chunkhash].js'
    },
    optimization: {
        splitChunks: {
            chunks: 'all', // Split both dynamic and initial chunks
            cacheGroups: {
                vendor: {
                    test: /[\\/]node_modules[\\/]/, // Split libraries from node_modules
                    name: 'vendor',
                    chunks: 'all',
                },
                common: {
                    name: 'common',
                    minChunks: 2, // Split out common code that’s shared between files
                },
            },
        },
    },
    mode: 'development',
    module: {
        rules: [
            {
                test: /\.vue$/,
                loader: 'vue-loader',
                options: {
                    compilerOptions: {
                        whitespace: 'preserve', // Preserve whitespace in Vue templates
                    },
                },
            },
            {
                test: /\.css$/,
                use: [
                    'vue-style-loader',
                    'css-loader'
                ]
            },
            {
                test: /\.scss$/,
                use: [
                    'vue-style-loader',
                    'css-loader',
                    'sass-loader'
                ]
            },
            {
                test: /\.js$/,
                loader: 'babel-loader',
                exclude: file => (
                    /node_modules/.test(file) &&
                    !/\.vue\.js/.test(file)
                )
            },
            {
                test: /\.(woff|woff2|eot|ttf|otf|svg)$/,
                use: [
                    {
                        loader: 'file-loader',
                        options: {
                            name: '[name].[ext]',
                            outputPath: 'fonts/', // where to put the fonts in the output directory
                        },
                    },
                ],
            }
        ]
    },
    plugins: [
        new CopyWebpackPlugin({
            patterns: [
                {
                    from: path.resolve(__dirname, 'src/assets'), // Source directory
                    to: path.resolve(__dirname, 'dist/assets'),   // Destination in dist
                },
                // {
                //     from: '**/main.js', // Use just the glob pattern relative to context
                //     to: 'components/[path][name].js', // Retain folder structure in dist
                //     context: path.resolve(__dirname, 'src/components'), // Set context to the base directory
                // },
            ],
        }),
        new CleanWebpackPlugin(),
        new HtmlWebpackPlugin({
            filename: './../_includes/webpack-scripts.html',
            template: './src/scripts-template.html',
            inject: false
        }),
        new VueLoaderPlugin()
    ],
    resolve: {
        alias: {
            vue$: 'vue/dist/vue.esm-bundler.js',
            '@assets': path.resolve(__dirname, 'src/assets/'),
            '@': path.resolve(__dirname, 'src'),
        },
        extensions: ['*', '.js', '.vue', '.json']
    }
}

if (process.env.NODE_ENV === 'production') {
    module.exports.mode = 'production'
}