lazy = jasmineLet(jasmine, window)
eager = (name, declaration) ->
  lazy name, declaration, evaluateBefore: true

describe 'RecipeShowController', ->
  $scope       = null
  $routeParams = null
  $resource    = null
  $location    = null

  $controller  = null
  $httpBackend = null

  flash        = null

  inject_controller = ->
    inject((_$rootScope_, _$routeParams_, _$resource_, _$location_, _$controller_, _$httpBackend_, _flash_) ->
      $scope = _$rootScope_.$new()
      $routeParams = _$routeParams_
      $resource = _$resource_
      $location = _$location_
      $controller = _$controller_
      $httpBackend = _$httpBackend_
      flash = _flash_
    )

  beforeEach ->
    module 'app'
    inject_controller()

    $routeParams.id = id

    $controller 'RecipeShowController',
      $scope: $scope
      $routeParams: $routeParams
      $location: $location

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  lazy 'recipe', -> Factory.build('recipe')
  lazy 'get_request', -> new RegExp("\/recipes/#{id}")

  describe 'when recipe exists', ->
    lazy 'id', -> recipe.id

    beforeEach ->
      $httpBackend.expectGET(get_request).respond(200, recipe)
      $httpBackend.flush()

    it 'should return recipe', ->
      expect($scope.recipe).toEqualData(recipe)

    describe 'back()', ->

      beforeEach ->
        $scope.back()

      it 'should set location path to root path', ->
        expect($location.path()).toBe('/')

    # describe 'save()', ->

  describe 'when recipe not found', ->
    lazy 'id', -> -1

    beforeEach ->
      $httpBackend.expectGET(get_request).respond(404, null)
      $httpBackend.flush()

    it 'should return null', ->
      expect($scope.recipe).toBe(null)
