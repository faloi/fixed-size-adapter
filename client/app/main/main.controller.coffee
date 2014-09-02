'use strict'

class Ajuste
  constructor: (dto) ->
    @sku = dto.REF
    @nombre = dto.NOMBRE
    @stock = _.max [0, parseInt dto.STOCK]

  estaEnParsimotion: -> @id?

angular.module 'fixedSizeAdapterApp'
.controller 'MainCtrl', ($scope, Parsimotion, Syncer) ->
  getFirstSheet = (workbook) ->
    workbook.Sheets[workbook.SheetNames[0]]

  getDataFrom = (workbook) ->
    XLS.utils.sheet_to_json (getFirstSheet workbook)

  $scope.parseXls = (xls) ->
    workbook = XLS.read xls, type: "binary"
    $scope.productos = _.map (getDataFrom workbook), (dto) -> new Ajuste dto
    $scope.readyToDownload = true

  $scope.sincronizar = ->
    Parsimotion.products.query().$promise.then (response) ->
      new Syncer(response.results).execute $scope.productos
