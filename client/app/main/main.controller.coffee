'use strict'

angular.module 'fixedSizeAdapterApp'
.controller 'MainCtrl', ($scope, Parsimotion, Syncer) ->
  toModel = (dto) ->
    sku: dto.REF
    nombre: dto.NOMBRE
    stock: dto.STOCK

  $scope.parseXls = (xls) ->
    workbook = XLS.read xls, type: "binary"
    $scope.productos = _.map (XLS.utils.sheet_to_json workbook.Sheets.mercado), toModel
    $scope.readyToDownload = true

  $scope.sincronizar = ->
    Parsimotion.products.query().$promise.then (response) ->
      new Syncer(response.results).execute $scope.productos
      $scope.$apply()
