angular
  .module("socialyze")
  .controller("TwitterController", TwitterController);


// Angular Twitter Controller to control twitter angular template
  function TwitterController(){
    var self = this;
    self.test = "Im in the ng-twitter controller"
  }