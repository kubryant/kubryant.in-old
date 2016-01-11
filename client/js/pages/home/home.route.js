import angular from 'angular';

import controller from './home.controller'
import './home.template';

// set route
angular.module('kubryant').config(routes);

const dependencies = ['$stateProvider'];
routes.$inject = dependencies;

function routes($stateProvider) {
  $stateProvider
    .state('/', {
      url: '/',
      views: {
        'hello': {
          templateUrl: 'home.template.jade',
          controller: controller
        }
      }
    });
}
