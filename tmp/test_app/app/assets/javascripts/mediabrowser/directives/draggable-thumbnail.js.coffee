
angular.module('ip-mediabrowser').directive 'ipDraggableThumbnail', ->
  scope:
    object: '='
    imageUrl: '='
  link: ($scope, $element, $attr) ->
    $element.attr('src', $scope.imageUrl)

    $element.data('object', $scope.object)

    $element.draggable
      revert: true
      cursor: 'move'
      containment: '.modal-body'
