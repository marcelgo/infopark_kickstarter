angular.module('ip-mediabrowser').factory 'Image', ['$resource', ($resource) ->
  Image = $resource '/mediabrowser/:id',
    id: '@_id'

  Image
]
