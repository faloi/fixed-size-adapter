'use strict'

angular.module 'fixedSizeAdapterApp'
.controller 'MainCtrl', ($scope, $window) ->
  $scope.awesomeThings = []

  $scope.toFixedSize = (text, max) ->
    spacesToAdd = max - text.length

    if (spacesToAdd > 0)
      text += " " for i in [0...spacesToAdd]

    text

  $scope.parseXls = (xls) ->
    workbook = XLS.read xls, type: "binary"

    output = XLS.utils.sheet_to_json workbook.Sheets.Final
    .map((row) -> "#{$scope.toFixedSize row.Codigo, 15} #{$scope.toFixedSize row.A, 5} #{$scope.toFixedSize row.B, 5}")
    .reduce (one, another) -> "#{one}\n#{another}"

    $scope.output = output

    blob = new Blob [output], type : 'text/plain'
    $scope.url = ($window.URL || $window.webkitURL).createObjectURL blob

    $scope.readyToDownload = true
