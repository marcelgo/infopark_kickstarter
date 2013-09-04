angular.module('ip-mediabrowser').controller 'IpMediabrowserController', ['$scope', '$route', '$location', 'Image', ($scope, $route, $location, $Image) ->
  $scope.queryResults = $Image.get({}, (result) ->
    $scope.images = result.images
    $scope.maxPages = result.meta.maxPages
    $scope.resultCount = result.meta.resultCount
  )
  $scope.page = 1
  $scope.imageSelection = []
  $scope.inspectedObject = undefined

  $scope.close = (event) ->
    modal = $(event.target).parents().filter('.modal')

    if modal?
      modal.modal('hide')

  $scope.navigate = (direction) ->
    if direction == 'next'
      $scope.page += 1
    else
      $scope.page -= 1

    $scope.queryResults = $Image.get({page: $scope.page}, (result) ->
      $scope.images = result.images
      $scope.maxPages = result.meta.maxPages
    )

  $scope.save = (event) ->
    console.log('TBD: store values')

  $scope.hideInspector = () ->
    $scope.inspectedObject = undefined

  $scope.inspectObject = (object) ->
    $scope.inspectedObject = object
]
