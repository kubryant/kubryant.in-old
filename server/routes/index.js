/*
 * the main route handler
 */

(function() {
  'use strict';

  var express = require('express');
  var router = express.Router();

  var index = require('../controllers');
  var error = require('../controllers/error');

  // main content
  router.get('/', index);

  // error on all other routes
  router.get('*', error);

  module.exports = router;
}());
