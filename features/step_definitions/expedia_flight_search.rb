Given(/^user is on expedia home page$/) do
  visit ExpediaHomePage
end

And(/^user should select the flights tab$/) do
  # on(ExpediaHomePage).select_flight_tab_element.click
  on(ExpediaHomePage).select_flight_tab
end

And(/^user selects (.*) airport for the city from (departure|arrival) field$/) do |airport_name, dep_arr|
  # on(ExpediaHomePage).departure_airport_element.set airport_name

  # if dep_arr == 'departure'
  #   on(ExpediaHomePage).set_departure_airport airport_name
  # else
  #   on(ExpediaHomePage).set_arrival_airport airport_name
  # end

  on(ExpediaHomePage).send("set_#{dep_arr}_airport", airport_name)

end

And(/^user makes a (past|future) date flight search$/) do |past_future|
  on(ExpediaHomePage).select_travel_dates past_future
end

And(/^searches for the flights availability$/) do
  on(ExpediaHomePage).search_flights_element.click
end

Then(/^verify the "([^"]*)" error message is displayed$/) do |expected_error_message|
  actual_error_message = on(ExpediaHomePage).date_error_message_element.text
  # actual_error_message = on(ExpediaHomePage).send("#{error_type}_error_message_element").text
  on(ExpediaHomePage).verify_error_message actual_error_message, expected_error_message
end

Then(/^verify the flight search results (.*) is displayed correctly$/) do |results_msg|
  # p on(ExpediaSearchResultsPage).results_title_element.text
  fail "Arrival Airport Results are Not Displayed" unless on(ExpediaSearchResultsPage).results_title_element.text == results_msg
end

Then(/^verify the following error message are displayed$/) do |table|
  # table is a table.hashes.keys # => [:error_messages, :dates]
  table.hashes.each do |message|
    # p message['error_messages']
    # p message['dates']
    # destination_error_message = on(ExpediaHomePage).date_error_message_element.text
    # fail "The Actual error message - #{destination_error_message} is NOT same as #{message['error_messages']}" unless destination_error_message == message['error_messages']
    # p on(ExpediaHomePage).error_message_element.text
    (on(ExpediaHomePage).error_message_element.text).should include message['error_messages']
  end
end

And(/^user search for a future valid flights$/) do
  on(ExpediaHomePage) do |page|
    page.select_flight_tab
    page.set_departure_airport "Columbus, OH"
    page.set_arrival_airport "Cleveland, OH"
    page.select_travel_dates "future"
    page.search_flights_element.click
  end

end

Then(/^verify the search results are displayed by price$/) do
  actual_prices = on(ExpediaSearchResultsPage).get_price_details
  # fail "Prices are not Sorted in Ascending Order" unless actual_prices.sort == actual_prices
  actual_prices.should eq unless actual_prices.sort
end


Then(/^verify the yml funcitonality is working$/) do
  on(ExpediaHomePage).load_data_yml
end