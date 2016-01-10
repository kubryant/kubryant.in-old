/*
 * default error handler if route is not found
 */

(function() {
  'use strict';

  function render(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;

    // don't display error and stack on production
    if(process.env.NODE_ENV === 'production') {
      err.status = '';
      err.stack = '';
    }

    res.render('error', {
      message: err.message,
      error: err
    });
  }

  module.exports = render;
}());
