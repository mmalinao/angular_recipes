lazy = jasmineLet(jasmine, window)

describe 'RecipeNewController', ->
  $scope          = null
  $resource       = null
  $location       = null

  $controller     = null
  $httpBackend    = null

  flash           = null

  inject_controller = ->
    inject((_$rootScope_, _$resource_, _$location_, _$controller_, _$httpBackend_, _flash_) ->
      $scope = _$rootScope_.$new()
      $resource = _$resource_
      $location = _$location_
      $controller = _$controller_
      $httpBackend = _$httpBackend_
      flash = _flash_
    )

  beforeEach ->
    module 'app'
    inject_controller()

    $controller 'RecipeNewController',
      $scope: $scope
      $location: $location

  afterEach ->
    $httpBackend.verifyNoOutstandingExpectation()
    $httpBackend.verifyNoOutstandingRequest()

  describe 'init', ->
    it 'should define recipe', ->
      expect($scope.recipe).toBeDefined()

  describe 'create()', ->
    lazy 'post_request', -> new RegExp("\/recipes")
    lazy 'new_recipe', -> Factory.build('recipe')
    lazy 'params', -> { name: new_recipe.name, instructions: new_recipe.instructions }
    lazy 'do_create', ->
      $scope.create()
      $httpBackend.flush()

    beforeEach ->
      $scope.recipe = params
      $httpBackend.whenPOST(post_request, params).respond(201, new_recipe)

    it 'should post to the backend', ->
      $httpBackend.expectPOST(post_request, $scope.recipe).respond(201, new_recipe)
      do_create

    it 'should set location path to new recipe path', ->
      do_create
      expect($location.path()).toBe("/recipes/#{new_recipe.id}")
