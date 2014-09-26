@api
Feature: SSH Launches
  Background:
    Given I have "Assembla::Client::Spaces::Ssh::Launches" instance
    And I use specific space name
    And I have a space
    And I have a ssh tool
    And I have a space ssh key
    And I have a ssh server
    And I have a ssh action

  Scenario: List
    When I run ssh action
    And I make request with method list
    Then the response status should be 200

  Scenario: Get
    When I run ssh action
    And I know ssh launch id
    And I make request with method get
    Then the response status should be 200

  Scenario: Get full output
    When I run ssh action
    And I know ssh launch id
    And I make request with method output
    Then the response status should be 200
