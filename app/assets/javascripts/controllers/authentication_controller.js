angular
  .module('socialyze')
  .controller('AuthenticationController', AuthenticationController);

AuthenticationController.$inject = ['$http'];

  function AuthenticationController($http){
    var self = this;

    self.email;
    self.password;
    self.login = login;
    self.isAuthenticated = isAuthenticated();
    self.logout = logout;

    function login(){
      $http.post('/api/authenticate', {
        email: self.email,
        password: self.password
      })
      .success(function(response){
        setAccessToken(response.access_token)
        self.isAuthenticated = isAuthenticated();
        self.email = null;
        self.password = null;
      })
      .error(function(response){
        console.log(response);
      })
    } // End Log in function

    function setAccessToken(token){
      window.sessionStorage.setItem("access_token", token);
    } // End setAccess Token function

    function isAuthenticated(){
      return window.sessionStorage.access_token ? true : false;
    } // End isAuthenticated function

    function logout(){
      window.sessionStorage.clear();
      self.isAuthenticated = isAuthenticated();
    }

  } // End Auth function