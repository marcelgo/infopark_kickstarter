
# open angular app in dialog if clicked
$ ->
  $(document).on 'click', 'a.media', ->
    modalContent = '<div id="ip-mediabrowser" class="modal"><div class="ng-view"></div></div>'

    app = $('body').append modalContent
    $('#ip-mediabrowser').css('z-index', 999999).modal('show')

    angular.bootstrap(app[0], ['ip-mediabrowser'])


############################# router

window.mediabrowser = angular.module('ip-mediabrowser', ['ngResource']).
config ["$routeProvider", ($routeProvider) ->
  $routeProvider.when "/mediabrowser",
    template: window.JST["mediabrowser"]()
    controller: 'IpMediabrowserController'

  $routeProvider.otherwise redirectTo: "/mediabrowser"
]

############################# services

window.mediabrowser.factory 'Image', ['$resource', ($resource) ->
  Image = $resource '/mediabrowser/:id',
    id: '@_id'

  Image
]

############################## directives

mediabrowser.directive 'ngDraggableThumbnail', ->
  scope:
    object: '=object'
    src: '@ngSrc'
  link: ($scope, $element, $attr) ->
    $element.attr('src', $scope.src)
    $element.data('object', $scope.object)

    $element.draggable
      revert: 'invalid'
      cursor: 'move'
      containment: '.modal-body'

mediabrowser.directive 'ngThumbnailDropzone', ->
  scope:
    onDrop: '='
  link: ($scope, $element, $attr) ->
    $element.droppable
      accept: 'img.thumbnail'
      drop: (event, ui) ->
        image = ui.draggable.data('object')
        $scope.onDrop(image)


############################## controller

window.mediabrowser.controller 'IpMediabrowserController', ['$scope', '$route', '$location', 'Image', ($scope, $route, $location, $Image) ->
  $scope.images = $Image.query {}
  $scope.imageSelection = []

  $scope.addImageToSelection = (image) ->
    $scope.imageSelection.push(image)
    console.log "Pushed to selection: ", image
]