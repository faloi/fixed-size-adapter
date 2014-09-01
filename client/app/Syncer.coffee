# Ver http://engineering.talis.com/articles/elegant-api-auth-angular-js/
angular.module 'fixedSizeAdapterApp'
.factory "Parsimotion", ($resource) ->
  BASE_URL = "http://api.parsimotion.com"
  path = (resource) -> "#{BASE_URL}/#{resource}"

  stocks: $resource (path "products/:id/stocks"), id: "@id"
  products: $resource (path "products"), {},
    query:
      isArray: false

angular.module 'fixedSizeAdapterApp'
.factory "Syncer", ->

  class Syncer
    constructor: (@allProducts) ->

    execute: (ajustes) ->
      ajustes.forEach (it) =>
        product = @getId it

        if (product?)
          it.id = product.id
          it.stockActual = product.variations[0].stocks[0].quantity

    getId: (ajuste) ->
      _.find @allProducts, sku: ajuste.sku
