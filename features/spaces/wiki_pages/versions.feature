@api
Feature: Wiki Pages Versions
  Background:
    Given I have "Assembla::Client::Spaces::WikiPages::Versions" instance
    And I use specific space name
    And I have a space
    And I have a wiki tool
    And I have a wiki page

  Scenario: Get
    When I make request with method get
    Then the response status should be 200

  Scenario: List
    When I make request with method list
    Then the response status should be 200
