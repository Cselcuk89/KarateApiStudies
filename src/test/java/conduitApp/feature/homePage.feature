
Feature: Tests for home page
  Background: Define url
    Given url apiUrl

  Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains 'Git'
    And match response.tags contains ['Git','Zoom']
    And match response.tags !contains 'truck'
    And match response.tags contains any ['Git','dog','SIDA']
    And match response.tags == '#array'
    And match each response.tags == '#string'

  Scenario: get 10 articles from the page
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    Given params {limit:10,offset:0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == '#number'
    And match response.articlesCount != 100
    And match response == { "articles":"#array", "articlesCount" : '#number'}
    And match response.articles[0].createdAt contains '2025'
    And match response.articles[*].favoritesCount contains 0
    And match response.articles[*].author.bio contains null
    And match each response..following == false
    And match each response..following == '#boolean'
    And match each response..favoritesCount == '#number'
     # the expected value is either string or null for below line
    And match each response..bio == '##string'
    And match each response.articles ==
        """
            {
                "title": "#string",
                "slug": "#string",
                "body": "#string",
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "tagList": "#array",
                "description": "#string",
                "author": {
                    "username": "#string",
                    "bio": "##string",
                    "image": "#string",
                    "following": '#boolean'
                },
                "favorited": '#boolean',
                "favoritesCount": '#number'
            }
        """



