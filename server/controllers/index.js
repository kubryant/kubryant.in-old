/*
 * controller to handle the main content
 */

(function() {
  'use strict';

  function render(req, res, next) {
    res.render('index',
        {
          title: 'Under construction',
          description: 'Stay tuned.'
        });
  }

  module.exports = render;
}());
