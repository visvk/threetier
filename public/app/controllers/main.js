'use strict';

angular.module('myApp.main', ['ngRoute'])

.controller('MainCtrl', [ '$scope', '$q', 'ClusterTest', 'NoclusterTest', 'SimpleTest',
    function($scope, $q, ClusterTest, NoclusterTest, SimpleTest) {
  $scope.name = "Viktor Sincak";
  $scope.message = "Ready to start";
  $scope.results = [];

  $scope.clusterTest = function () {
    var t1 = new Date();

    $q.all([ ClusterTest.query().$promise, ClusterTest.query().$promise, ClusterTest.query().$promise,
      ClusterTest.query().$promise, ClusterTest.query().$promise, ClusterTest.query().$promise
    ]).then(function(results){
      var t2 = new Date();
      var diff = t2 - t1;
      $scope.message = " Done " + diff + "ms.";
      $scope.results = results;
    })
  }
  $scope.noclusterTest = function () {
    var t1 = new Date();

    for(var i = 0; i < 6; i++) {
      ClusterTest.query(function(data) {
        var t2 = new Date();
        var diff = t2 - t1;
        $scope.results.push(diff);
        $scope.message = data.message + " in " + diff + "ms.";
      })
    }
  }
  $scope.simpleTest = function () {
    var t1 = new Date();

    for(var i = 0; i < 6; i++) {
      ClusterTest.query(function(data) {
        var t2 = new Date();
        var diff = t2 - t1;
        $scope.results.push(diff);
        $scope.message = data.message + " in " + diff + "ms.";
      })
    }
  }
}]);