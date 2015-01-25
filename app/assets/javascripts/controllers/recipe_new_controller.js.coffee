controllers = angular.module('controllers')

controllers.controller('RecipeNewController', ['$scope', '$resource', '$location',
  ($scope, $resource, $location) ->
    Recipe = $resource('/api/v1/recipes', { format: 'json' },
      { create: { method: 'POST' } }
    )

    $scope.recipe = {}

    $scope.create = ->
      Recipe.create($scope.recipe, (new_recipe) -> $location.path("/recipes/#{new_recipe.id}"))
])
