@api
Feature: Space Milestones
  Background:
    Given I have "Assembla::Client::Spaces::Milestones" instance
    And I use different space name
    And I have a space
    And I have a milestone tool

  Scenario: Create
    When I make request with method create
    Then the response status should be 201

  Scenario: Get
    When I have a milestone
    And I make request with method get
    Then the response status should be 200

  Scenario: Edit
    When I have a milestone
    And I make request with method edit
    Then the response status should be 204

  Scenario: Delete
    When I have a milestone
    And I make request with method delete
    Then the response status should be 204

  Scenario: List
    When I have a milestone
    And I make request with method list
    Then the response status should be 200

  Scenario: List All
    When I have a milestone
    And I make request with method all
    Then the response status should be 200

  Scenario: List Upcomming
    When I have a milestone
    And I make request with method upcoming
    Then the response status should be 200

  Scenario: List Completed
    When I have a completed milestone
    And I make request with method completed
    Then the response status should be 200

  Scenario: List Release Notes
    When I have a milestone with release notes
    And I make request with method release_notes
    Then the response status should be 200
