'use strict';

var clusterUrl = 'http://localhost:3000/';
var noClusterUrl = 'http://localhost:3001/';
var simpleUrl = 'http://localhost:3002/';

angular.module('myApp.apiServices', ['ngResource'])
	.factory('intervalService', function ($interval) {
		var intervalPromises = [];
		return {
			setInterval: function (fn, delay, count) {
				intervalPromises.push($interval(fn, delay));
			},
			destroy: function () {
				for (var i = 0; i < intervalPromises.length; i++) {
					$interval.cancel(intervalPromises[i]);
				}
			}
		}
	})
	.factory('ClusterTest', ['$resource',
		function ($resource) {
			return $resource(clusterUrl + 'test',
				{},
				{
					query: {method: 'GET'}
				});
		}])
	.factory('NoclusterTest', ['$resource',
		function ($resource) {
			return $resource(noClusterUrl + 'test',
				{},
				{
					query: {method: 'GET'}
				});
		}])
	.factory('SimpleTest', ['$resource',
		function ($resource) {
			return $resource(simpleUrl + 'test',
				{},
				{
					query: {method: 'GET'}
				});
		}]);