@api
Feature: Webhooks
  Background:
    Given I have "Assembla::Client::Spaces::Webhooks" instance
    And I use different space name
    And I have a space
    And I have a webhook tool

  Scenario: Create
    When I make request with method create
    Then the response status should be 201

  Scenario: Edit
    When I have a webhook
    And I make request with method edit
    Then the response status should be 204

  Scenario: Delete
    When I have a webhook
    And I make request with method delete
    Then the response status should be 204
