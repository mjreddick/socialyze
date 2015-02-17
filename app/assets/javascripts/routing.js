(function(){



angular
  .module('socialyze')
  .config(config)
  .run(run);

  function config($routeProvider, $locationProvider){
    $routeProvider

    .when('/', {
      templateUrl: "home.html",
      controller: 'SocialyzeController',
      controllerAs: 'main'
    })
    .when('/twitter', {
      title: "Your Twitter Info",
      templateUrl: "twitter.html",
      controller: "TwitterController",
      controllerAs: 'twitter'
    })
    .otherwise({
      redirectTo: '/'
    });
  }

  function run($location, $rootScope){
    var changeRoute = function(event, current, previous){
      return $rootScope.title = current.$$route.title;
    };

    $rootScope.$on('$routeChangeSuccess', changeRoute);
  }

}).call(this);