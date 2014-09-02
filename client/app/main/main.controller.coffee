'use strict'

class Ajuste
  constructor: (dto) ->
    @sku = dto.REF
    @nombre = dto.NOMBRE
    @stock = _.max [0, parseInt dto.STOCK]

  estaEnParsimotion: -> @id?

angular.module 'fixedSizeAdapterApp'
.controller 'MainCtrl', ($scope, Parsimotion, Syncer) ->
  $scope.parseXls = (xls) ->
    workbook = XLS.read xls, type: "binary"
    $scope.productos = _.map (XLS.utils.sheet_to_json workbook.Sheets.mercado), (dto) -> new Ajuste dto
    $scope.readyToDownload = true

  $scope.sincronizar = ->
    Parsimotion.products.query().$promise.then (response) ->
      new Syncer(response.results).execute $scope.productos
