var dotenv = require("dotenv")
var fs = require("fs");
var path = require("path");
var webpack = require("webpack");


/**
 * Custom webpack plugins
 */
var ExtractTextPlugin = require("extract-text-webpack-plugin");


/**
 * General configuration
 */
dotenv.load("../");
var TARGETS = path.join(__dirname, "targets");
var BUILD   = path.join(__dirname, "build");


/**
 * isDirectory
 *
 * @param  {dir} file Check if the passed path is a directory
 * @return {Boolean}
 */
function isDirectory(dir) {
  return fs.lstatSync(dir).isDirectory();
}


/**
 * isFile
 *
 * @param  {string} file Check if the passed path is a file
 * @return {Boolean}
 */
function isFile(file) {
  return fs.lstatSync(file).isFile();
}


/**
 * createEntries
 *
 * Iterate through the `TARGETS`, find any matching `target.js` files, and
 * return those as entry points for the webpack output.
 */
function createEntries(entries, dir) {
  if (isDirectory(path.join(TARGETS, dir))) {
    var file = path.join(TARGETS, dir, "target.js");
    try {
      isFile(file);
    } catch (e) {
      return;
    }
    entries[dir] = [file];
  }
  return entries;
}


/**
 * Webpack configuration
 */
module.exports = {

  // Set proper context
  context: TARGETS,

  // Generate the `entry` points from the filesystem
  entry: fs.readdirSync(TARGETS).reduce(createEntries, {}),

  // Configure output
  output: {
    // Output into our build directory
    path: BUILD,
    // Template based on keys in entry above
    // Generate hashed names for production
    filename: "[name].js"
  },

  // Plugin definitions
  plugins: [
    new webpack.DefinePlugin({
      DEVELOPMENT: true
    }),
    new ExtractTextPlugin("[name].css", {
      allChunks: true
    })
  ],

  // Plugin specific-configuration
  cssnext: {
    map: false,
    compress: false
  },
  jshint: {
    eqnull: true,
    failOnHint: false
  },

  // General configuration
  module: {
    preLoaders: [
      // Run all JavaScript through jshint before loading
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: "jshint-loader"
      }
    ],
    loaders: [
      {
        test: /\.(jpe?g|png|gif|svg|woff|ttf|otf|eot|ico)/,
        loader: "file-loader?name=[path][name].[ext]"
      },
      {
        test: /\.html$/,
        loader: "html-loader"
      },
      {
        test: /\.css$/,
        // The ExtractTextPlugin pulls all CSS out into static files
        // rather than inside the JavaScript/webpack bundle
        loader: ExtractTextPlugin.extract("style-loader", "css-loader!autoprefixer-loader!cssnext-loader")
      }
    ]
  }

};
