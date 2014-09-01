'use strict'

angular.module 'fixedSizeAdapterApp'
.controller 'MainCtrl', ($scope, $window) ->
  $scope.awesomeThings = []

  $scope.parseXls = (xls) ->
    workbook = XLS.read xls, type: "binary"
    allRows = XLS.utils.sheet_to_json workbook.Sheets.mercado

    stringify = (rows) ->
      if (rows.length == 0)
        ""
      else
        rows
          .map((row) -> "#{row.REF} #{row.NOMBRE} #{row.STOCK}")
          .reduce (one, another) -> "#{one}\n#{another}"

    $scope.output = stringify allRows

    blob = new Blob [$scope.output], type : 'text/plain'
    $scope.url = ($window.URL || $window.webkitURL).createObjectURL blob

    $scope.readyToDownload = true
