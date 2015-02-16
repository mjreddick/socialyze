angular
  .module("socialyze")
  .controller("TwitterController", TwitterController);

  TwitterController.$inject = ['$resource'];


// Angular Twitter Controller to control twitter angular template
  function TwitterController($resource){
    var self = this;

    self.testd3 = testd3;


    var Tweets = $resource('http://localhost:3000/api/tweets',
        {update: {method: 'PUT'}} );

    self.test = "Im in the ng-twitter controller"
    self.tweetList = getTweets();

    function getTweets() {
      return Tweets.get();
    };

    function testd3() {
      console.log(d3);
    }
  }
