@api
Feature: Portfolio Ticket Reports
  Background:
    Given I have "Assembla::Client::Portfolio::TicketReports" instance

  Scenario: List
    When I make request with method list
    Then the response status should be 204
