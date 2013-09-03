
angular.module('ip-mediabrowser').directive 'ipThumbnailDropzone', ->
  scope:
    onDrop: '='
  link: ($scope, $element, $attr) ->
    $element.droppable
      accept: 'img.thumbnail'
      drop: (event, ui) ->
        droppedObject = ui.draggable

        image = droppedObject.data('object')
        $scope.onDrop(image)

