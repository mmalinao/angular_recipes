controllers = angular.module('controllers')

controllers.controller('RecipeShowController', ['$scope', '$routeParams', '$resource',
  ($scope, $routeParams, $resource) ->
    Recipe = $resource('/api/v1/recipes/:id', { id: '@id', format: 'json' })

    Recipe.get({ id: $routeParams.id },
      ( (recipe) -> $scope.recipe = recipe ),
      ( (httpResponse) -> $scope.recipe = null )
    )
])
