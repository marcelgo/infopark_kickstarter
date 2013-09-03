angular.module('ip-mediabrowser').controller 'IpMediabrowserController', ['$scope', '$route', '$location', 'Image', ($scope, $route, $location, $Image) ->
  $scope.images = $Image.query {}
  $scope.imageSelection = []
  $scope.inspectedObject = undefined

  $scope.addImageToSelection = (image) ->
    $scope.imageSelection.push(image)

    console.log "Pushed to selection: ", image

  $scope.close = (event) ->
    modal = $(event.target).parents().filter('.modal')

    if modal?
      modal.modal('hide')

  $scope.save = (event) ->
    console.log('TBD: store values')

  $scope.hideInspector = () ->
    $scope.inspectedObject = undefined

  $scope.inspectObject = (object) ->
    $scope.inspectedObject = object
]
