@api
Feature: MR Versions Comments
  Background:
    Given I have "Assembla::Client::Spaces::SpaceTools::MergeRequests::Versions::Comments" instance
    And I use specific space name
    And I have a space
    And I have a git tool
    And I have a ssh key uploaded
    And git tool is ready
    And I have two git branches
    And I have a merge request

  Scenario: Create
    When I make request with method create
    Then the response status should be 201

  Scenario: List
    When I have a merge request version comment
    And I make request with method list
    Then the response status should be 200
