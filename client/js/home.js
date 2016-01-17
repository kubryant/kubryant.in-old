import angular from 'angular';
import uiRouter from 'angular-ui-router';

// styles
import '../sass/home';

// create application
angular.module('kubryant', [uiRouter]);

// set default route
angular.module('kubryant').config(routes);

const dependencies = ['$urlRouterProvider'];
routes.$inject = dependencies;

function routes($urlRouterProvider) {
  $urlRouterProvider.otherwise('/');
}

// import pages
import './pages/home/home.route';
//require('./pages/home/home.route');
