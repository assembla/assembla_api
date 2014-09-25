@api
Feature: Space SSH Keys
  Background:
    Given I have "Assembla::Client::Spaces::Ssh::Keys" instance
    And I use specific space name
    And I have a space
    And I have a ssh tool

  Scenario: Get
    When I have a space ssh key
    And I make request with method get
    Then the response status should be 200

  Scenario: Generate
    And I make request with method generate
    Then the response status should be 201
