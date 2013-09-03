angular.module('ip-mediabrowser').factory 'EditPage', ['$resource', ($resource) ->
  EditPage = $resource '/mediabrowser/:id/edit',
    id: '@_id'

  EditPage
]