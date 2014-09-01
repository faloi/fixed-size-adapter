'use strict'

philipsAccessToken = 'gAAAAMi0mi-jKuy570_xOyMaK1m6o9xDKvqFZ-4zBx1a5KkBfy9UEPgZyh_KY-HaI2iN9uLU0HARqNhfSdNLD0k29n8x4Yvu09_e8rzFfiLzRUgrpy00K7uYducBNiAh88dXTTVJ06XpQU2LnIcsHxnLAuAsPcgt0pxUMl97KqWTxlVhFAEAAIAAAABGnQNC6LHoE1o3aDuLoOAyUeLBUe1Z4ox3oDMEHmkyWbCjclC9kPWeTKF4J7iyK9UEf59ZDgY3uK-DgFTjlphdVNxazqPbDO9IIEjIKnZLX1zPLn9Y6vrDh8OKTnGKoj2RzbUdNGEvuZ0RgTvoZdsF-VqY0mRWj_AizaIAlTbS5F2mP3twaaHgBS73c6KgN9DT-MdcebrGi9pNURtIu729B6Us8Q-VeQZAEEFcGPrIXdROB29kS1YfImn5W6YoTRg0OwhrVyEM9gNpRDdTLruuA45nIv_j7eGp0DLEs97twTULAAejNG-zodRBWnnJhbxlL3fjnObC04Xwpxux0AKqXyzSfHAiNwvK2E0vbssbZg'

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

.run ($rootScope, $injector) ->
    $rootScope.oauth =
      accessToken: philipsAccessToken

    $injector.get("$http").defaults.transformRequest = (data, headersGetter) ->
      headersGetter()["Authorization"] = "Bearer " + $rootScope.oauth.accessToken if $rootScope.oauth
      angular.toJson data if data
