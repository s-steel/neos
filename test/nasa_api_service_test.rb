require 'minitest/autorun'
require 'minitest/pride'
require './nasa_api_service'
require 'json'
require 'faraday'
require 'pry'
require './near_earth_objects'

class NasaApiServiceTest < Minitest::Test
  def test_get_asteroid_data
    results = NasaApiService.new.get_asteroid_data('2020-10-10')
    assert_equal 12, results.length
    assert_equal '(2007 EO88)', results[0][:name]
  end
end