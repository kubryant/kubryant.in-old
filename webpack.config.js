var webpack = require('webpack');
var path = require('path');

var dir = path.resolve(__dirname);

var config = {
  entry: {
    vendor: [
      './bower_components/angular/angular',
      './bower_components/angular-ui-router/release/angular-ui-router'
    ],
    home: './client/js/home'
  },
  output: {
    path: path.join(dir, 'build/client'),
    filename: '/js/[name].js'
  },
  resolve: {
    extensions: ['', '.js', '.scss']
  },
  module: {
    preLoaders: [
      {
        test: /\.js?$/, loader: 'eslint-loader', exclude: /node_modules|bower_components/
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
        exclude: /node_modules|bower_components/,
        loader: 'babel'
      },
      {
        test: /\.jade$/,
        loader: 'ng-cache?prefix=[dir]!apply!jade'
      }
    ]
  },
	eslint: {
		configFile: './.eslintrc'
	},
  plugins: [
    new webpack.optimize.CommonsChunkPlugin('vendor', '/js/vendors.js')
  ]
};

module.exports = config;
