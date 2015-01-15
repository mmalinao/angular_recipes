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

  beforeEach ->
    module 'app'
    inject((_$rootScope_, _$routeParams_, _$resource_, _$location_, _$controller_, _$httpBackend_, _flash_) ->
      $scope = _$rootScope_.$new()
      $routeParams = _$routeParams_
      $resource = _$resource_
      $location = _$location_
      $controller = _$controller_
      $httpBackend = _$httpBackend_
      flash = _flash_
    )

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe 'init', ->
    lazy 'recipe', Factory.build('recipe')
    lazy 'request', -> new RegExp("\/recipes/#{id}")

    beforeEach ->
      $routeParams.id = id

      $controller 'RecipeShowController',
        $scope: $scope
        $routeParams: $routeParams
        $location: $location

    describe 'when recipe exists', ->
      lazy 'id', -> recipe.id

      beforeEach ->
        $httpBackend.expectGET(request).respond(200, recipe)
        $httpBackend.flush()

      it 'should return recipe', ->
        expect($scope.recipe).toEqualData(recipe)

      describe 'back()', ->

        beforeEach ->
          $scope.back()

        it 'should set location path to root path', ->
          expect($location.path()).toBe('/')

    describe 'when recipe not found', ->
      lazy 'id', -1

      beforeEach ->
        $httpBackend.expectGET(request).respond(404, null)
        $httpBackend.flush()

      it 'should return null', ->
        expect($scope.recipe).toBe(null)

      it 'should set flash error', ->
        expect(flash.error).toBe("There is no recipe with id #{id}")
