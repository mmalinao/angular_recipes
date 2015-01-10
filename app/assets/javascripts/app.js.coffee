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
        controller: 'RecipesController'
      )
])

controllers = angular.module('controllers', [])
controllers.controller('RecipesController', ['$scope', '$routeParams', '$location', '$resource'
  ($scope, $routeParams, $location, $resource) ->
    $scope.search = (keywords) -> $location.path('/').search('keywords', keywords).search('keywords', keywords)

    Recipe = $resource('/api/v1/recipes/:id', { id: "@id", format: 'json' })

    if $routeParams.keywords
      Recipe.query(keywords: $routeParams.keywords, (results) -> $scope.recipes = results)
    else
      $scope.recipes = []
])
