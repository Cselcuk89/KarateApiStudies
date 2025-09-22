@ignore
Feature: Articles
  Background: Define url
    Given url apiUrl
  Scenario: Create a new article
    And path 'articles'
    * def articleTitle = 'Bla bla ' + generateUniqueName()
    And request {"article": {"tagList": [],"title": "#(articleTitle)","description": "test test","body":"body"}}
    When method Post
    Then status 201
    And match response.article.title == articleTitle


  Scenario: Create and delete article
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
    And path 'articles', articleId
    When method Delete
    Then status 204
    And path 'articles', articleId
    When method Get
    Then status 404
    And match response.article == '#notpresent'






