@api
Feature: Events
  Background:
    Given I have "Assembla::Client::Activity" instance

  Scenario: List
    When I make request with method list
    Then the response status should be 200
