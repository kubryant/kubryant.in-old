var webpack = require('webpack');
var path = require('path');

var dir = path.resolve(__dirname);

var config = {
  devtool: 'source-map',
  entry: {
    vendor: [
      path.join(dir, 'bower_components/angular'),
      path.join(dir, 'bower_components/angular-ui-router/release/angular-ui-router')
    ],
    home: path.join(dir, 'js/home')
  },
  output: {
    path: path.join(dir, 'build'),
    filename: '/js/[name].js'
  },
  resolve: {
    extensions: ['', '.js', '.scss', '.jade'],
    alias: {
      "angular": path.join(dir, 'bower_components/angular'),
      "angular-ui-router": path.join(dir, 'bower_components/angular-ui-router/release/angular-ui-router')
    }
  },
  module: {
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
        exclude: /node_modules|bower_components/,
        loader: 'babel'
      },
      {
        test: /\.jade$/,
        loader: 'ng-cache!jade-html'
      }
    ]
  },
  plugins: [
    new webpack.optimize.CommonsChunkPlugin('vendor', '/js/vendors.js')
  ]
};

module.exports = config;
