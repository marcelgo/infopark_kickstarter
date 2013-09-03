
angular.module('ip-mediabrowser').controller 'IpMediabrowserController', ['$scope', '$route', '$location', 'Image', ($scope, $route, $location, $Image) ->
  $scope.images = $Image.query {}
  $scope.imageSelection = []

  $scope.addImageToSelection = (image) ->
    $scope.imageSelection.push(image)

    console.log "Pushed to selection: ", image
]
