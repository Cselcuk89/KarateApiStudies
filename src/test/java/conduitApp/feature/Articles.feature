Feature: Articles
  Background: Define url
    Given url 'https://conduit-api.bondaracademy.com/api/'
  Scenario: Create a new article
    Given path 'users/login'
    And request {"user": {"email": "abc1@gmail.com","password": "abc123456"}}
    When method Post
    Then status 200
    * def token = response.user.token
    * print 'response token is ' + token
    Given header Authorization = 'Token ' + token
    And path 'articles'
    * def articleTitle = 'Bla bla ' + generateUniqueName()
    And request {"article": {"tagList": [],"title": "#(articleTitle)","description": "test test","body":"body"}}
    When method Post
    Then status 201
    And match response.article.title == articleTitle
