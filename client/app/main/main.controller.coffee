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
    allRows = XLS.utils.sheet_to_json(workbook.Sheets.Final).map (row) -> row.A = row.A.slice 1; row

    stringify = (rows) ->
      if (rows.length == 0)
        ""
      else
        rows
          .map((row) -> "#{$scope.toFixedSize row.Codigo, 15} #{$scope.toFixedSize row.A, 5} #{$scope.toFixedSize row.B, 5}")
          .reduce (one, another) -> "#{one}\n#{another}"

    $scope.output = stringify (_.reject allRows, (row) -> row.Codigo.length > 15 || row.A.length > 5 || row.B.length > 5)
    $scope.excluded = stringify (allRows.filter (row) -> row.Codigo.length > 15 || row.A.length > 5 || row.B.length > 5)

    blob = new Blob [$scope.output], type : 'text/plain'
    $scope.url = ($window.URL || $window.webkitURL).createObjectURL blob

    $scope.readyToDownload = true
