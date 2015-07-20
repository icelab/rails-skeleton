var dotenv = require('dotenv');
var express = require("express");
var http = require("http");
var httpProxy = require('http-proxy');
var path = require('path');
var webpack = require("webpack");
var webpackConfig = require("./webpack-development.config.js");
var webpackDevMiddleware = require("webpack-dev-middleware");
var WebpackDevServer = require("webpack-dev-server");


/**
 * General configuration
 */
dotenv.load("../");
var BUILD            = path.join(__dirname, "build");
var DEVELOPMENT_PORT = process.env.ASSETS_DEVELOPMENT_PORT || 1234;
var WEBPACK_PORT     = process.env.ASSETS_WEBPACK_PORT || "8080";
var PROXY_URL        = process.env.ASSETS_PROXY_URL || "http://localhost:3000";


/**
 * Webpack dev middleware
 * Set up the webpack dev middleware with our development configuration file.
 */
var webpackMiddlewareOptions = {
  noInfo: true,
  publicPath: "/assets/"
};
var webpackMiddleware = webpackDevMiddleware(webpack(webpackConfig), webpackMiddlewareOptions);


/**
 * Rails proxy
 *
 * Creates a proxy server that will proxy any requests that result in an error
 * through to the rails assets stack. This allows us to use the asset-pipeline
 * in partnership with webpack if we need to.
 */
var proxy = httpProxy.createProxyServer();
var proxyTarget = PROXY_URL;
// Listen for the `error` event on `proxy`.
proxy.on('error', function (err, req, res) {
  res.writeHead(500, {
    'Content-Type': 'text/plain'
  });
  res.end('Oh noes, we tried to proxy through to '+proxyTarget+req.url+" and failed.");
});


/**
 * Express server
 *
 * Set up an express server to coordinate the proxy server  and webpack-
 * middleware instances.
 */
var app = express();

// Tell Express to use the webpackMiddleware
app.use(webpackMiddleware);

// Set CORS headers
app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

// Check each request and proxies misses through to Rails
app.get("*", function(req, res, next) {
  try {
    // Check if a file exists in the webpack bundle's virtual filesystem.
    // This throws an error if path doesn't exist.
    webpackMiddleware.fileSystem.readFileSync(__dirname + '/build'+req.url)
  } catch (e) {
    console.log("Proxying to "+proxyTarget+req.url);
    // Proxy through to Rails if doesn't exist.
    proxy.web(req, res, {
      target: proxyTarget
    });
    return;
  }
});

// Boot the express server
var port = DEVELOPMENT_PORT;
var server = http.Server(app);
server.listen(port, function() {
  console.log("Listening at http://localhost:" + DEVELOPMENT_PORT + "/");
});


/**
 * Development server
 *
 * Spin up a webpack dev server instance as well, so we can use it for
 * hot-loading changes.
 *
 * Should be on 8080 as the websocket expects that and it can't be configured
 * though we leave it configurable just in case :)
 */
var devServerOptions = {
  contentBase: BUILD,
  hot: true,
  quiet: false,
  noInfo: false,
  publicPath: "/assets/",
  historyApiFallback: true,
  stats: {
    colors: true
  }
};
var devServer = new WebpackDevServer(webpack(webpackConfig), devServerOptions);
devServer.listen(WEBPACK_PORT, "localhost", function() {});
