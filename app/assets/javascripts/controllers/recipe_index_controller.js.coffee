controllers = angular.module('controllers')

controllers.controller('RecipeIndexController', ['$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource) ->
    Recipes = $resource('/api/v1/recipes', { format: 'json' } )

    params = if $routeParams.keywords then { keywords: $routeParams.keywords } else {}
    Recipes.query(params, (results) -> $scope.recipes = results)

    $scope.search = (keywords) -> $location.path('/').search('keywords', keywords)

    $scope.view = (id) -> $location.path("/recipes/#{id}")

    $scope.new_recipe = () -> $location.path('/recipes/new')
])
