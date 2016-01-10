var webpack = require('webpack');
var path = require('path');

var dir = path.resolve(__dirname);

var config = {
  entry: './client/js/index',
  output: {
    path: path.join(dir, 'build'),
    filename: '/js/main.js'
  },
  resolve: {
    extensions: ['.js', '.scss']
  },
  module: {
    preLoaders: [
      {
        test: /\.js?$/, loader: 'eslint-loader', exclude: /node_modules/
      }
    ],
    loaders: [
      {
        test: /\.(svg|ttf|eot|woff)\?$/,
        loader: 'url?limit=10000&name=/fonts/[name].[ext]'
      },
      {
        test: /\.(png|gif)\?$/,
        loader: 'url?limit=10000&name=/images/[name].[ext]'
      },
      {
        test: /\.scss$/,
        loader: 'style!css?sourceMap!autoprefixer?browsers=last 2 versions!sass?sourceMap'
      },
      {
        test: /\.js?$/,
        exclude: /node_modules/,
        loader: 'babel'
      },
      {
        test: /\.jade$/,
        loader: 'ng-cache?prefix=[dir]!apply!jade'
      }
    ]
  }
};

module.exports = config;
