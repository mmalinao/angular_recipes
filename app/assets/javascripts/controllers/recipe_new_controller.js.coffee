controllers = angular.module('controllers')

controllers.controller('RecipeNewController', ['$scope', '$resource', '$location', 'flash',
  ($scope, $resource, $location, flash) ->
    Recipe = $resource('/api/v1/recipes', { format: 'json' },
      { create: { method: 'POST' } }
    )

    $scope.recipe = {}

    $scope.create = ->
      Recipe.create($scope.recipe,
        (new_recipe) -> $location.path("/recipes/#{new_recipe.id}"),
        (httpResponse) -> flash.error = 'Invalid parameters'
      )
])
