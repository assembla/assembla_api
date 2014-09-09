@api
Feature: Spaces
  Background:
    Given I have "Assembla::Client::Spaces" instance

  Scenario: My
    When I make request with method my
    Then the response status should be 200

  Scenario: Create
    When I make request with method create
    Then the response status should be 201

  Scenario: Get
    When I make request with method get
    Then the response status should be 200

  @wip @bug25515
  Scenario: Edit
    When I have a space
    And I make request with method edit
    Then the response status should be 200

  Scenario: Delete
    When I have a space
    And I make request with method delete
    Then the response status should be 204

  Scenario: Copy
    When I have a space
    And I make request with method copy
    Then the response status should be 201
