'use strict';

angular.module('myApp.main', ['ngRoute'])

.controller('MainCtrl', [ '$window', '$scope',
    function($window, $scope) {

  // Set height of first main content
  angular.element(document).ready(function () {
    var height = $window.innerHeight;
    document.getElementById("main--content").setAttribute("style","height:"+(height-50)+"px");
    document.getElementById("main--body").setAttribute("style","padding-top:"+(height /18)+"px");
  });

  $scope.name = "Viktor Sincak";

  $scope.myInterval = 3000;
  $scope.slides = [
    {
      image: 'http://lorempixel.com/400/200/'
    },
    {
      image: 'http://lorempixel.com/400/200/food'
    },
    {
      image: 'http://lorempixel.com/400/200/sports'
    },
    {
      image: 'http://lorempixel.com/400/200/people'
    }
  ];

}]);