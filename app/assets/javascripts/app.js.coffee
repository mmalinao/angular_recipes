app = angular.module('app', [
  'templates',
  'ngRoute',
  'controllers'
])

app.config([ '$routeProvider',
  ($routeProvider) ->
    $routeProvider
      .when('/',
        templateUrl: 'index.html'
        controller: 'RecipesController'
      )
])

controllers = angular.module('controllers', [])
controllers.controller('RecipesController', ['$scope',
  ($scope) ->
])
