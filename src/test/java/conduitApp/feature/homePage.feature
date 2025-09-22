
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


