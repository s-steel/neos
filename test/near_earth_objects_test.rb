require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './near_earth_objects'
require './nasa_api_service'

class NearEarthObjectsTest < Minitest::Test
  def test_a_date_returns_a_list_of_neos
    results = NearEarthObjects.find_neos_by_date('2019-03-31')
    assert_equal '163081 (2002 AG29)', results[:astroid_list][0][:name]
  end

  def test_largest_asteroid_diameter
    parsed_asteroids_data = NasaApiService.new.get_asteroid_data('2019-03-31')

    assert_equal 3890, largest_astroid_diameter(parsed_asteroids_data)
  end

  def test_total_number_of_asteroids
    parsed_asteroids_data = NasaApiService.new.get_asteroid_data('2019-03-31')

    assert_equal 19, total_number_of_astroids(parsed_asteroids_data)
  end

  def test_formatted_astroid_data
    parsed_asteroids_data = NasaApiService.new.get_asteroid_data('2019-03-31')
    first = {:name=>'163081 (2002 AG29)', :diameter=>'3890 ft', :miss_distance=>'9158224 miles'}
    last = {:name=>'(2019 GP21)', :diameter=>'21 ft', :miss_distance=>'221197 miles'}
  
    assert_equal first, formatted_asteroid_data(parsed_asteroids_data).first
    assert_equal last, formatted_asteroid_data(parsed_asteroids_data).last
  end 
end
