Feature: Bidding

  As a buyer
  I want to make a bid on an interesting commodity
  So that I have a chance to buy it.

  Background:
    Given the following users exist:
    | id | first_name | last_name |
    | 1  | nancy      | q         |
    | 2  | jealous    | dave      |
    | 3  | parkins    | jack      |
    
    Given the following listings exist:
    | id | title | price | bid_quantity | user_id |
    | 1  | pipe  | 10    | 2            | 1    |

    Given the following bids exist:
    | id | listing_id | user_id | bid_price |
    | 1  | 1          | 2       | 11        |
    | 2  | 1          | 3       | 12        |


  Scenario: Seeing previous bids
    Given I am on the listings page
    And I go to the bid page for pipe
    Then I should see pipe
    Then I should see original price as 10
    Then I should see 11
    And I should see 12
    Then I should see average price as 11.5

  Scenario: Making a bid
    Given I am on the listings page
    And I go to the bid page for pipe
    And I click bid
    And I enter 13
    And I follow enter
    Then I should see original price as 10
    Then I should see 11
    And I should see 12
    And I should see 13
    Then I should see average price as 12

  Scenario: Not making a bid
    Given I am on the listings page
    And I go to the bid page for pipe
    And I click bid
    And I follow enter
    Then I should see original price as 10
    Then I should see 11
    And I should see 12
