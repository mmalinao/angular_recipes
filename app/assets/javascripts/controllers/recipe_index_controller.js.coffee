controllers = angular.module('controllers')

controllers.controller('RecipeIndexController', ['$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource) ->
    Recipes = $resource('/api/v1/recipes', { format: 'json' })

    if $routeParams.keywords
      Recipes.query(keywords: $routeParams.keywords, (results) -> $scope.recipes = results)
    else
      $scope.recipes = []

    $scope.search = (keywords) -> $location.path('/').search('keywords', keywords)

    $scope.view = (id) -> $location.path("/recipes/#{id}")
])
