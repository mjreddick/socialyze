angular
  .module("socialyze")
  .controller("SocialyzeController", SocialyzeController);

  function SocialyzeController(){
    var self = this;
    self.test = "Angular is working";
    var accessToken = window.sessionStorage.access_token;
  }