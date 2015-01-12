app = angular.module('app', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers'
])

app.config([ '$routeProvider',
  ($routeProvider) ->
    $routeProvider
       .when('/',
        templateUrl: 'index.html'
        controller: 'RecipeIndexController'
      ).when('/recipes/:id',
        templateUrl: 'show.html'
        controller: 'RecipeShowController'
      )
])

controllers = angular.module('controllers', [])
