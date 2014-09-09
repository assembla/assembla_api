@api
Feature: Space User Roles
  Background:
    Given I have "Assembla::Client::Spaces::UserRoles" instance

  Scenario: Create
    When I have a space
    And I have user dev1
    And I invite dev1 to the space
    Then the user role should not be nil

  Scenario: Edit
    When I have a space
    And I have user dev1
    And I invite dev1 to the space
    And I change dev1 role to owner
    Then the response status should be 204

  Scenario: Delete
    When I have a space
    And I have user dev1
    And I invite dev1 to the space
    And I make request with method delete
    Then the response status should be 204

  Scenario: List
    When I have a space
    And I have user dev1
    And I invite dev1 to the space
    And I make request with method list
    Then the response status should be 200

  Scenario: Get
    When I have a space
    And I have user dev1
    And I invite dev1 to the space
    And I make request with method get
    Then the response status should be 200

