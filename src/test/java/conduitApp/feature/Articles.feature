@debug
Feature: Articles
  Background: Define url
    Given url 'https://conduit-api.bondaracademy.com/api/'
    * def tokenResponse = callonce read('classpath:helpers/createToken.feature') {"email": "abc1@gmail.com","password": "abc123456"}
    * def token = tokenResponse.authToken
  Scenario: Create a new article
    Given header Authorization = 'Token ' + token
    And path 'articles'
    * def articleTitle = 'Bla bla ' + generateUniqueName()
    And request {"article": {"tagList": [],"title": "#(articleTitle)","description": "test test","body":"body"}}
    When method Post
    Then status 201
    And match response.article.title == articleTitle


  Scenario: Create and delete article
    Given header Authorization = 'Token ' + token
    And path 'articles'
    * def articleTitle = 'Delete Article ' + generateUniqueName()
    And request {"article": {"tagList": [],"title": "#(articleTitle)","description": "test test","body":"body"}}
    When method Post
    Then status 201
    * def articleId = response.article.slug
    And path 'articles', articleId
    When method Get
    Then status 200
    And match response.article.title == articleTitle
    Given header Authorization = 'Token ' + token
    And path 'articles', articleId
    When method Delete
    Then status 204
    And path 'articles', articleId
    When method Get
    Then status 404
    And match response.article == '#notpresent'






