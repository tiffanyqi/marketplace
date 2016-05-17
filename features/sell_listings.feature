Feature: Selling

  As a seller
  I want to see my listings
  So that I can modify it if I need to

  Background:
    Given the following users exist:
    | user | first_name | last_name |
    | 1    | nancy      | q         |
    Given the following listings exist:
    | title | price | bid_quantity | user | bidders |
    | pipe  | 10    | 2            | 1    | 2, 3    |


  Scenario: