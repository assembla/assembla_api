@api
Feature: Merge Requests
  Background:
    Given I have "Assembla::Client::Spaces::MergeRequests" instance
    And I use specific space name
    And I have a space
    And I have a git tool
    And I have two git branches

  Scenario: Create
    When I make request with method create
    Then the response status should be 201

  Scenario: Ignore
    When I have a merge request
    And I make request with method ignore
    Then the response status should be 204

  Scenario: Merge
    When I have a merge request
    And I make request with method merge
    Then the response status should be 204

  Scenario: Get
    When I have a merge request
    And I make request with method get
    Then the response status should be 200

  Scenario: List
    When I have a merge request
    And I make request with method list
    Then the response status should be 200

  Scenario: Comments
    When I have a merge request
    And I comment on MR
    And I make request with method comments
    Then the response status should be 200

  Scenario: Tickets
    When I have a ticket tool
    And I have a ticket
    And I have a merge request with link to ticket
    And I make request with method tickets
    Then the response status should be 200
