angular.module('ip-mediabrowser').directive 'ipThumbnailDropzone', ->
  restrict: 'A'
  scope:
    onDrop: '&'
    itemList: '='
  link: ($scope, $element, $attr) ->
    $element.droppable
      accept: 'img.thumbnail'
      drop: (event, ui) ->
        droppedObject = ui.draggable

        image = droppedObject.data('object')

        $scope.$apply ->
          $scope.itemList.push image

