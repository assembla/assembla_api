@api
Feature: Space StandUp Reports
  Background:
    Given I have "Assembla::Client::Spaces::StandUpReports" instance
    And I use different space name
    And I have a space
    And I have a standup tool

  Scenario: Create
    When I make request with method create
    Then the response status should be 201

  Scenario: Edit
    When I have a standup report
    And I make request with method edit
    Then the response status should be 204

  Scenario: My report
    When I have a standup report
    And I make request with method my
    Then the response status should be 200

  Scenario: List
    When I have a standup report
    And I make request with method list
    Then the response status should be 200
