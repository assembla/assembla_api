@api
Feature: SSH Actions
  Background:
    Given I have "Assembla::Client::Spaces::Ssh::Actions" instance
    And I use specific space name
    And I have a space
    And I have a ssh tool
    And I have a ssh server

  Scenario: Create
    When I make request with method create
    Then the response status should be 201

  Scenario: Get
    When I have a ssh action
    And I make request with method get
    Then the response status should be 200

  Scenario: Edit
    When I have a ssh action
    And I make request with method edit
    Then the response status should be 204

  Scenario: Delete
    When I have a ssh action
    And I make request with method delete
    Then the response status should be 204

  Scenario: Run
    When I have a ssh action
    And I have a space ssh key
    And I make request with method run
    Then the response status should be 200

  Scenario: List
    When I have a ssh action
    And I make request with method list
    Then the response status should be 200
