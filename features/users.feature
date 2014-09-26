@api
Feature: Users
  Background:
    Given I have "Assembla::Client::Users" instance

  Scenario: Me
    When I make request with method me
    Then the response status should be 200

  Scenario: Find
    When I have user dev1
    And I make request with method get for user dev1
    Then the response status should be 200

  Scenario: Picture
    When I make request with method picture for me
    Then the response status should be 200
