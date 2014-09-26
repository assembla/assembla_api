@api
Feature: Space Tickets
  Background:
    Given I have "Assembla::Client::Spaces::Tickets" instance
    And I use different space name
    And I have a space
    And I have a ticket tool

  Scenario: Create
    When I make request with method create
    Then the response status should be 201

  Scenario: Get
    When I have a ticket
    And I make request with method get by number
    Then the response status should be 200

  Scenario: Get by ID
    When I have a ticket
    And I make request with method get by id
    Then the response status should be 200

  Scenario: Edit
    When I have a ticket
    And I make request with method edit
    Then the response status should be 204

  Scenario: Delete
    When I have a ticket
    And I make request with method delete
    Then the response status should be 204

  Scenario: List
    When I have a ticket
    And I make request with method list
    Then the response status should be 200

  Scenario: Attachments
    When I have a files tool
    And I have a ticket
    And It has an attachment
    And I make request with method attachments
    Then the response status should be 200

  Scenario: Tags
    When I have a ticket with tags
    And I make request with method tags
    Then the response status should be 200

  Scenario: Custom Reports
    When I have a custom report
    And I make request with method custom reports
    Then the response status should be 204

  Scenario: My Tickets
    When I know my user ID
    And I have a ticket assigned to me
    And I make request with method my
    Then the response status should be 200

  Scenario: Followed Tickets
    When I have a ticket
    And I make request with method followed
    Then the response status should be 200

  Scenario: Tickets by Milestone
    When I have a milestone tool
    And I have a current milestone
    And I have a ticket with milestone current
    And I make request with method by_milestone_id
    Then the response status should be 200

  Scenario: Tickets without Milestone
    When I have a ticket
    And I make request with method without_milestone
    Then the response status should be 200
