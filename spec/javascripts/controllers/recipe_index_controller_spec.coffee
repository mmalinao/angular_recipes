lazy = jasmineLet(jasmine, window)

describe 'RecipeIndexController', ->
  $scope       = null
  $routeParams = null
  $location    = null
  $resource    = null

  $controller  = null
  $httpBackend = null

  beforeEach ->
    module 'app'
    inject((_$rootScope_, _$routeParams_, _$location_, _$resource_, _$controller_, _$httpBackend_) ->
      $scope = _$rootScope_.$new()
      $routeParams = _$routeParams_
      $location = _$location_
      $resource = _$resource_
      $controller = _$controller_
      $httpBackend = _$httpBackend_
    )

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe 'init', ->

    beforeEach ->
      $routeParams.keywords = keywords

      $controller 'RecipeIndexController',
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

  describe 'search()', ->

    beforeEach ->
      $controller 'RecipeIndexController',
        $scope: $scope
        $location: $location

      $scope.search('foo')

    it 'should redirect to itself with a keyword param', ->
      expect($location.path()).toBe('/')
      expect($location.search()).toEqualData({ keywords: 'foo' })
