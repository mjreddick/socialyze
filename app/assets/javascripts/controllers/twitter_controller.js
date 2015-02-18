angular
  .module("socialyze")
  .controller("TwitterController", TwitterController);

TwitterController.$inject = ['$resource'];


// Angular Twitter Controller to control twitter angular template
  function TwitterController($resource){
    var self = this;
    var accessToken = window.sessionStorage.access_token;

    var Tweets = $resource('http://localhost:3000/api/tweets',
        {update: {method: 'PUT'}} );

    self.test = "Im in the ng-twitter controller"
    self.tweetList = getTweets();

    function getTweets() {
      return Tweets.get();
    };

  }
