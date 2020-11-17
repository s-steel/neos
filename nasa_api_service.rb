class NasaApiService

    def get_asteroid_data(date)
        conn = Faraday.new(
            url: 'https://api.nasa.gov',
            params: { start_date: date, api_key: ENV['nasa_api_key']}
            )
        asteroids_list_data = conn.get('/neo/rest/v1/feed')

        parse_data(asteroids_list_data, date)
    end 

    def parse_data(response, date)
        JSON.parse(response.body, symbolize_names: true)[:near_earth_objects][:"#{date}"]
    end 

end 