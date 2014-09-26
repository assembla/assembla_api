@api
Feature: Space Tags
  Background:
    Given I have "Assembla::Client::Spaces::Tags" instance
    And I use different space name
    And I have a space
    And I have a ticket tool

  Scenario: Create
    When I make request with method create
    Then the response status should be 201

  Scenario: Get
    When I have a tag
    And I make request with method get
    Then the response status should be 200

  @wip @bug25735
  Scenario: Edit
    When I have a tag
    And I make request with method edit
    Then the response status should be 204

  @wip @bug25735
  Scenario: Delete
    When I have a tag
    And I make request with method delete
    Then the response status should be 204

  Scenario: List
    When I have a tag
    And I make request with method list
    Then the response status should be 200

  Scenario: List Active
    When I have a tag
    And I make request with method active
    Then the response status should be 200

  Scenario: List Proposed
    When I have a proposed tag
    And I make request with method proposed
    Then the response status should be 200

  Scenario: List Hidden
    When I have a hidden tag
    And I make request with method hidden
    Then the response status should be 200

  Scenario: List Tickets
    When I have a tag
    And I have a ticket with tags
    And I make request with method tickets
    Then the response status should be 200
