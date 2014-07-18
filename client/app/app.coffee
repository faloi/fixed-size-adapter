'use strict'

app = angular.module 'fixedSizeAdapterApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'ui.bootstrap'
]
.config ($routeProvider, $locationProvider, $compileProvider) ->
  $routeProvider
  .otherwise
    redirectTo: '/'

  $locationProvider.html5Mode true

  $compileProvider.aHrefSanitizationWhitelist /^\s*(https?|ftp|mailto|file|blob):/
