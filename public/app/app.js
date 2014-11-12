'use strict';

// Declare app level module which depends on views, and components
angular.module('myApp', [
  'ngRoute',
  'myApp.view1',
  'myApp.view2',
  'myApp.version'
]).
config(['$routeProvider', function($routeProvider) {

  // route for the home page
  $routeProvider.when('/', {
    templateUrl : 'view1/view1.html',
    controller  : 'View1Ctrl'
  });

  // route for the about page
  $routeProvider.when('/view2', {
    templateUrl : 'view2/view2.html',
    controller  : 'View2Ctrl'
  });
  $routeProvider.otherwise({redirectTo: '/view1'});
}]);
