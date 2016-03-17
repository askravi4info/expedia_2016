class ExpediaSearchResultsPage
  include PageObject

  span(:results_title, :class => 'title-city-text')
  spans(:price, :class => 'dollars price-emphasis')
  div(:search_filter, :id => 'filterContainer')
  div(:progress, :class => 'progress-bar')


  def wait_for_page_to_load
    wait_until(45, "Search Filter has not loaded with in 45 sec") {
      search_filter_element.visible?
      # p progress_element.div_element.element.attribute_value('style')
      progress_element.div_element.element.attribute_value('style').include? '100'
    }
  end

  def get_price_details
    all_prices = []
    wait_for_page_to_load
    price_elements.each do |flight_price|
      all_prices << flight_price.text.sub('$', '').sub(',', '').to_i
    end
    all_prices
  end


end