'use strict';

// Declare app level module which depends on views, and components
angular.module('myApp', [
  'ngRoute',
  'ngResource',
  'myApp.main',
  'myApp.view2',
  'myApp.apiServices',
  'myApp.version'
]).
config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/main', {
    templateUrl: 'partials/main.html',
    controller: 'MainCtrl'
  });
  $routeProvider.when('/view2', {
    templateUrl: 'partials/view2.html',
    controller: 'View2Ctrl'
  });

  $routeProvider.otherwise({redirectTo: '/main'});
}]);
