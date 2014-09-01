'use strict'

angular.module 'fixedSizeAdapterApp'
.controller 'MainCtrl', ($scope, $window) ->
  $scope.awesomeThings = []

  $scope.parseXls = (xls) ->
    workbook = XLS.read xls, type: "binary"
    $scope.output = XLS.utils.sheet_to_json workbook.Sheets.mercado

    blob = new Blob [$scope.output], type : 'text/plain'
    $scope.url = ($window.URL || $window.webkitURL).createObjectURL blob

    $scope.readyToDownload = true
