angular
  .module("socialyze")
  .controller("AuthenticationController", AuthenticationController);

  AuthenticationController.$inject = ["$http"];

  function AuthenticationController($http){
    var self = this;
    self.test = "Im in the AuthenticationController"
  }