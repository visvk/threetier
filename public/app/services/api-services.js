'use strict';

var clusterUrl = 'http://localhost:3000/';
var noClusterUrl = 'http://localhost:3001/';
var simpleUrl = 'http://localhost:3002/';
var simpleWS = 'wss://localhost:3002/data';

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

  // WEBSOCKETS
  .factory('Messages', function() {
    //var ws = $websocket(simpleWS);
    var collection = [];
    var ws = io.connect('http://localhost:3002');


    return {
      sendTest: function (cb) {
        ws.emit('test', {
          title: "TEST",
          body: "Websocket",
          timestamp: new Date().getTime()
        })
      },
      onTest: function (cb) {
        ws.on('test.response', function (data) {
          return cb(data)
        });
      }

    };



    //ws.onMessage(function(event) {
    //  console.log('message: ', event);
    //  var res;
    //  try {
    //    res = JSON.parse(event.data);
    //  } catch(e) {
    //    res = {'username': 'anonymous', 'message': event.data};
    //  }
    //
    //  collection.push({
    //    username: res.username,
    //    content: res.message,
    //    timeStamp: event.timeStamp
    //  });
    //});
    //
    //ws.onError(function(event) {
    //  console.log('connection Error', event);
    //});
    //
    //ws.onClose(function(event) {
    //  console.log('connection closed', event);
    //});
    //
    //ws.onOpen(function() {
    //  console.log('connection open');
    //  ws.send('Hello World');
    //  ws.send('again');
    //  ws.send('and again');
    //});
    // setTimeout(function() {
    //   ws.close();
    // }, 500)

    //return {
    //  collection: collection,
    //  status: function() {
    //    return ws.readyState;
    //  },
    //  send: function(message) {
    //    if (angular.isString(message)) {
    //      ws.send(message);
    //    }
    //    else if (angular.isObject(message)) {
    //      ws.send(JSON.stringify(message));
    //    }
    //  }
    //
    //};
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