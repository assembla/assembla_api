@api
Feature: Ticket Associations
  Background:
    Given I have "Assembla::Client::Spaces::Tickets::Associations" instance
    And I use specific space name
    And I have a space
    And I have a ticket tool
    And I have a ticket

  Scenario: Create
    When I have another ticket
    And I make request with method create
    Then the response status should be 201

  Scenario: Get
    When I have a ticket association
    And I make request with method get
    Then the response status should be 200

  Scenario: Edit
    When I have a ticket association
    And I make request with method edit
    Then the response status should be 204

  Scenario: Delete
    When I have a ticket association
    And I make request with method delete
    Then the response status should be 204

  Scenario: List
    When I have a ticket association
    And I make request with method list
    Then the response status should be 200
