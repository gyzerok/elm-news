var path = require('path');
var webpack = require('webpack');

module.exports = {
  devtool: '#inline-source-map',
  entry: {
    bundle: [
      path.join(__dirname, 'src', 'client')
    ]
  },
  output: {
    path: path.join(__dirname, '.public'),
    filename: '[name].js',
    publicPath: '/public/'
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin()
  ],
  resolve: {
    extensions: ['', '.js', '.json'],
    modulesDirectories: ['node_modules']
  },
  module: {
    loaders: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loaders: ['elm-hot', 'elm-webpack']
      },
    ],
    noParse: /\.elm$/
  },
  debug: true
};
