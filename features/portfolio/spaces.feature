@api
Feature: Portfolio Spaces
  Background:
    Given I have "Assembla::Client::Portfolio::Spaces" instance
    And I have a space

  Scenario: List
    When I make request with method list
    Then the response status should be 200
