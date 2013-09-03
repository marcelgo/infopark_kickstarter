
angular.module('ip-mediabrowser')
.directive 'ipObjectInspector', ['EditPage', ($EditPage) ->
  restrict: 'E'
  replace: true
  scope:
    model: '='
  template: '<div ng-bind-html-unsafe="editPage.markup"></div>'
  controller: ['$scope', '$timeout', ($scope, $timeout) ->
    $scope.editPage = undefined

    $scope.$watch 'model', ->
      return unless $scope.model

      objId = $scope.model.id

      $scope.editPage = $EditPage.get {id: objId}, $scope.refreshInplaceEditing

    $scope.refreshInplaceEditing = ->
      $timeout ->
        window.infopark.editing.refresh()
  ]
]