#= require_self
#= require_tree ./app
#= require_tree ./controllers
#= require_tree ./directives
#= require_tree ./services

angular.module('ip-mediabrowser', ['ngResource', 'ngSanitize'])

# open angular app in dialog if clicked
$ ->
  $(document).on 'click', 'a.media', ->
    modalContent = '<div id="ip-mediabrowser" class="modal"><div class="ng-view"></div></div>'

    appContainment = $('body').append modalContent
    $('#ip-mediabrowser').modal('show')

    angular.bootstrap(appContainment, ['ip-mediabrowser'])
