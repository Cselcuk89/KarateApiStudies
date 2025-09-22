@ignore
Feature: Sign up new user
  Background: Preconditions
    Given url apiUrl
    @debug
  Scenario: New user signup
    Given def userData = {  "email": "KarateUser1523@test.com","username":"KarateUsers1986"}
    Given path 'users'
    And request
      """
      {"user": {
          "email": "#(userData.email)",
          "password": "123Karate123",
          "username":"#(userData.username)"}
      }
      """
    When method Post
    Then status 201