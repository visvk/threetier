'use strict';

// Declare app level module which depends on views, and components
angular.module('myApp', [
  'ngRoute',
  'ngResource',
  //'angular-carousel',
  'myApp.main',
  'myApp.bench',
  'myApp.apiServices',
  'myApp.version'
]).
config(['$routeProvider', function($routeProvider) {
  $routeProvider.when('/main', {
    templateUrl: 'partials/main.html',
    controller: 'MainCtrl'
  });
  $routeProvider.when('/bench', {
    templateUrl: 'partials/bench.html',
    controller: 'BenchCtrl'
  });

  $routeProvider.otherwise({redirectTo: '/main'});
}]);
