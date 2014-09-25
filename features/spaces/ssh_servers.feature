@api
Feature: SSH Servers
  Background:
    Given I have "Assembla::Client::Spaces::Ssh::Servers" instance
    And I use specific space name
    And I have a space
    And I have a ssh tool

  Scenario: Create
    When I make request with method create
    Then the response status should be 201

  Scenario: Get
    When I have a ssh server
    And I make request with method get
    Then the response status should be 200

  Scenario: Edit
    When I have a ssh server
    And I make request with method edit
    Then the response status should be 204

  Scenario: Delete
    When I have a ssh server
    And I make request with method delete
    Then the response status should be 204

  Scenario: List
    When I have a ssh server
    And I make request with method list
    Then the response status should be 200
