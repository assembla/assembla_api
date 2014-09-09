@api
Feature: Space Tools
  Background:
    Given I have "Assembla::Client::Spaces::SpaceTools" instance
    And I have a space

  Scenario: Create
    When I make request with method create to add message tool
    Then the response status should be 201

  Scenario: Get
    When I have a message tool
    And I make request with method get
    Then the response status should be 200

  Scenario: Edit
    When I have a message tool
    And I make request with method edit
    Then the response status should be 204

  Scenario: Delete
    When I have a message tool
    And I make request with method delete
    Then the response status should be 204

  Scenario: List
    When I have a message tool
    And I make request with method list
    Then the response status should be 200

  Scenario: List Repositories
    When I have a git tool
    And I make request with method repo_list
    Then the response status should be 200
