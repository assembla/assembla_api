@api
Feature: Portfolio Invitations
  Background:
    Given I have "Assembla::Client::Portfolio::Invitations" instance

  Scenario: List
    When I have an invitation
    And I make request with method list
    Then the response status should be 200

  Scenario: Create
    When I make request with method create
    Then the response status should be 201

  Scenario: Get
    When I have an invitation
    And I make request with method get
    Then the response status should be 200
