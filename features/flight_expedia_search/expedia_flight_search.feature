@domestic_flight
Feature: Verify the Flight Search Functionality

  Background:
    Given user is on expedia home page

  @slow
  Scenario: Verify the user gets an error message when searching for past flights
    And user should select the flights tab
    And user selects Columbus, OH airport for the city from departure field
    And user selects Cleveland, OH airport for the city from arrival field
    And user makes a past date flight search
    fa
    sf
    sa
    And searches for the flights availability
    Then verify the "The start or end date is prior to the current date." error message is displayed

  @regression
  Scenario Outline: Verify the user finds the correct departure flight details
    And user should select the flights tab
    And user selects <dep_airport> airport for the city from departure field
    And user selects <arr_airport> airport for the city from arrival field
    And user makes a future date flight search
    And searches for the flights availability
    Then verify the flight search results <results_msg> is displayed correctly

    Examples:
      | dep_airport  | arr_airport   | results_msg                        |
      | Columbus, OH | Cleveland, OH | Select your departure to Cleveland |

  @smoke
  Scenario: Verify different error messages when searching for past flights
    And user should select the flights tab
    And user makes a past date flight search
    And searches for the flights availability
    Then verify the following error message are displayed
      | error_messages                                      | dates  |
      | The start or end date is prior to the current date. | past   |
      | Please complete the highlighted origin field below... | future |

  @exp_flg_002
  Scenario:Verify the sort order of the search results are by price
    And user search for a future valid flights
    Then verify the search results are displayed by price


    Scenario: Verify the yml functionality
      Then verify the yml funcitonality is working


  @wip
  Scenario:Verify the sort order of the search results are by price
    And user search for a future valid International flights
    Then verify the search results are displayed by time

  @manual
  Scenario: verify the look and feel of the Expedia home page
    Given user is on expedia home page
    Then veirify the look and feel of the page is same as the wireframes
