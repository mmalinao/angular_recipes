controllers = angular.module('controllers')

controllers.controller('RecipeShowController', ['$scope', '$routeParams', '$resource', 'flash',
  ($scope, $routeParams, $resource, flash) ->
    Recipe = $resource('/api/v1/recipes/:id', { id: '@id', format: 'json' })

    Recipe.get({ id: $routeParams.id },
      ( (recipe) -> $scope.recipe = recipe ),
      ( (httpResponse) ->
        $scope.recipe = null
        flash.error = "There is no recipe with id #{$routeParams.id}"
      )
    )
])
