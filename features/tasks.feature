@api
Feature: Tasks
  Background:
    Given I have "Assembla::Client::Tasks" instance

  Scenario: Create
    When I make request with method create
    Then the response status should be 201

  Scenario: Get
    When I have a task
    And I make request with method get
    Then the response status should be 200

  Scenario: Edit
    When I have a task
    And I make request with method edit
    Then the response status should be 204

  Scenario: Delete
    When I have a task
    And I make request with method delete
    Then the response status should be 204

  Scenario: List
    When I have a task
    And I make request with method list
    Then the response status should be 200
