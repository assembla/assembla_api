@api
Feature: Space Standup Away Reports
  Background:
    Given I have "Assembla::Client::Spaces::StandupAwayReports" instance
    And I use specific space name
    And I have a space
    And I have a standup tool
    And I want to see/create away reports 7 days ahead

  Scenario: Create
    When I make request with method create
    Then the response status should be 201

  Scenario: Edit
    When I have a standup away report
    And I make request with method edit
    Then the response status should be 201

  Scenario: My report
    When I have a standup away report
    And I make request with method my
    Then the response status should be 200

  Scenario: List
    When I have a standup away report
    And I make request with method list
    Then the response status should be 200
