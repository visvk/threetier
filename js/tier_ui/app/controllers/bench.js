'use strict';

angular.module('myApp.bench', ['ngRoute'])

.controller('BenchCtrl', [ '$scope', '$q', 'ClusterTest', 'NoclusterTest', 'SimpleTest', 'Messages',
    function($scope, $q, ClusterTest, NoclusterTest, SimpleTest, Messages) {

    $scope.message = "Ready to start";
    $scope.results = [];
    $scope.t1 = 0;
    $scope.t2 = 0;

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
      $scope.message = "Starting Request to API"
      var t1 = new Date();
      var counter = 0;

      for(var i = 0; i < 6; i++) {
        SimpleTest.query(function(data) {
          var t2 = new Date();
          var diff = t2 - t1;
          $scope.results.push(diff);
          $scope.message = "Attempt: " + ++counter + " status: " + data.message + " in " + diff + "ms.";
        })
      }
    };

    $scope.webSocketSimple = function () {
      $scope.message = "Starting Request to SocketAPI"
      $scope.t1 = new Date();

      Messages.sendTest();
    };

    // Wait for web socket response
    Messages.onTest(function(data) {
      $scope.t2 = new Date();
      var diff = $scope.t2 - $scope.t1;

      $scope.results.push(diff);
      $scope.message = data.body + " in " + new Date(data.timestamp).toISOString() + "ms.";
      $scope.$apply()
    });
}]);