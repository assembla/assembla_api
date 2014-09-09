@api
Feature: Space Users
  Background:
    Given I have "Assembla::Client::Spaces::Users" instance

  Scenario: List
    When I have a space
    And I have user dev1
    And I invite dev1 to the space
    And I make request with method list
    Then the response status should be 200
