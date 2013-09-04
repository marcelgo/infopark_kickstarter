angular.module('ip-mediabrowser').controller 'IpMediabrowserController', ['$scope', '$route', '$location', 'Image', ($scope, $route, $location, $Image) ->
  $scope.loading = true
  $scope.queryResults = $Image.get({}, (result) ->
    $scope.images = result.images
    $scope.maxPages = result.meta.maxPages
    $scope.resultCount = result.meta.resultCount
    $scope.loading = false
  )
  $scope.page = 1
  $scope.imageSelection = []
  $scope.inspectedObject = undefined

  $scope.close = (event) ->
    modal = $(event.target).parents().filter('.modal')

    if modal?
      modal.modal('hide')

  $scope.navigate = (direction) ->
    $scope.loading = true

    if direction == 'next'
      $scope.page += 1
    else
      $scope.page -= 1

    $scope.queryResults = $Image.get({page: $scope.page}, (result) ->
      $scope.images = result.images
      $scope.maxPages = result.meta.maxPages
      $scope.loading = false
    )

  $scope.save = (event) ->
    ids = $.map($scope.imageSelection, (image) ->
      image.id
    )
    $('.mediabrowser-selected-items').html(ids.join(', '))
    $scope.close(event)

  $scope.hideInspector = () ->
    $scope.inspectedObject = undefined

  $scope.inspectObject = (object) ->
    $scope.inspectedObject = object
]
