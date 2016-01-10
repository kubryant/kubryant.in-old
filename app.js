var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');

var routes = require('./server/routes');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'server', 'views'));
app.set('view engine', 'jade');

//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(express.static(path.join(__dirname, 'client')));

app.use('/', routes);

module.exports = app;
