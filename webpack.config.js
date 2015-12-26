var webpack = require('webpack');
var path = require('path');
var Clean = require('clean-webpack-plugin');
var ExtractTextPlugin = require('extract-text-webpack-plugin');

module.exports = {
  debug: true,

  entry: {
    all: './assets/stylesheets/all.css.scss',
  },

  output: {
    path: __dirname + '/.tmp/dist',
    filename: 'assets/stylesheets/[name].css',
  },

  module: {
    preLoaders: [{
      test: /\.scss$/,
      exclude: /node_modules|\.tmp|vendor/,
      loader: 'import-glob',
    }],

    loaders: [{
      test: /\.scss$/,
      exclude: /node_modules|\.tmp|vendor/,
      loader: ExtractTextPlugin.extract('css!sass'),
    }],
  },

  plugins: [
    new Clean(['.tmp']),
    new ExtractTextPlugin('assets/stylesheets/all.css', {
      allChunks: true,
    }),
  ],
};
