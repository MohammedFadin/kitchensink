# Pull to refresh from https://github.com/ccoenraets/pull-to-refresh

document.addEventListener "deviceready", ->
  angular.bootstrap document, ['pullToRefreshApp']

echoApp = angular.module 'pullToRefreshApp', ['hmTouchevents']

echoApp.controller 'IndexCtrl', ($scope)->

  $scope.items = []

  itemCount = 0

  $scope.addItems = (x) ->
    i = 0

    while i < x
      itemCount++
      $scope.items.push({id: itemCount})
      i++

  $scope.addItems(20)

  $('.scrollable').pullToRefresh
    callback: ->
      deferred = $.Deferred()

      setTimeout(
        ->
          # Simulate a refresh: add 3 items to the list
          $scope.addItems(3)
          deferred.resolve()
        , 2000
      )

      return deferred.promise()


#Example of a typical use of pull-to-refresh where an ajax call is made to get the latest items
# $(".scrollable").pullToRefresh
#   callback: ->
#     promise = $.ajax(
#       url: "http://myserver.com/myendpoint"
#       dataType: "json"
#       type: "GET"
#     ).done(
#       (data)->
#         # Add new items to the list
#     )
#     promise
