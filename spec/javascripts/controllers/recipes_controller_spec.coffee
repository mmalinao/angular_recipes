lazy = jasmineLet(jasmine, window)

describe 'RecipesController', ->
  $scope       = null
  $controller  = null
  $location    = null
  $routeParams = null
  $resource    = null
  $httpBackend = null

  beforeEach ->
    module('app')
    inject((_$rootScope_, _$controller_, _$location_, _$routeParams_, _$resource_, _$httpBackend_) ->
      $scope = _$rootScope_.$new()
      $controller = _$controller_
      $location = _$location_
      $routeParams = _$routeParams_
      $resource = _$resource_
      $httpBackend = _$httpBackend_
    )

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe '$scope', ->

    beforeEach ->
      $routeParams.keywords = keywords

      $controller 'RecipesController',
        $scope: $scope
        $routeParams: $routeParams

    describe 'when no keywords present', ->
      lazy 'keywords', null

      it 'should default to no recipes', ->
        expect($scope.recipes).toEqualData([])

    describe 'with keywords', ->
      lazy 'keywords', 'foo'
      lazy 'results', [
        {
          id: 2
          name: 'Baked Potatoes'
        }
      ]

      beforeEach ->
        request = new RegExp("\/recipes.*keywords=#{keywords}")
        $httpBackend.expectGET(request).respond(results)
        $httpBackend.flush()

      it 'should query for recipes', ->
        expect($scope.recipes).toEqualData(results)

  describe '$scope.search()', ->

    beforeEach ->
      $controller 'RecipesController',
        $scope: $scope
        $location: $location

      $scope.search('foo')

    it 'should redirect to itself with a keyword param', ->
      expect($location.path()).toBe('/')
      expect($location.search()).toEqualData({keywords: 'foo'})
