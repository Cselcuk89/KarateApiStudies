function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit-api.bondaracademy.com/api/'

  }
  config.generateUniqueName = function() {
      return java.util.UUID.randomUUID().toString();
    }
  if (env == 'dev') {
    config.userEmail = 'abc1@gmail.com'
    config.userPassword = 'abc123456'
  } else if (env == 'qa') {
    config.userEmail = 'abc2@gmail.com'
    config.userPassword = 'abc123456'
  }
  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature',config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})
  return config;
}