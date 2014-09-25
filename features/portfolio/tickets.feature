@api
Feature: Portfolio Tickets
  Background:
    Given I have "Assembla::Client::Portfolio::Tickets" instance
    And I have a space
    And I have a ticket tool
    And I have a ticket

  @wip @bug25722
  Scenario: List
    When I make request with method list
    Then the response status should be 200
