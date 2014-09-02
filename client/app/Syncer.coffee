# Ver http://engineering.talis.com/articles/elegant-api-auth-angular-js/
angular.module 'fixedSizeAdapterApp'
.factory "Parsimotion", ($resource) ->
  BASE_URL = "http://api.parsimotion.com"
  path = (resource) -> "#{BASE_URL}/#{resource}"

  stocks: $resource (path "products/:id/stocks"), id: "@id",
    update:
      method: 'PUT'

  products: $resource (path "products"), {},
    query:
      isArray: false

angular.module 'fixedSizeAdapterApp'
.factory "Syncer", (Parsimotion) ->

  class Syncer
    constructor: (@allProducts) ->

    execute: (ajustes) ->
      ajustes.forEach (it) =>
        product = @getId it

        if (product?)
          it.id = product.id
          it.stockActual = (@getStock product).quantity
          it.actualizado = false
          @updateStock(it, product).$promise.then => it.actualizado = true

    updateStock: (ajuste, product) ->
      Parsimotion.stocks.update { id: product.id }, [
        variation: (@getVariante product).id
        stocks: [
          warehouse: (@getStock product).warehouse,
          quantity: ajuste.stock
        ]
      ]

    getVariante: (product) -> product.variations[0]
    getStock: (product) -> (@getVariante product).stocks[0]

    getId: (ajuste) ->
      _.find @allProducts, sku: ajuste.sku
