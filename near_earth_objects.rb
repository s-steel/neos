require 'json'
require 'faraday'
require 'figaro'
require 'pry'
require_relative 'nasa_api_service'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects
  def self.find_neos_by_date(date)
    parsed_asteroids_data = NasaApiService.new.get_asteroid_data(date)
    
    {
      astroid_list: formatted_asteroid_data(parsed_asteroids_data),
      biggest_astroid: largest_astroid_diameter(parsed_asteroids_data),
      total_number_of_astroids: total_number_of_astroids(parsed_asteroids_data)
    }
  end
end

def largest_astroid_diameter(parsed_asteroids_data)
  parsed_asteroids_data.map do |astroid|
    astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
  end.max { |a,b| a<=> b}
end 

def total_number_of_astroids(parsed_asteroids_data)
  parsed_asteroids_data.count
end 

def formatted_asteroid_data(parsed_asteroids_data)
  parsed_asteroids_data.map do |astroid|
    {
      name: astroid[:name],
      diameter: "#{astroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
      miss_distance: "#{astroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
    }
  end
end 