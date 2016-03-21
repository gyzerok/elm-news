/* eslint-disable */

var webpack = require('webpack');
var WebpackDevServer = require('webpack-dev-server');
var config = require('./webpack.config');

var appPort = 1337;
var proxy = 'http://localhost:' + appPort;

config.entry.bundle.unshift('webpack-dev-server/client?http://localhost:3000/', 'webpack/hot/dev-server');
var devServer = new WebpackDevServer(webpack(config), {
  contentBase: config.output.path,
  publicPath: config.output.publicPath,
  hot: true,
  historyApiFallback: true,
  noInfo: true,
  proxy: [
    {
      path: /^(?!\/public).*$/,
      secure: false,
      target: proxy
    }
  ]
});

devServer.listen(3000, 'localhost', function () {
  console.log('Listening at http://%s:%s', 'localhost', 3000);
});

require('babel-register');
var app = require('./src/server').default;
app.listen(appPort, function () {
  console.log('Listening at http://%s:%s', 'localhost', 1337);
});
