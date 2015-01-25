app = angular.module('app', [
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

app.config([ '$routeProvider',
  ($routeProvider) ->
    $routeProvider
       .when('/',
        templateUrl: 'index.html'
        controller: 'RecipeIndexController'
      ).when('/recipes/new',
        templateUrl: 'new.html'
        controller: 'RecipeNewController'
      ).when('/recipes/:id',
        templateUrl: 'show.html'
        controller: 'RecipeShowController'
      )
])

controllers = angular.module('controllers', [])
