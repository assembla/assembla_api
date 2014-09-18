@api
Feature: MR Versions Votes
  Background:
    Given I have "Assembla::Client::Spaces::MergeRequests::Versions::Votes" instance
    And I use specific space name
    And I have a space
    And I have a git tool
    And I have two git branches
    And I have a merge request

  Scenario: List
    When I voted already
    And I make request with method list
    Then the response status should be 200

  Scenario: Vote +1
    When I make request with method upvote
    Then the response status should be 201

  Scenario: Vote -1
    When I make request with method downvote
    Then the response status should be 201

  Scenario: Delete
    When I voted already
    And I make request with method delete
    Then the response status should be 201
