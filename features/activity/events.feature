@api
Feature: Events
  Background:
    Given I have "Assembla::Client::Activity" instance

  @wip
  Scenario: List
    When I have a space
    And I have a ticket tool
    And I create a ticket
    And I make request with method list
    Then the response status should be 200

  @wip
  Scenario: List for interval
    When I make request with method list and date interval
    Then the response status should be 200

  @wip
  Scenario: List for space
    When I make request with method list filtered by space
    Then the response status should be 200
