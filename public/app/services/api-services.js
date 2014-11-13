'use strict';

var apiUrl = 'http://localhost:3000/';

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
	.factory('Test', ['$resource',
		function ($resource) {
			return $resource(apiUrl + 'test',
				{},
				{
					query: {method: 'GET', isArray: false }
				});
		}]);