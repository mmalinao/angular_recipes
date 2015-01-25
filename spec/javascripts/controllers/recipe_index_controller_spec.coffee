lazy = jasmineLet(jasmine, window)

describe 'RecipeIndexController', ->
  $scope       = null
  $routeParams = null
  $location    = null
  $resource    = null

  $controller  = null
  $httpBackend = null

  inject_controller = ->
    inject((_$rootScope_, _$routeParams_, _$location_, _$resource_, _$controller_, _$httpBackend_) ->
      $scope = _$rootScope_.$new()
      $routeParams = _$routeParams_
      $location = _$location_
      $resource = _$resource_
      $controller = _$controller_
      $httpBackend = _$httpBackend_
    )

  lazy 'keywords', -> null
  lazy 'get_request', -> new RegExp("\/recipes")
  lazy 'results', -> [ Factory.build('recipe') ]

  beforeEach ->
    module 'app'
    inject_controller()

    $routeParams.keywords = keywords

    $controller 'RecipeIndexController',
      $scope: $scope
      $routeParams: $routeParams
      $location: $location

    $httpBackend.whenGET(get_request).respond(200, results)

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe 'when no keywords present', ->

    beforeEach ->
      $httpBackend.expectGET(get_request).respond(200, results)
      $httpBackend.flush()

    it 'should default to all recipes', ->
      expect($scope.recipes).toEqualData(results)

  describe 'with keywords', ->
    lazy 'keywords', -> 'foo'
    lazy 'get_request', -> new RegExp("\/recipes.*keywords=#{keywords}")

    beforeEach ->
      $httpBackend.expectGET(get_request).respond(200, results)
      $httpBackend.flush()

    it 'should query for recipes', ->
      expect($scope.recipes).toEqualData(results)

  describe 'search()', ->

    beforeEach ->
      $httpBackend.flush()
      $scope.search('foo')

    it 'should redirect to itself with a keyword param', ->
      expect($location.path()).toBe('/')
      expect($location.search()).toEqualData({ keywords: 'foo' })

  describe 'view()', ->

    beforeEach ->
      $httpBackend.flush()
      $scope.view(1)

    it 'should set location path to recipe path', ->
      expect($location.path()).toBe('/recipes/1')

  describe 'new_recipe()', ->

    beforeEach ->
      $httpBackend.flush()
      $scope.new_recipe()

    it 'should set location path to new recipe path', ->
      expect($location.path()).toBe('/recipes/new')

