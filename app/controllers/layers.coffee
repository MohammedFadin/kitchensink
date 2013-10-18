layersApp = angular.module "layersApp", ["hmTouchevents"]


# index.html
layersApp.controller "IndexCtrl", ($scope)->

  $scope.openShow = ->
    showView = new steroids.views.WebView("views/layers/show.html")
    steroids.layers.push(showView)

  # Native UI
  steroids.view.navigationBar.show "Index"

# show.html
layersApp.controller "ShowCtrl", ($scope)->

  $scope.openEdit = ->
    editView = new steroids.views.WebView("views/layers/edit.html")
    steroids.layers.push(editView)

  deleted = false

  document.addEventListener "visibilitychange", ->
    console.log "Show view is #{document.visibilityState}"
    if document.visibilityState is "visible"
      if deleted
        deleted = false
        setTimeout(
          ->
            steroids.layers.pop()
          1000
        )

  window.addEventListener "message", (msg)->
    if msg.data.id is 34
      if msg.data.action is "delete"
        deleted = true

  # Native UI
  steroids.view.navigationBar.show "Show"

# edit.html
layersApp.controller "EditCtrl", ($scope)->

  $scope.delete = ->

    message =
      id: 34
      action: "delete"

    window.postMessage(message, "*")
    steroids.layers.pop()

  # Native UI
  steroids.view.navigationBar.show "Edit"
