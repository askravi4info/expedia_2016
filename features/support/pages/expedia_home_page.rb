class ExpediaHomePage
  include PageObject

  page_url 'www.expedia.com'

  link(:select_flight_tab, :id => 'tab-flight-tab')
  text_field(:departure_airport, :id => 'flight-origin')
  text_field(:arrival_airport, :id => 'flight-destination')
  ul(:list_of_airports, :class => 'results')
  text_field(:departure_date, :id => 'flight-departing')
  text_field(:arrival_date, :id => 'flight-returning')
  button(:search_flights, :id => 'search-button')
  link(:date_error_message, :class => 'dateBeforeCurrentDateMessage')
  link(:destination_error_message, :class => 'destinationError')

  div(:error_message, :id => 'flight-errors')


  def set_departure_airport airport_name
    self.departure_airport = airport_name
    departure_airport_element.send_keys :end
    select_airport airport_name
  end

  def set_arrival_airport airport_name
    self.arrival_airport = airport_name
    arrival_airport_element.send_keys :end
    select_airport airport_name
  end

  def select_airport airport_name
    list_of_airports_element.when_visible.list_item_elements.each do |airport|
      if airport.text.include? airport_name
        # p "I Found the airport and selected"
        airport.click
        break
      end
    end
  end

  def select_travel_dates current_future
    if current_future == 'future'
      correct_date = calculate_dates 2
    else
      correct_date = calculate_dates -2
    end

    self.departure_date = correct_date
    self.arrival_date = correct_date
  end

  def verify_error_message actual_error_message, expected_error_message
    fail "Actual Error - #{actual_error_message} Message is NOT same as Expected Error Message - #{expected_error_message}" unless actual_error_message == expected_error_message
  end

  def create_future_flight
    select_flight_tab
    set_departure_airport "Columbus, OH"
    set_arrival_airport "Cleveland, OH"
    select_travel_dates "future"
    search_flights_element.click
  end

  def load_data_yml
    @file = YAML.load_file('C:\Documents and Settings\Administrator\Desktop\Jan 2016\Automation\Ruby\expedia_search_Jan2016\features\test_data.yml')
    p @file.fetch('request')
    p @file['tool']
    p @file['company_details']['company_name']
    p @file['company_details']

    File.open('../../test_data.yml', 'w'){|f| f.write(@file.to_yaml)}
    @file['tool'] = 'qtp'

    p @file['tool']


  end


  private

  def calculate_dates(no_of_days)
    (Time.now + 60*60*24*no_of_days).strftime("%m/%d/%Y")
  end


end