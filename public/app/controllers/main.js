'use strict';

angular.module('myApp.main', ['ngRoute'])

.controller('MainCtrl', [ '$scope', 'Test', function($scope, Test) {
  $scope.name = "Viktor Sincak";
  $scope.message = "Ready to start";

  $scope.start = function () {
    var t1 = new Date();
    Test.query(function(data) {
      var t2 = new Date();
      $scope.message = data.message + " in " + (t2 - t1) + "ms.";
    })
  }
}]);