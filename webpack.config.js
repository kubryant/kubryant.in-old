// var webpack = require('webpack');
var path = require('path');

var dir = path.resolve(__dirname);

var config = {
  devtool: 'source-map',
  entry: {
    // vendor: [
    //   path.join(dir, 'bower_components/angular'),
    //   path.join(dir, 'bower_components/angular-ui-router/release/angular-ui-router')
    // ],
    home: path.join(dir, 'client/index.js')
  },
  output: {
    path: path.join(dir, 'build'),
    filename: '/js/[name].js'
  },
  resolve: {
    extensions: ['', '.js', '.jsx'],
    alias: {
      "react": path.join(dir, 'bower_components/react/react'),
      "react-dom": path.join(dir, 'bower_components/react/react-dom')
    }
  },
  module: {
    preLoaders: [
        {
            test: /\.jsx$/,
            include: path.join(dir, 'client'),
            loader: 'eslint-loader'
        }
    ],
    loaders: [
      // {
      //   test: /\.(svg|ttf|eot|woff)\?$/,
      //   loader: 'url?limit=10000&name=/fonts/[name].[ext]'
      // },
      // {
      //   test: /\.(png|gif)\?$/,
      //   loader: 'url?limit=10000&name=/images/[name].[ext]'
      // },
      {
        test: /\.css/,
        loader: 'style!css?sourceMap!postcss?browsers=last 2 versions!sass?sourceMap'
      },
      {
        test: /\.jsx?$/,
        include: path.join(dir, 'client'),
        loader: 'babel'
      }
    ]
  },
  plugins: [
    // new webpack.optimize.CommonsChunkPlugin('vendor', '/js/vendors.js')
  ]
};

console.log(config);

module.exports = config;
