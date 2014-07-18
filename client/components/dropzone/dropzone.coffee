fileReader = ($q, $log) ->
  onLoad = (reader, deferred, scope) ->
    ->
      scope.$apply ->
        deferred.resolve reader.result
        return

      return

  onError = (reader, deferred, scope) ->
    ->
      scope.$apply ->
        deferred.reject reader.result
        return

      return

  onProgress = (reader, scope) ->
    (event) ->
      scope.$broadcast "fileProgress",
        total: event.total
        loaded: event.loaded

      return

  getReader = (deferred, scope) ->
    reader = new FileReader()
    reader.onload = onLoad(reader, deferred, scope)
    reader.onerror = onError(reader, deferred, scope)
    reader.onprogress = onProgress(reader, scope)
    reader

  readAsDataURL = (file, scope) ->
    deferred = $q.defer()
    reader = getReader(deferred, scope)
    reader.readAsBinaryString file
    deferred.promise

  readAsDataUrl: readAsDataURL

(angular.module 'fixedSizeAdapterApp').factory "fileReader", [
  "$q"
  "$log"
  fileReader
]

(angular.module 'fixedSizeAdapterApp').directive "ngFileSelect", (fileReader) ->
  link: (scope, element) ->
    element.bind "change", (e) ->
      file = (e.srcElement or e.target).files[0]
      fileReader.readAsDataUrl(file, scope).then scope.parseXls
