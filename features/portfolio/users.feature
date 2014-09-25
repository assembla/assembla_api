@api
Feature: Portfolio Users
  Background:
    Given I have "Assembla::Client::Portfolio::Users" instance

  Scenario: List
    When I make request with method list
    Then the response status should be 200
