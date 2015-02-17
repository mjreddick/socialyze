angular
  .module("socialyze")
  .controller("TwitterController", TwitterController);

  TwitterController.$inject = ['$resource'];


// Angular Twitter Controller to control twitter angular template
  function TwitterController($resource){
    var self = this;

    var Tweets = $resource('http://localhost:3000/api/tweets')
    
    self.test = "Im in the ng-twitter controller"
    self.tweetList = getTweets();

    function getTweets() {
      return Tweets.get();
    };

  }
