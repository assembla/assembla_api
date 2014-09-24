@api
Feature: MR Versions
  Background:
    Given I have "Assembla::Client::Spaces::SpaceTools::MergeRequests::Versions" instance
    And I use specific space name
    And I have a space
    And I have a git tool
    And I have a ssh key uploaded
    And git tool is ready
    And I have two git branches
    And I have a merge request

  Scenario: List
    When I make request with method list
    Then the response status should be 200

  Scenario: Get
    When I make request with method get
    Then the response status should be 200

  @live
  Scenario: Create
    When I push new changes to a dev branch
    And I make request with method create
    Then the response status should be 201
