angular.module('ip-mediabrowser').
config ["$routeProvider", ($routeProvider) ->
  $routeProvider.when "/mediabrowser",
    template: window.JST["mediabrowser"]()
    controller: 'IpMediabrowserController'

  $routeProvider.otherwise redirectTo: "/mediabrowser"
]