@api
Feature: SSH Action Launches
  Background:
    Given I have "Assembla::Client::Spaces::Ssh::Actions::Launches" instance
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
