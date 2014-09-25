@api
Feature: Portfolio Standup Reports
  Background:
    Given I have "Assembla::Client::Portfolio::StandupReports" instance
    And I have a space with standup tool

  Scenario: List
    When I have a report for today
    And I make request with method list
    Then the response status should be 200

  Scenario: List Away
    When I want to see/create away reports 7 days ahead
    And I have an away report for next week day
    And I make request with method list away
    Then the response status should be 200

  Scenario: List with needs
    When I have a report with roadblocks
    And I make request with method list with needs
    Then the response status should be 200
