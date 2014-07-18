'use strict'

describe 'Controller: MainCtrl', ->

  # load the controller's module
  beforeEach module 'fixedSizeAdapterApp'

  MainCtrl = undefined
  scope = undefined
  $httpBackend = undefined

  # Initialize the controller and a mock scope
  beforeEach inject (_$httpBackend_, $controller, $rootScope) ->
    $httpBackend = _$httpBackend_
    $httpBackend.expectGET('/api/things').respond [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
      'Express'
    ]
    scope = $rootScope.$new()
    MainCtrl = $controller 'MainCtrl',
      $scope: scope

  it '1', ->
    expect(scope.toFixedSize "hola", 10).toBe "hola      "

  it '2', ->
    expect(scope.toFixedSize "hola", 4).toBe "hola"
