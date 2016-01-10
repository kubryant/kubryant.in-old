/*
 * the main route handler
 */

(function() {
  'use strict';

  var express = require('express');
  var router = express.Router();

  var home = require('../controllers/home');
  var error = require('../controllers/error');

  // main content
  router.get('/', home);

  // error on all other routes
  router.get('*', error);

  module.exports = router;
}());
