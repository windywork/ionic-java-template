app.config(["$stateProvider","$urlRouterProvider",function($stateProvider, $urlRouterProvider) {
  $stateProvider
    .state('tab', {
    url: "/tab",
    abstract: true,
    templateUrl: "templates/tabs.html"
  })
  .state('tab.dash', {
    url: '/dash',
    views: {
      'tab-dash': {
        templateUrl: 'templates/tab-dash.html',
        controller: 'DashCtrl'
      }
    }
  })

  // if none of the 22fffabove states are matched, use this as the fallback
  $urlRouterProvider.otherwise('/tab/dash');

}]);

